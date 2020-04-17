//
//  DCTCollectionsBridge.swift
//  DCTBridge
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DCTCollection
import RxDataSources
import DCTCocoa
import DCTBean
import DCTHud
import DCTCache

@objc(DCTCollectionsActionType)
public enum DCTCollectionsActionType: Int ,Codable {
    
    case myCircle = 0
    
    case circle = 1
    
    case comment = 2
    
    case watch = 3
    
    case report = 4
    
    case unLogin = 5
    
    case like = 6
    
    case focus = 7
    
    case black = 8
    
    case remove = 9
    
    case share = 10
}

public typealias DCTCollectionsAction = (_ actionType: DCTCollectionsActionType ,_ circle: DCTCircleBean? ,_ ip: IndexPath?) -> ()

@objc (DCTCollectionsBridge)
public final class DCTCollectionsBridge: DCTBaseBridge {
    
    typealias Section = DCTAnimationSetionModel<DCTCircleBean>
    
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: DCTCollectionsViewModel!
    
    weak var vc: DCTCollectionLoadingViewController!
}

extension DCTCollectionsBridge {
    
    @objc public func createCollections(_ vc: DCTCollectionLoadingViewController ,moreSection: Bool,isMy: Bool ,tag: String ,collectionsAction: @escaping DCTCollectionsAction) {
        
        self.vc = vc
        
        let input = DCTCollectionsViewModel.WLInput(isMy: isMy,
                                                    modelSelect: vc.collectionView.rx.modelSelected(DCTCircleBean.self),
                                                    itemSelect: vc.collectionView.rx.itemSelected,
                                                    headerRefresh: vc.collectionView.mj_header!.rx.DCTRefreshing.asDriver(),
                                                    footerRefresh: vc.collectionView.mj_footer!.rx.DCTRefreshing.asDriver(),
                                                    tag: tag)
        
        viewModel = DCTCollectionsViewModel(input, disposed: disposed)
        
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { ds, tv, ip, item in return vc.configCollectionViewCell(item, for: ip) })
        
        if moreSection {
            
            viewModel
                .output
                .collectionData
                .asDriver()
                .map({ $0.map({ Section(header: $0.encoded, items: [$0]) }) })
                .drive(vc.collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposed)
        } else {
            
            viewModel
                .output
                .collectionData
                .map({ [Section(header: "", items: $0)] })
                .bind(to: vc.collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposed)
        }
        
        let endHeaderRefreshing = viewModel.output.endHeaderRefreshing
        
        endHeaderRefreshing
            .map({ _ in return true })
            .drive(vc.collectionView.mj_header!.rx.DCTEndRefreshing)
            .disposed(by: disposed)
        
