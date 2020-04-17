//
//  DCTFeedBackViewModel.swift
//  DCTBridge
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import RxCocoa
import DCTError
import DCTViewModel
import WLToolsKit
import DCTResult
import DCTRReq
import DCTApi

struct DCTFeedBackViewModel: DCTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let feedBack: Driver<String>
        
        let phone:Driver<String>
        
        let completTaps:Signal<Void>
    }
    
    struct WLOutput {
        
        let completeEnabled: Driver<Bool>
        
        let completing: Driver<Void>
        
        let completed: Driver<DCTResult>
        
        let placeholderHidden: Driver<Bool>
    }
    
    init(_ input: WLInput) {
        
        self.input = input
        
        let ou = Driver.combineLatest(input.feedBack, input.phone)
        
        let completEnabled = ou.flatMapLatest { return Driver.just($0.0 != $0.1 && !$0.1.isEmpty && !$0.1.wl_isEmpty) }
        
        let completing: Driver<Void> = input.completTaps.flatMap { Driver.just($0) }
        
        let completed: Driver<DCTResult> = input.completTaps
            .withLatestFrom(ou)
            .flatMapLatest({
                
                return DCTVoidResp(DCTApi.feedback("yuanxingfu1314@163.com", content: $0.0))
                    .map { _ in DCTResult.ok("意见建议提交成功")}
                    .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! DCTError).description.0)) }) })
        
        let placeholderHidden: Driver<Bool> = input.feedBack.flatMapLatest { Driver.just(!$0.wl_isEmpty)}
        
        self.output = WLOutput(completeEnabled: completEnabled, completing: completing, completed: completed, placeholderHidden: placeholderHidden)
    }
}
