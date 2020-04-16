//
//  CATReportBridge.swift
//  CATBridge
//
//  Created by three stone 王 on 2019/9/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import CATTable
import RxDataSources
import CATCocoa
import CATHud
import RxCocoa
import RxSwift

@objc (CATReportBridge)
public final class CATReportBridge: CATBaseBridge {
    
    typealias Section = CATSectionModel<(), CATReportBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: CATReportViewModel!
    
    weak var vc: CATTableNoLoadingViewController!
    
    var selectedReport: BehaviorRelay<String> = BehaviorRelay<String>(value: "1")
}

extension CATReportBridge {
    
    @objc public func createReport(_ vc: CATTableNoLoadingViewController ,reports: [[String: Any]],uid: String,encoded: String ,textView: UITextView ,reportAction: @escaping () -> ()) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton {
            
            self.vc = vc
            
            let input = CATReportViewModel.WLInput(reports: reports,
                                                 modelSelect: vc.tableView.rx.modelSelected(CATReportBean.self),
                                                 itemSelect: vc.tableView.rx.itemSelected,
                                                 completeTaps: completeItem.rx.tap.asSignal(),
                                                 uid: uid,
                                                 encode: encoded,
                                                 report: selectedReport.asDriver(),
                                                 content: textView.rx.text.orEmpty.asDriver())
            
            viewModel = CATReportViewModel(input, disposed: disposed)
            
            let dataSource = RxTableViewSectionedReloadDataSource<Section>(
                configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)  })
            
            viewModel
                .output
                .tableData
                .asDriver()
                .map({ [Section(model: (), items: $0)]  })
                .drive(vc.tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposed)
            
            self.dataSource = dataSource
            
            viewModel
                .output
                .zip
                .subscribe(onNext: { [unowned self] (type,ip) in
                    
                    vc.view.endEditing(true)
                    
                    self.selectedReport.accept(type.type)
                    
                    let values = self.viewModel.output.tableData.value
                    
                    _ = values.map({ $0.isSelected = false })
                    
                    values[ip.row].isSelected = true
                    
                    self.viewModel.output.tableData.accept(values)
                })
                .disposed(by: disposed)
            
            vc
                .tableView
                .rx
                .setDelegate(self)
                .disposed(by: disposed)
            
            vc
                .tableView
                .rx
                .itemAccessoryButtonTapped
                .subscribe(onNext: { [unowned self] (ip) in
                    
                    self.selectedReport.accept("\(ip.section + 1)")
                    
                    let values = self.viewModel.output.tableData.value
                    
                    _ = values.map({ $0.isSelected = false })
                    
                    values[ip.row].isSelected = true
                    
                    self.viewModel.output.tableData.accept(values)
                })
                .disposed(by: disposed)
            
            // MARK: 举报点击中序列
            viewModel
                .output
                .completing
                .drive(onNext: { _ in
                    
                    vc.view.endEditing(true)
                    
                    CATHud.show(withStatus: "举报提交中...")
                    
                })
                .disposed(by: disposed)
            
            // MARK: 举报事件返回序列
            viewModel
                .output
                .completed
                .drive(onNext: {
                    
                    CATHud.pop()
                    
                    switch $0 {
                        
                    case let .failed(msg): CATHud.showInfo(msg)
                        
                    case .ok: reportAction()
                        
                    default: break
                    }
                })
                .disposed(by: disposed)
        }
        
    }
}
extension CATReportBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return vc.caculate(forCell: datasource[indexPath], for: indexPath)
    }
}
