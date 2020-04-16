//
//  DCTNameBridge.swift
//  DCTBridge
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DCTBase
import DCTHud
import DCTBean
import RxCocoa
import DCTCache
import RxSwift

@objc(DCTNameActionType)
public enum DCTNameActionType: Int ,Codable {
    
    case name = 0
    
    case back = 1
}

public typealias DCTNameAction = (_ action: DCTNameActionType ) -> ()

@objc (DCTNameBridge)
public final class DCTNameBridge: DCTBaseBridge {
    
    var viewModel: DCTNameViewModel!
    
    let nickname: BehaviorRelay<String> = BehaviorRelay<String>(value: DCTUserInfoCache.default.userBean.nickname)
}

extension DCTNameBridge {
    
    @objc public func createName(_ vc: DCTBaseViewController ,nameAction: @escaping DCTNameAction ) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton ,let name = vc.view.viewWithTag(201) as? UITextField ,let backItem = vc.navigationItem.leftBarButtonItem?.customView as? UIButton{
            
            let inputs = DCTNameViewModel.WLInput(orignal: nickname.asDriver(),
                                                       updated: name.rx.text.orEmpty.asDriver(),
                                                       completTaps: completeItem.rx.tap.asSignal())
            
            name.text = nickname.value
            
            viewModel = DCTNameViewModel(inputs)
            
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
                    
                    DCTHud.show(withStatus: "修改昵称中...")
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .completed
                .drive(onNext: { (result) in
                    
                    DCTHud.pop()
                    
                    switch result {
                    case let .updateUserInfoSucc(_, msg: msg):
                        
                        DCTHud.showInfo(msg)
                        
                        nameAction(.name)
                        
                    case let .failed(msg):
                        
                        DCTHud.showInfo(msg)
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
