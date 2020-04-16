//
//  ZNickameViewModel.swift
//  CATBridge
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxCocoa
import WLReqKit
import WLBaseViewModel
import WLBaseResult
import CATRReq
import CATApi
import CATBean
import CATCache

struct CATNameViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let orignal: Driver<String>
        
        let updated:Driver<String>
        
        let completTaps:Signal<Void>
    }
    
    struct WLOutput {
        
        let completeEnabled: Driver<Bool>
        
        let completing: Driver<Void>
        
        let completed: Driver<WLBaseResult>
    }
    
    init(_ input: WLInput) {
        
        self.input = input
        
        let ou = Driver.combineLatest(input.orignal, input.updated)
        
        let completEnabled = ou.flatMapLatest { return Driver.just($0.0 != $0.1 && !$0.1.isEmpty && !$0.1.wl_isEmpty) }
        
        let completing: Driver<Void> = input.completTaps.flatMap { Driver.just($0) }
        
        let completed: Driver<WLBaseResult> = input.completTaps
            .withLatestFrom(input.updated)
            .flatMapLatest({
                return CATDictResp(CATApi.updateUserInfo("users.nickname", value: $0))
                    .mapObject(type: CATUserBean.self)
                    .map({ CATUserInfoCache.default.saveUser(data: $0) })
                    .map { WLBaseResult.updateUserInfoSucc($0, msg: "昵称修改成功")}
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) }) })
        
        self.output = WLOutput(completeEnabled: completEnabled, completing: completing, completed: completed)
    }
}
