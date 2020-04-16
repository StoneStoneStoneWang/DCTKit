//
//  CATCommentBridge.swift
//  CATBridge
//
//  Created by three stone 王 on 2019/9/11.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import CATTable
import RxDataSources
import CATCocoa
import CATBean
import CATHud
import MJRefresh

@objc (CATCommentBridge)
public final class CATCommentBridge: CATBaseBridge {
    
    typealias Section = CATAnimationSetionModel<CATCommentBean>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<Section>!
    
    var viewModel: CATCommentViewModel!
    
    weak var vc: CATTableLoadingViewController!
    
    var circleBean: CATCircleBean!
}
extension CATCommentBridge {
    
    @objc public func createComment(_ vc: CATTableLoadingViewController,encode: String ,circle: CATCircleBean) {
        
        self.vc = vc
        
        self.circleBean = circle
        
        let input = CATCommentViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(CATCommentBean.self),
                                              itemSelect: vc.tableView.rx.itemSelected,
                                              headerRefresh: vc.tableView.mj_header!.rx.CATRefreshing.asDriver(),
                                              footerRefresh: vc.tableView.mj_footer!.rx.CATRefreshing.asDriver(),
                                              encoded: encode)
        
        viewModel = CATCommentViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .left),
            decideViewTransition: { _,_,_  in return .reload },
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)})
        
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
                
                vc.tableViewSelectData(type, for: ip)
                
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
    @objc public func insertComment(_ comment: CATCommentBean) {
        
        var value = self.viewModel.output.tableData.value
        
        if value.last!.type == .empty {
            
            value.removeLast()
            
            value.insert(comment, at: 2)
            
            self.viewModel.output.tableData.accept(value)
            
        } else if value.last!.type == .failed {
            
            self.vc.tableView.mj_header!.beginRefreshing()
            
        } else {
            
            value.insert(comment , at: 2)
            
            self.viewModel.output.tableData.accept(value)
        }
        
        self.vc.tableView.scrollsToTop = true

    }
    @objc public func addComment(_ encoded: String,content: String ,commentAction: @escaping (_ comment: CATCommentBean? ,_ circleBean: CATCircleBean) -> () ) {
        
        CATHud.show(withStatus: "发布评论中....")
        
        CATCommentViewModel
            .addComment(encoded, content: content)
            .drive(onNext: { [unowned self](result) in
                
                CATHud.pop()
                
                switch result {
                case .operation(let comment):
                    
                    CATHud.showInfo("发布评论成功!")
                    
                    self.circleBean.countComment += 1
                    
                    commentAction(comment as? CATCommentBean ,self.circleBean)

                case .failed(let msg):
                    
                    CATHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
}

extension CATCommentBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return vc.caculate(forCell: datasource[indexPath], for: indexPath)
    }
}
