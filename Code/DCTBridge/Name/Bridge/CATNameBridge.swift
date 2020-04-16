//
//  CATNameBridge.swift
//  CATBridge
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import CATBase
import CATHud
import CATBean
import RxCocoa
import CATCache
import RxSwift

@objc(CATNameActionType)
public enum CATNameActionType: Int ,Codable {
    
    case name = 0
    
    case back = 1
}

public typealias CATNameAction = (_ action: CATNameActionType ) -> ()

@objc (CATNameBridge)
public final class CATNameBridge: CATBaseBridge {
    
    var viewModel: CATNameViewModel!
    
    let nickname: BehaviorRelay<String> = BehaviorRelay<String>(value: CATUserInfoCache.default.userBean.nickname)
}

extension CATNameBridge {
    
    @objc public func createName(_ vc: CATBaseViewController ,nameAction: @escaping CATNameAction ) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton ,let name = vc.view.viewWithTag(201) as? UITextField ,let backItem = vc.navigationItem.leftBarButtonItem?.customView as? UIButton{
            
            let inputs = CATNameViewModel.WLInput(orignal: nickname.asDriver(),
                                                       updated: name.rx.text.orEmpty.asDriver(),
                                                       completTaps: completeItem.rx.tap.asSignal())
            
            name.text = nickname.value
            
            viewModel = CATNameViewModel(inputs)
            
            viewModel
                .output
                .completeEnabled
                .drive(completeItem.rx.isEnabled)
                .disposed(by: disposed)
            
            viewModel
                .output
                .completing
                .drive(onNext: { (_) in
                    
                    name.resignFirstResponder()
                    
                    CATHud.show(withStatus: "修改昵称中...")
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .completed
                .drive(onNext: { (result) in
                    
                    CATHud.pop()
                    
                    switch result {
                    case let .updateUserInfoSucc(_, msg: msg):
                        
                        CATHud.showInfo(msg)
                        
                        nameAction(.name)
                        
                    case let .failed(msg):
                        
                        CATHud.showInfo(msg)
                    default: break
                        
                    }
                })
                .disposed(by: disposed)
            
            backItem
                .rx
                .tap
                .subscribe(onNext: { (_) in
                    
                    nameAction(.back)
                })
                .disposed(by: disposed)
        }
    }
}
