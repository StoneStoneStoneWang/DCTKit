//
//  CATSignatureBridge.swift
//  CATBridge
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import CATBase
import CATHud
import CATCache
@objc(CATSignatureActionType)
public enum CATSignatureActionType: Int ,Codable {
    
    case signature = 0
    
    case back = 1
}

public typealias CATSignatureAction = (_ action: CATSignatureActionType ) -> ()

@objc (CATSignatureBridge)
public final class CATSignatureBridge: CATBaseBridge {
    
    var viewModel: CATSignatureViewModel!
    
    let signature: BehaviorRelay<String> = BehaviorRelay<String>(value: CATUserInfoCache.default.userBean.signature)
}

extension CATSignatureBridge {
    
    @objc public func createSignature(_ vc: CATBaseViewController ,signatureAction: @escaping CATSignatureAction ) {
        
        if let completeItem = vc.navigationItem.rightBarButtonItem?.customView as? UIButton ,let signaturetv = vc.view.viewWithTag(201) as? UITextView ,let backItem = vc.navigationItem.leftBarButtonItem?.customView as? UIButton ,let placeholder = vc.view.viewWithTag(202) {
            
            let inputs = CATSignatureViewModel.WLInput(orignal: signature.asDriver(),
                                                       updated: signaturetv.rx.text.orEmpty.asDriver(),
                                                       completTaps: completeItem.rx.tap.asSignal())
            
            signaturetv.text = signature.value
            
            viewModel = CATSignatureViewModel(inputs)
            
            viewModel
                .output
                .completeEnabled
                .drive(completeItem.rx.isEnabled)
                .disposed(by: disposed)
            
            viewModel
                .output
                .completing
                .drive(onNext: { (_) in
                    
                    CATHud.show(withStatus: "修改个性签名...")
                    
                    signaturetv.resignFirstResponder()
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
                        
                        signatureAction(.signature)
                        
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
