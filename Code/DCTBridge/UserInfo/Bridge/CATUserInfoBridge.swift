//
//  CATUserInfoBridge.swift
//  CATBridge
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import CATTable
import CATHud
import CATBean
import RxCocoa
import CATCache
import RxSwift
import RxDataSources
import CATCocoa
import CATRReq
import CATUpload

public typealias CATUserInfoAction = () -> ()

@objc (CATUserInfoBridge)
public final class CATUserInfoBridge: CATBaseBridge {
    
    typealias Section = CATSectionModel<(), CATUserInfoBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var viewModel: CATUserInfoViewModel!
    
    weak var vc: CATTableNoLoadingViewController!
}

extension CATUserInfoBridge {
    
    @objc public func createUserInfo(_ vc: CATTableNoLoadingViewController ,hasSpace: Bool) {
        
        self.vc = vc
        
        let input = CATUserInfoViewModel.WLInput(modelSelect: vc.tableView.rx.modelSelected(CATUserInfoBean.self),
                                                 itemSelect: vc.tableView.rx.itemSelected,
                                                 hasSpace: hasSpace)
        
        viewModel = CATUserInfoViewModel(input, disposed: disposed)
        
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
    
    @objc public func updateUserInfo(_ type: CATUserInfoType,value: String ) {
        
        let values =  viewModel.output.tableData.value
        
        if let idx = values.firstIndex(where: { $0.type == type}) {
            
            self.vc.tableView.reloadRows(at: [IndexPath(row: idx, section: 0)], with: .fade)
        }
    }
    
    @objc public func updateUserInfo(type: CATUserInfoType,value: String,action: @escaping CATUserInfoAction) {
        
        CATHud.show(withStatus: "修改\(type.title)中...")
        
        CATUserInfoViewModel
            .updateUserInfo(type: type, value: value)
            .drive(onNext: { (result) in
                
                CATHud.pop()
                switch result {
                    
                case .ok(_):
                    
                    action()
                    
                    CATHud.showInfo(type == .header ? "上传头像成功" : "修改\(type.title)成功")
                    
                case .failed(let msg): CATHud.showInfo(msg)
                default: break
                }
            })
            .disposed(by: disposed)
    }
    @objc public func updateHeader(_ data: Data ,action: @escaping CATUserInfoAction) {
        
        CATHud.show(withStatus: "上传头像中...")
        
        CATUserInfoViewModel
            .fetchAliToken()
            .drive(onNext: { (result) in
                
                switch result {
                case .fetchSomeObject(let obj):
                    
                    DispatchQueue.global().async {
                        
                        CATUploadImgResp(data, file: "headerImg", param: obj as! CATALCredentialsBean)
                            .subscribe(onNext: { [weak self] (value) in
                                
                                guard let `self` = self else { return }
                                
                                DispatchQueue.main.async {
                                    
                                    self.updateUserInfo(type: CATUserInfoType.header, value: value, action: action)
                                }
                                
                                }, onError: { (error) in
                                    
                                    CATHud.pop()
                                    
                                    CATHud.showInfo("上传头像失败")
                            })
                            .disposed(by: self.disposed)
                    }
                    
                case let .failed(msg):
                    
                    CATHud.pop()
                    
                    CATHud.showInfo(msg)
                    
                default: break
                    
                }
            })
            .disposed(by: disposed)
    }
}
extension CATUserInfoBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let datasource = dataSource else { return 0}
        
        return datasource[indexPath].type.cellHeight
    }
}
