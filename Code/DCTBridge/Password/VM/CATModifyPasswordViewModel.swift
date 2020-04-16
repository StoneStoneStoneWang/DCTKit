//
//  ZModifyPwdViewModel.swift
//  CATBridge
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLReqKit
import WLBaseResult
import CATApi
import CATRReq
import CATCheck

public struct CATModifyPasswordViewModel: WLBaseViewModel {
    
    public var input: WLInput
    
    public var output: WLOutput
    
    public struct WLInput {
        /* 旧密码 序列*/
        let oldpassword: Driver<String>
        /* 新密码 序列*/
        let password:Driver<String>
        /* 重复新密码 序列*/
        let passwordAgain:Driver<String>
        
        let completeTaps: Signal<Void>
    }
    
    public struct WLOutput {
        
        let completing: Driver<Void>
        
        let completed: Driver<WLBaseResult>
    }
    
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let opa = Driver.combineLatest(input.oldpassword, input.password ,input.passwordAgain)
        
        let completing: Driver<Void> = input.completeTaps.flatMap { Driver.just($0) }
        
        let completed: Driver<WLBaseResult> = input
            .completeTaps
            .withLatestFrom(opa)
            .flatMapLatest {
                
                switch CATCheckPasswordModify($0.0, password: $0.2, passwordAgain: $0.1) {
                case .ok: return CATVoidResp(CATApi.modifyPassword($0.0, password: $0.1))
                    .map({ WLBaseResult.ok("修改密码成功") })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
                    
                case let .failed(message: msg): return Driver<WLBaseResult>.just(WLBaseResult.failed( msg))
                default: return Driver<WLBaseResult>.empty()
                    
                }
        }
        
        self.output = WLOutput( completing: completing, completed: completed)
    }
}

