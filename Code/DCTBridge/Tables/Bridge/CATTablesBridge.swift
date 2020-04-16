//
//  CATTablesBridge.swift
//  CATBridge
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import CATTable
import RxDataSources
import CATCocoa
import CATBean
import CATHud
import CATCache

@objc(CATTablesActionType)
public enum CATTablesActionType: Int ,Codable {
    
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

public typealias CATTablesAction = (_ actionType: CATTablesActionType ,_ circle: CATCircleBean? ,_ ip: IndexPath?) -> ()

@objc (CATTablesBridge)
public final class CATTablesBridge: CATBaseBridge {
    
    typealias Section = CATAnimationSetionModel<CATCircleBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: CATTablesViewModel!
    
    weak var vc: CATTableLoadingViewController!
    
    var tablesAction: CATTablesAction!
}
extension CATTablesBridge {
    
    @objc public func createTables(_ vc: CATTableLoadingViewController ,isMy: Bool ,tag: String ,tablesAction: @escaping CATTablesAction) {
        
        self.vc = vc
        
        self.tablesAction = tablesAction
        
        let input = CATTablesViewModel.WLInput(isMy: isMy,
                                            modelSelect: vc.tableView.rx.modelSelected(CATCircleBean.self),
                                            itemSelect: vc.tableView.rx.itemSelected,
                                            headerRefresh: vc.tableView.mj_header!.rx.CATRefreshing.asDriver(),
                                            footerRefresh: vc.tableView.mj_footer!.rx.CATRefreshing.asDriver(),
                                            tag: tag)
        
        viewModel = CATTablesViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)},
            canEditRowAtIndexPath: { _,_ in return isMy })
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ $0.map({ Section(header: $0.encoded, items: [$0]) }) })
            .drive(vc.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        let endHeaderRefreshing = viewModel.output.endHeaderRefreshing
        
        endHeaderRefreshing
            .map({ _ in return true })
            .drive(vc.tableView.mj_header!.rx.CATEndRefreshing)
            .disposed(by: disposed)
        
        endHeaderRefreshing
            .drive(onNext: { (res) in
                switch res {
                case .fetchList:
                    vc.loadingStatus = .succ
                case let .failed(msg):
                    CATHud.showInfo(msg)
                    vc.loadingStatus = .fail
                    
                case .empty:
                    vc.loadingStatus = .succ
                    
                    vc.tableViewEmptyShow()
                    
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
        let endFooterRefreshing = viewModel.output.endFooterRefreshing
        
        endFooterRefreshing
            .map({ _ in return true })
            .drive(vc.tableView.mj_footer!.rx.CATEndRefreshing)
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (type,ip) in
                
                tablesAction(isMy ? .myCircle : .circle,type,ip)
                
            })
            .disposed(by: disposed)
        
        viewModel
            .output
            .footerHidden
            .bind(to: vc.tableView.mj_footer!.rx.isHidden)
            .disposed(by: disposed)
        
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
    
    @objc public func updateCircle(_ circle: CATCircleBean ,ip: IndexPath) {
        
        var values = viewModel.output.tableData.value
        
        values.replaceSubrange(ip.row..<ip.row+1, with: [circle])
        
        viewModel.output.tableData.accept(values)
    }
    
    @objc public func insertCircle(_ circle: CATCircleBean) {
        
        var values = viewModel.output.tableData.value
        
        values.insert(circle, at: 0)
        
        if values.count == 1 {
            
            vc.tableViewEmptyHidden()
        }
        
        viewModel.output.tableData.accept(values)
    }
}

extension CATTablesBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return vc.caculate(forCell: datasource[indexPath], for: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { [weak self] (a, ip) in
            
            guard let `self` = self else { return }
            
            self.tablesAction(.remove,self.dataSource[indexPath] ,indexPath)
        }
        let cancel = UITableViewRowAction(style: .default, title: "取消") { (a, ip) in
    
        }
        
        return [cancel,delete]
    }
}

extension CATTablesBridge {
    
    @objc public func insertTableData(_ tableData: CATCircleBean) {
        
        var values = viewModel.output.tableData.value
        
        values.insert(tableData, at: 0)
        
        viewModel.output.tableData.accept(values)
    }
    