        endHeaderRefreshing
            .drive(onNext: { (res) in
                switch res {
                case .fetchList:
                    vc.loadingStatus = .succ
                case let .failed(msg):
                    DCTHud.showInfo(msg)
                    vc.loadingStatus = .fail
                    
                case .empty:
                    vc.loadingStatus = .succ
                    
                    vc.collectionEmptyShow()
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
        let endFooterRefreshing = viewModel.output.endFooterRefreshing
        
        endFooterRefreshing
            .map({ _ in return true })
            .drive(vc.collectionView.mj_footer!.rx.DCTEndRefreshing)
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (circle,ip) in
                
                collectionsAction(isMy ? .myCircle : .circle, circle, ip)
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .footerHidden
            .bind(to: vc.collectionView.mj_footer!.rx.isHidden)
            .disposed(by: disposed)
    }
}

extension DCTCollectionsBridge {
    
    @objc public func insertCollectionData(_ collectionData: DCTCircleBean) {
        
        var values = viewModel.output.collectionData.value
        
        values.insert(collectionData, at: 0)
        
        viewModel.output.collectionData.accept(values)
    }
    
    @objc public func fetchObj(_ ip: IndexPath) -> DCTCircleBean? {
        
        guard let dataSource = dataSource else { return nil }
        
        return dataSource[ip]
    }
    
    @objc public func fetchIp(_ circle: DCTCircleBean) -> IndexPath {
        
        let values = viewModel.output.collectionData.value
        
        if let idx = values.firstIndex(where: { $0.encoded == circle.encoded }) {
            
            return IndexPath(item: 0, section: idx)
        }
        return IndexPath(item: 0, section: 0)
        
    }
    @objc public func converToJson(_ circle: DCTCircleBean) -> [String: Any] {
        
        return circle.toJSON()
    }
    
    @objc public func deleteIp(_ ip: IndexPath,moreSection: Bool) {
        
        var values = self.viewModel.output.collectionData.value
        
        if moreSection {
            
            values.remove(at: ip.section)
        } else {
            
            values.remove(at: ip.row)
        }
        
        self.viewModel.output.collectionData.accept(values)

        if values.isEmpty {

            self.vc.collectionEmptyShow()
        }
    }
    
    @objc public func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String ,collectionsAction: @escaping DCTCollectionsAction ) {
        
        if !DCTAccountCache.default.isLogin() {
            
            collectionsAction(.unLogin, nil,nil)
            
            return
        }
        
        DCTHud.show(withStatus: "添加黑名单中...")
        
        DCTCollectionsViewModel
            .addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content)
            .drive(onNext: { (result) in
                
                DCTHud.pop()
                
                switch result {
                case .ok(let msg):
                    
                    self.vc.collectionView.mj_header!.beginRefreshing()
                    
                    collectionsAction(.black, nil, nil)
                    
                    DCTHud.showInfo(msg)
                case .failed(let msg):
                    
                    DCTHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    
    @objc public func focus(_ uid: String ,encode: String ,isFocus: Bool ,collectionsAction: @escaping DCTCollectionsAction ) {
        
        if !DCTAccountCache.default.isLogin() {
            
            collectionsAction(.unLogin, nil,nil)
            
            return
        }
        
        DCTHud.show(withStatus: isFocus ? "取消关注中..." : "关注中...")
        
        DCTCollectionsViewModel
            .focus(uid, encode: encode)
            .drive(onNext: { (result) in
                
                DCTHud.pop()
                
                switch result {
                case .ok(_):
                    
                    let values = self.viewModel.output.collectionData.value
                    
                    if let index = values.firstIndex(where: { $0.encoded == encode }) {
                        
                        let circle = values[index]
                        
                        circle.isattention = !circle.isattention
                        
                        self.viewModel.output.collectionData.accept(values)
                        
                        collectionsAction(.focus, circle,nil)
                    }
                    
                    DCTHud.showInfo(isFocus ? "取消关注成功" : "关注成功")
                    
                case .failed(let msg):
                    
                    DCTHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
    }
    
    @objc public func operation(_ encoded: String ,isLike: Bool ,status: String ,aMsg: String,collectionsAction: @escaping () -> () ) {
        
        DCTHud.show(withStatus: status)
        
        DCTCollectionsViewModel
            .like(encoded, isLike: isLike)
            .drive(onNext: { (result) in
                
                DCTHud.pop()
                
                switch result {
                case .ok(_):
                    
                    collectionsAction()
                    
                    DCTHud.showInfo(aMsg)
                case .failed(let msg):
                    
                    DCTHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    
    @objc public func like(_ encoded: String ,isLike: Bool ,collectionsAction: @escaping DCTCollectionsAction) {
        
        if !DCTAccountCache.default.isLogin() {
            
            collectionsAction(.unLogin, nil,nil)
            
            return
        }
        
        DCTHud.show(withStatus: isLike ? "取消点赞中..." : "点赞中...")
        
        DCTCollectionsViewModel
            .like(encoded, isLike: isLike)
            .drive(onNext: { (result) in
                
                DCTHud.pop()
                
                switch result {
                case .ok(let msg):
                    
                    let values = self.viewModel.output.collectionData.value
                    
                    if let index = values.firstIndex(where: { $0.encoded == encoded }) {
                        
                        let circle = values[index]
                        
                        circle.isLaud = !circle.isLaud
                        
                        if isLike { circle.countLaud -= 1 }
                        else { circle.countLaud += 1}
                        
                        self.viewModel.output.collectionData.accept(values)
                        
                        collectionsAction(.like, circle,nil)
                    }
                    
                    DCTHud.showInfo(msg)
                case .failed(let msg):
                    
                    DCTHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    
    @objc public func removeMyCircle(_ encoded: String ,ip: IndexPath,collectionsAction: @escaping DCTCollectionsAction)  {
        
        DCTHud.show(withStatus: "移除内容中...")
        
        DCTCollectionsViewModel
            .removeMyCircle(encoded)
            
            .drive(onNext: { [weak self] (result) in
                
                guard let `self` = self else { return }
                switch result {
                case .ok:
                    
                    DCTHud.pop()
                    
                    DCTHud.showInfo("移除当前内容成功")
                    
                    var value = self.viewModel.output.collectionData.value
                    
                    let circle = value[ip.row]
                    
                    value.remove(at: ip.row)
                    
                    self.viewModel.output.collectionData.accept(value)
                    
                    if value.isEmpty {
                        
                        self.vc.collectionEmptyShow()
                    }
                    
                    collectionsAction(.remove, circle, ip)
                case .failed:
                    
                    DCTHud.pop()
                    
                    DCTHud.showInfo("移除当前内容失败")
                    
                default: break
                    
                }
            })
            .disposed(by: self.disposed)
    }
}
