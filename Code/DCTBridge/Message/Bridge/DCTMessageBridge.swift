//
//  DCTMessageBridge.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/20.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import DCTCollection
import RxDataSources
import DCTCocoa
import RxCocoa
import RxSwift
import DCTBean

public typealias DCTMessageAction = (_ ip: IndexPath,_ message: DCTMessageBean) -> ()

@objc (DCTMessageBridge)
public final class DCTMessageBridge: DCTBaseBridge {
    
    typealias Section = DCTAnimationSetionModel<DCTMessageBean>
    
    var dataSource: RxCollectionViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: DCTMessageViewModel!
    
    weak var vc: DCTCollectionLoadingViewController!
    
}

extension DCTMessageBridge {
    
    @objc public func createMessage(_ vc: DCTCollectionLoadingViewController ,messageAction: @escaping DCTMessageAction ) {
        
        self.vc = vc
        
        let input = DCTMessageViewModel.WLInput(modelSelect: vc.collectionView.rx.modelSelected(DCTMessageBean.self),
                                                itemSelect: vc.collectionView.rx.itemSelected,
                                                headerRefresh: vc.collectionView.mj_header!.rx.DCTRefreshing.asDriver())
        
        viewModel = DCTMessageViewModel(input, disposed: disposed)
        
        let dataSource = RxCollectionViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { ds, tv, ip, item in return vc.configCollectionViewCell(item, for: ip) })
        
        viewModel
            .output
            .collectionData
            .asDriver()
            .map({ $0.map({ Section(header: "\($0.mid)", items: [$0]) }) })
            .drive(vc.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (message,ip) in
                
                messageAction(ip,message)
            })
            .disposed(by: disposed)
        
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
                    vc.loadingStatus = .fail
                    
                case .empty:
                    vc.loadingStatus = .succ
                    
                    vc.collectionEmptyShow()
                    
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    @objc public func messageRead(_ ip: IndexPath) {
        
        guard let datasource = dataSource else { return }
        
        let message = datasource[ip]
        
        message.isread = true
        
        vc.collectionView.reloadItems(at: [ip])
    }
}
extension DCTMessageBridge: UITableViewDelegate {
    
    @objc public func messageReadReq(_ message: DCTMessageBean ,_ ip: IndexPath) {
        
        DCTMessageViewModel
            .messageRead("\(message.mid)")
            .drive(onNext: { [unowned self] (result) in
                
                switch result {
                case .ok:
                    
                    self.messageRead(ip)
                default:
                    
                    break
                }
            })
            .disposed(by: disposed)
    }
    
    @objc public func fetchFirstMessage(_ messageAction: @escaping (_ message: DCTMessageBean) -> ()) {
        
        DCTMessageViewModel
            .fetchFirstMessage()
            .drive(onNext: { (result) in
                
                switch result {
                case .fetchList(let list):
                    
                    if list.count > 0{
                        
                        messageAction(list.first as! DCTMessageBean)
                    }
                default:
                    
                    break
                }
            })
            .disposed(by: disposed)
    }
}
