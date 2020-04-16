//
//  CATAboutBridge.swift
//  CATBridge
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import CATTable
import RxDataSources
import CATCocoa

@objc (CATAboutBridge)
public final class CATAboutBridge: CATBaseBridge {
    
    typealias Section = CATSectionModel<(), CATAboutType>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: CATAboutViewModel!
}

extension CATAboutBridge {
    
    @objc public func createAbout(_ vc: CATTableNoLoadingViewController ,hasSpace: Bool) {
        
        let input = CATAboutViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(CATAboutType.self),
                                              itemSelect: vc.tableView.rx.itemSelected,
                                              hasSpace: hasSpace)
        
        viewModel = CATAboutViewModel(input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(CATAboutBean.createAbout(item, title: item.title, subTitle: item.subtitle), for: ip) })
        
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
                
                vc.tableViewSelectData(CATAboutBean.createAbout(item, title: item.title, subTitle: item.subtitle), for: ip)
            })
            .disposed(by: disposed)
        
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
    
}
extension CATAboutBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].cellHeight
    }
}
