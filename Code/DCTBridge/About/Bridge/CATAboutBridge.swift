//
//  DCTAboutBridge.swift
//  DCTBridge
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DCTTable
import RxDataSources
import DCTCocoa

@objc (DCTAboutBridge)
public final class DCTAboutBridge: DCTBaseBridge {
    
    typealias Section = DCTSectionModel<(), DCTAboutType>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: DCTAboutViewModel!
}

extension DCTAboutBridge {
    
    @objc public func createAbout(_ vc: DCTTableNoLoadingViewController ,hasSpace: Bool) {
        
        let input = DCTAboutViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(DCTAboutType.self),
                                              itemSelect: vc.tableView.rx.itemSelected,
                                              hasSpace: hasSpace)
        
        viewModel = DCTAboutViewModel(input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(DCTAboutBean.createAbout(item, title: item.title, subTitle: item.subtitle), for: ip) })
        
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
            .subscribe(onNext: { (item,ip) in
                
                vc.tableView.deselectRow(at: ip, animated: true)
                
                vc.tableViewSelectData(DCTAboutBean.createAbout(item, title: item.title, subTitle: item.subtitle), for: ip)
            })
            .disposed(by: disposed)
        
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
    
}
extension DCTAboutBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].cellHeight
    }
}
