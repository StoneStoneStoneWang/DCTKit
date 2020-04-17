//
//  DCTTableSectionBridge.swift
//  DCTBridge
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import DCTTable
import RxCocoa
import RxSwift
import RxDataSources
import DCTCocoa

public typealias DCTTableSectionAction = (_ item: DCTTableRowBean ,_ ip: IndexPath) -> ()

@objc (DCTTableSectionBridge)
public final class DCTTableSectionBridge: DCTBaseBridge {
    
    var viewModel: DCTTableSectionViewModel!
    
    typealias Section = DCTSectionModel<DCTTableSectionBean, DCTTableRowBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var vc: DCTTableNoLoadingViewController!
    
}

extension DCTTableSectionBridge {
    
    @objc public func createTableSection(_ vc: DCTTableNoLoadingViewController ,sections: [DCTTableSectionBean],sectionAction: @escaping DCTTableSectionAction ) {
        
        self.vc = vc
        
        let input = DCTTableSectionViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(DCTTableRowBean.self),
                                                     itemSelect: vc.tableView.rx.itemSelected,
                                                     sections: sections)
        
        viewModel = DCTTableSectionViewModel(input)
        
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
extension DCTTableSectionBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let dataSource = dataSource else { return 0}
        
        return vc.caculate(forCell: dataSource[indexPath], for: indexPath)
    }
}