    @objc public func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String ,tablesAction: @escaping CATTablesAction) {
        
        if !CATAccountCache.default.isLogin() {
            
            tablesAction(.unLogin, nil,nil)
            
            return
        }
        
        CATHud.show(withStatus: "添加黑名单中...")
        
        CATTablesViewModel
            .addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content)
            .drive(onNext: { (result) in
                
                CATHud.pop()
                
                switch result {
                case .ok(let msg):
                    
                    self.vc.tableView.mj_header!.beginRefreshing()
                    
                    CATHud.showInfo(msg)
                    
                    tablesAction(.black, nil,nil)
                    
                case .failed(let msg):
                    
                    CATHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    @objc public func focus(_ uid: String ,encode: String ,isFocus: Bool,tablesAction: @escaping CATTablesAction) {
        
        if !CATAccountCache.default.isLogin() {
            
            tablesAction(.unLogin, nil,nil)
            
            return
        }
        
        CATHud.show(withStatus: isFocus ? "取消关注中..." : "关注中...")
        
        CATTablesViewModel
            .focus(uid, encode: encode)
            .drive(onNext: { (result) in
                
                CATHud.pop()
                
                switch result {
                case .ok:
                    
                    let values = self.viewModel.output.tableData.value
                    
                    if let index = values.firstIndex(where: { $0.encoded == encode }) {
                        
                        let circle = values[index]
                        
                        circle.isattention = !circle.isattention
                        
                        self.viewModel.output.tableData.accept(values)
                        
                        tablesAction(.focus, circle,nil)
                    }
                    
                    CATHud.showInfo(isFocus ? "取消关注成功" : "关注成功")
                case .failed(let msg):
                    
                    CATHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
    }
    @objc public func fetchIp(_ circle: CATCircleBean) -> IndexPath {
        
        let values = viewModel.output.tableData.value
        
        if let idx = values.firstIndex(where: { $0.encoded == circle.encoded }) {
            
            return IndexPath(item: 0, section: idx)
        }
        return IndexPath(item: 0, section: 0)
        
    }
    @objc public func converToJson(_ circle: CATCircleBean) -> [String: Any] {
        
        return circle.toJSON()
    }
    
    @objc public func like(_ encoded: String,isLike: Bool,tablesAction: @escaping CATTablesAction) {
        
        if !CATAccountCache.default.isLogin() {
            
            tablesAction(.unLogin, nil,nil)
            
            return
        }
        
        CATHud.show(withStatus: isLike ? "取消点赞中..." : "点赞中...")
        
        CATTablesViewModel
            .like(encoded, isLike: !isLike)
            .drive(onNext: { [unowned self] (result) in
                
                CATHud.pop()
                
                switch result {
                case .ok(let msg):
                    
                    let values = self.viewModel.output.tableData.value
                    
                    if let index = values.firstIndex(where: { $0.encoded == encoded }) {
                        
                        let circle = values[index]
                        
                        circle.isLaud = !circle.isLaud
                        
                        if isLike { circle.countLaud -= 1 }
                        else { circle.countLaud += 1}
                        
                        self.viewModel.output.tableData.accept(values)
                        
                        tablesAction(.like, circle,nil)
                    }
                    
                    CATHud.showInfo(msg)
                case .failed(let msg):
                    
                    CATHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    
    @objc public func removeMyCircle(_ encoded: String ,ip: IndexPath,tablesAction: @escaping CATTablesAction )  {
        
        CATHud.show(withStatus: "移除内容中...")

        CATTablesViewModel
            .removeMyCircle(encoded)

            .drive(onNext: { [weak self] (result) in

                guard let `self` = self else { return }
                switch result {
                case .ok:

                    CATHud.pop()

                    CATHud.showInfo("移除当前内容成功")

                    var value = self.viewModel.output.tableData.value

                    let circle = value[ ip.row]
                    
                    value.remove(at: ip.row)

                    self.viewModel.output.tableData.accept(value)

                    if value.isEmpty {

                        self.vc.tableViewEmptyShow()
                    }
                    
                    tablesAction(.remove, circle, ip)

                case .failed:

                    CATHud.pop()

                    CATHud.showInfo("移除当前内容失败")

                default: break

                }
            })
            .disposed(by: self.disposed)
    }
}
