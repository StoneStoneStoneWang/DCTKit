//
//  CATSettingBridge.swift
//  CATBridge
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import CATTable
import RxDataSources
import CATCocoa
import CATCache

@objc(CATSettingActionType)
public enum CATSettingActionType: Int ,Codable {
    
    case gotoFindPassword = 0
    
    case gotoModifyPassword = 1
    
    case logout = 2
    
    case unlogin = 3
    
    case black = 4
}

public typealias CATSettingAction = (_ action: CATSettingActionType ) -> ()

@objc (CATSettingBridge)
public final class CATSettingBridge: CATBaseBridge {
    
    typealias Section = CATSectionModel<(), CATSettingBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: CATSettingViewModel!
    
    weak var vc: CATTableNoLoadingViewController!
}
extension CATSettingBridge {
    
    @objc public func createSetting(_ vc: CATTableNoLoadingViewController ,hasSpace: Bool,settingAction: @escaping CATSettingAction) {
        
        self.vc = vc
        
        let input = CATSettingViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(CATSettingBean.self),
                                                itemSelect: vc.tableView.rx.itemSelected, hasSpace: hasSpace)
        
        viewModel = CATSettingViewModel(input)
        
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
                    
                    if CATAccountCache.default.isLogin() {
                        
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
        
        viewModel.output.tableData.accept(CATSettingBean.createTabledata(hasPlace))
    }
}
extension CATSettingBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].type.cellHeight
    }
}
