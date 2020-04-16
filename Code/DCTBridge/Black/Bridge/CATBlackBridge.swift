//
//  CATBlackBridge.swift
//  CATBridge
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import CATTable
import RxDataSources
import CATCocoa
import CATBean
import CATHud

public typealias CATBlackAction = (_ blackBean: CATBlackBean ,_ ip: IndexPath) -> ()

@objc (CATBlackBridge)
public final class CATBlackBridge: CATBaseBridge {
    
    typealias Section = CATAnimationSetionModel<CATBlackBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    public var viewModel: CATBlackViewModel!
    
    weak var vc: CATTableLoadingViewController!
    
    var blackAction: CATBlackAction!
}
extension CATBlackBridge {
    
    @objc public func createBlack(_ vc: CATTableLoadingViewController ,_ blackAction:@escaping CATBlackAction) {
        
        self.blackAction = blackAction
        
        self.vc = vc
        
        vc.tableView.mj_footer?.isHidden = true
        
        let input = CATBlackViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(CATBlackBean.self),
                                              itemSelect: vc.tableView.rx.itemSelected,
                                              headerRefresh: vc.tableView.mj_header!.rx.CATRefreshing.asDriver())
        
        viewModel = CATBlackViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip) }
            ,canEditRowAtIndexPath: { _,_ in return true })
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ $0.map({ Section(header: $0.identity, items: [$0]) }) })
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
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (type,ip) in })
            .disposed(by: disposed)
        
        vc.tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
}
extension CATBlackBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return vc.caculate(forCell: datasource[indexPath], for: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "删除") { [weak self] (a, ip) in
            
            guard let `self` = self else { return }
            
            self.blackAction(self.dataSource[indexPath], ip)
            
        }
        
        let cancel = UITableViewRowAction(style: .default, title: "取消") { (a, ip) in
            
        }
        
        return [cancel,delete]
    }
    
    @objc public func removeBlack(_ blackBean: CATBlackBean ,_ ip: IndexPath ,_ blackAction: @escaping () -> ()) {
        
        CATHud.show(withStatus: "移除\(blackBean.users.nickname)中...")
        
        CATBlackViewModel
            .removeBlack(blackBean.identity)
            .drive(onNext: { [weak self] (result) in
                
                guard let `self` = self else { return }
                
                switch result {
                case .ok:
                    
                    CATHud.pop()
                    
                    CATHud.showInfo("移除\(blackBean.users.nickname)成功")
                    
                    var value = self.viewModel.output.tableData.value
                    
                    value.remove(at: ip.section)
                    
                    self.viewModel.output.tableData.accept(value)
                    
                    if value.isEmpty {
                        
                        self.vc.tableViewEmptyShow()
                    }
                    
                    blackAction()
                    
                case .failed:
                    
                    CATHud.pop()
                    
                    CATHud.showInfo("移除\(blackBean.users.nickname)失败")
                    
                default: break
                    
                }
            })
            .disposed(by: self.disposed)
    }
    
}
