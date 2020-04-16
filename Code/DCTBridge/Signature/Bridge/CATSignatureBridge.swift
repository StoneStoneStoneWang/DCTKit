//
//  DCTSignatureBridge.swift
//  DCTBridge
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import DCTBase
import DCTHud
import DCTCache
@objc(DCTSignatureActionType)
public enum DCTSignatureActionType: Int ,Codable {
    
    case signature = 0
    
    case back = 1
}

public typealias DCTSignatureAction = (_ action: DCTSignatureActionType ) -> ()

@objc (DCTSignatureBridge)
public final class DCTSignatureBridge: DCTBaseBridge {
    
    var viewModel: DCTSignatureViewModel!
    
    let signature: BehaviorRelay<String> = BehaviorRelay<String>(value: DCTUserInfoCache.default.userBean.signature)
}

extension DCTSignatureBridge {
    
    @objc public func createSignature(_ vc: DCTBaseViewController ,signatureAction: @escaping DCTSignatureAction ) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton ,let signaturetv = vc.view.viewWithTag(201) as? UITextView ,let backItem = vc.navigationItem.leftBarButtonItem?.customView as? UIButton ,let placeholder = vc.view.viewWithTag(202) {
            
            let inputs = DCTSignatureViewModel.WLInput(orignal: signature.asDriver(),
                                                       updated: signaturetv.rx.text.orEmpty.asDriver(),
                                                       completTaps: completeItem.rx.tap.asSignal())
            
            signaturetv.text = signature.value
            
            viewModel = DCTSignatureViewModel(inputs)
            
            viewModel
                .output
                .completeEnabled
                .drive(completeItem.rx.isEnabled)
                .disposed(by: disposed)
            
            viewModel
                .output
                .completing
                .drive(onNext: { (_) in
                    
                    DCTHud.show(withStatus: "修改个性签名...")
                    
                    signaturetv.resignFirstResponder()
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
                        
                        signatureAction(.signature)
                        
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
                    
                    signatureAction(.back)
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .placeholderHidden
                .drive(placeholder.rx.isHidden)
                .disposed(by: disposed)
        }
    }
}
