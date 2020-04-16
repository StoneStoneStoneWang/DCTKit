//
//  DCTFeedBackBridge.swift
//  DCTBridge
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import DCTBase
import DCTHud

public typealias DCTFeedBackAction = () -> ()

@objc (DCTFeedBackBridge)
public final class DCTFeedBackBridge: DCTBaseBridge {
    
    var viewModel: DCTFeedBackViewModel!
}

extension DCTFeedBackBridge {
    
    @objc public func createFeedBack(_ vc: DCTBaseViewController ,feedBackAction: @escaping DCTFeedBackAction ) {
        
        if let feedBack = vc.view.viewWithTag(201) as? UITextView ,let placeholder = vc.view.viewWithTag(202) ,let phone = vc.view.viewWithTag(203) as? UITextField{
            
            var completeItem: UIButton!
            
            if let complete = vc.navigationItem.rightBarButtonItem?.customView as? UIButton  {
                
                completeItem = complete
            }
            if let complete = vc.view.viewWithTag(204) as? UIButton {
                
                completeItem = complete
            }
            
            if let completeItem = completeItem {
                
                let inputs = DCTFeedBackViewModel.WLInput(feedBack: feedBack.rx.text.orEmpty.asDriver(),
                                                          phone: phone.rx.text.orEmpty.asDriver(),
                                                          completTaps: completeItem.rx.tap.asSignal())
                
                viewModel = DCTFeedBackViewModel(inputs)
                
                viewModel
                    .output
                    .completeEnabled
                    .drive(completeItem.rx.isEnabled)
                    .disposed(by: disposed)
                
                viewModel
                    .output
                    .completing
                    .drive(onNext: { (_) in
                        
                        DCTHud.show(withStatus: "意见建议提交中...")
                        
                        vc.view.endEditing(true)
                    })
                    .disposed(by: disposed)
                
                viewModel
                    .output
                    .completed
                    .drive(onNext: { (result) in
                        
                        DCTHud.pop()
                        
                        switch result {
                        case let .ok(msg):
                            
                            DCTHud.showInfo(msg)
                            
                            feedBackAction()
                            
                        case let .failed(msg):
                            
                            DCTHud.showInfo(msg)
                        default: break
                            
                        }
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
    
}
