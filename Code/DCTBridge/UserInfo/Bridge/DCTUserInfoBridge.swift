//
//  DCTUserInfoBridge.swift
//  DCTBridge
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DCTTable
import DCTHud
import DCTBean
import RxCocoa
import DCTCache
import RxSwift
import RxDataSources
import DCTCocoa
import DCTRReq
import DCTUpload

public typealias DCTUserInfoAction = () -> ()

@objc (DCTUserInfoBridge)
public final class DCTUserInfoBridge: DCTBaseBridge {
    
    typealias Section = DCTSectionModel<(), DCTUserInfoBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: DCTUserInfoViewModel!
    
    weak var vc: DCTTableNoLoadingViewController!
}

extension DCTUserInfoBridge {
    
    @objc public func createUserInfo(_ vc: DCTTableNoLoadingViewController ,hasSpace: Bool) {
        
        self.vc = vc
        
        let input = DCTUserInfoViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(DCTUserInfoBean.self),
                                                 itemSelect: vc.tableView.rx.itemSelected,
                                                 hasSpace: hasSpace)
        
        viewModel = DCTUserInfoViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)})
        
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
                
                vc.tableViewSelectData(type, for: ip)
            })
            .disposed(by: disposed)
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
    }
    
    @objc public func updateUserInfo(_ type: DCTUserInfoType,value: String ) {
        
        let values =  viewModel.output.tableData.value
        
        if let idx = values.firstIndex(where: { $0.type == type}) {
            
            self.vc.tableView.reloadRows(at: [IndexPath(row: idx, section: 0)], with: .fade)
        }
    }
    
    @objc public func updateUserInfo(type: DCTUserInfoType,value: String,action: @escaping DCTUserInfoAction) {
        
        DCTHud.show(withStatus: "修改\(type.title)中...")
        
        DCTUserInfoViewModel
            .updateUserInfo(type: type, value: value)
            .drive(onNext: { (result) in
                
                DCTHud.pop()
                switch result {
                    
                case .ok(_):
                    
                    action()
                    
                    DCTHud.showInfo(type == .header ? "上传头像成功" : "修改\(type.title)成功")
                    
                case .failed(let msg): DCTHud.showInfo(msg)
                default: break
                }
            })
            .disposed(by: disposed)
    }
    @objc public func updateHeader(_ data: Data ,action: @escaping DCTUserInfoAction) {
        
        DCTHud.show(withStatus: "上传头像中...")
        
        DCTUserInfoViewModel
            .fetchAliToken()
            .drive(onNext: { (result) in
                
                switch result {
                case .fetchSomeObject(let obj):
                    
                    DispatchQueue.global().async {
                        
                        DCTUploadImgResp(data, file: "headerImg", param: obj as! DCTALCredentialsBean)
                            .subscribe(onNext: { [weak self] (value) in
                                
                                guard let `self` = self else { return }
                                
                                DispatchQueue.main.async {
                                    
                                    self.updateUserInfo(type: DCTUserInfoType.header, value: value, action: action)
                                }
                                
                                }, onError: { (error) in
                                    
                                    DCTHud.pop()
                                    
                                    DCTHud.showInfo("上传头像失败")
                            })
                            .disposed(by: self.disposed)
                    }
                    
                case let .failed(msg):
                    
                    DCTHud.pop()
                    
                    DCTHud.showInfo(msg)
                    
                default: break
                    
                }
            })
            .disposed(by: disposed)
    }
}
extension DCTUserInfoBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].type.cellHeight
    }
}
