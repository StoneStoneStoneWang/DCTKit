//
//  DCTSettingBridge.swift
//  DCTBridge
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DCTTable
import RxDataSources
import DCTCocoa
import DCTCache

@objc(DCTSettingActionType)
public enum DCTSettingActionType: Int ,Codable {
    
    case gotoFindPassword = 0
    
    case gotoModifyPassword = 1
    
    case logout = 2
    
    case unlogin = 3
    
    case black = 4
}

public typealias DCTSettingAction = (_ action: DCTSettingActionType ) -> ()

@objc (DCTSettingBridge)
public final class DCTSettingBridge: DCTBaseBridge {
    
    typealias Section = DCTSectionModel<(), DCTSettingBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: DCTSettingViewModel!
    
    weak var vc: DCTTableNoLoadingViewController!
}
extension DCTSettingBridge {
    
    @objc public func createSetting(_ vc: DCTTableNoLoadingViewController ,hasSpace: Bool,settingAction: @escaping DCTSettingAction) {
        
        self.vc = vc
        
        let input = DCTSettingViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(DCTSettingBean.self),
                                                itemSelect: vc.tableView.rx.itemSelected, hasSpace: hasSpace)
        
        viewModel = DCTSettingViewModel(input)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in  return vc.configTableViewCell(item, for: ip) })
        
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
            .subscribe(onNext: { (type,ip) in
                
                vc.tableView.deselectRow(at: ip, animated: true)
                
                switch type.type {
                    
                case .pwd:
                    
                    settingAction(.gotoFindPassword)
                case .password:
                    
                    settingAction(.gotoModifyPassword)
                    
                case .logout:
                    settingAction(.logout)
                    
                case .black:
                    
                    if DCTAccountCache.default.isLogin() {
                        
                        settingAction(.black)
                        
                    } else {
                        
                        settingAction(.unlogin)
                        
                    }
                    
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
    
    @objc public func updateCache(_ value: String ) {
        
        let values = viewModel.output.tableData.value
        
        if let idx = values.firstIndex(where: { $0.type == .clear}) {
            
            viewModel.output.tableData.value[idx].subTitle = value
            
            vc.tableView.reloadRows(at: [IndexPath(row: idx, section: 0)], with: .none)
        }
    }
    
    @objc public func updateTableData(_ hasPlace: Bool) {
        
        viewModel.output.tableData.accept(DCTSettingBean.createTabledata(hasPlace))
    }
}
extension DCTSettingBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].type.cellHeight
    }
}
