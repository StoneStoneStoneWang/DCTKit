//
//  CATTableSectionBridge.swift
//  CATBridge
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import CATTable
import RxCocoa
import RxSwift
import RxDataSources
import CATCocoa

public typealias CATTableSectionAction = (_ item: CATTableRowBean ,_ ip: IndexPath) -> ()

@objc (CATTableSectionBridge)
public final class CATTableSectionBridge: CATBaseBridge {
    
    var viewModel: CATTableSectionViewModel!
    
    typealias Section = CATSectionModel<CATTableSectionBean, CATTableRowBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var vc: CATTableNoLoadingViewController!
    
}

extension CATTableSectionBridge {
    
    @objc public func createTableSection(_ vc: CATTableNoLoadingViewController ,sections: [CATTableSectionBean],sectionAction: @escaping CATTableSectionAction ) {
        
        self.vc = vc
        
        let input = CATTableSectionViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(CATTableRowBean.self),
                                                     itemSelect: vc.tableView.rx.itemSelected,
                                                     sections: sections)
        
        viewModel = CATTableSectionViewModel(input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip) },
            titleForHeaderInSection: { ds ,section in return self.viewModel.output.tableData.value[section].title})
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .tableData
            .map({ $0.map({ Section(model: $0, items: $0.items) }) })
            .bind(to: vc.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (item,ip) in
                
                sectionAction(item, ip)
            })
            .disposed(by: disposed)
        
        vc.tableView.rx.setDelegate(self).disposed(by: disposed)
        
    }
}
extension CATTableSectionBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let dataSource = dataSource else { return 0}
        
        return vc.caculate(forCell: dataSource[indexPath], for: indexPath)
    }
}
