//
//  DCTRegViewModel.swift
//  DCTBridge
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DCTViewModel
import RxCocoa
import RxSwift
import DCTResult
import DCTCheck
import DCTApi
import DCTRReq
import DCTBean
import DCTCache

public struct DCTRegViewModel: DCTViewModel {
    
    public var input: WLInput
    
    public var output: WLOutput
    
    public struct WLInput {
        /* 用户名 序列*/
        let username: Driver<String>
        /* 验证码 序列*/
        let vcode:Driver<String>
        /* 登录按钮点击 序列*/
        let loginTaps:Signal<Void>
        /* 验证码点击 序列*/
        let verifyTaps: Signal<Void>
        /* 已有账号，返回登录按钮点击 序列*/
        let backLoginTaps: Signal<Void>
        /* 协议 序列*/
        let proTaps: Signal<Void>
        
        let passwordItemSelected: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
        /* 定时器 序列*/
        let timer: Observable<Int> = Observable<Int>.timer(0, period: 1, scheduler: MainScheduler.instance)
    }
    
    public struct WLOutput {
        /* 登录中 序列*/
        let logining: Driver<Void>
        /* 登录结果  本地判断手机号是否合法、验证码是否合法 之后我再进行网络请求 序列*/
        let logined: Driver<DCTResult>
        /* 获取验证码中 序列*/
        let verifying: Driver<Void>
        /* 获取验证码结果 序列*/
        let verifyed: Driver<DCTResult>
        
        let backLogin: Driver<Void>
        /*  协议... 序列*/
        let pro: Driver<Void>
        
        @available(*, deprecated, message: "Please use smsRelay")
        let sms: Variable<(Bool,String)> = Variable<(Bool,String)>((true,"获取验证码"))
        
        let smsRelay: BehaviorRelay<(Bool,String)> = BehaviorRelay<(Bool,String)>(value: (true,"获取验证码"))
        
    }
    
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let usernameAndVcode = Driver.combineLatest(input.username, input.vcode)
        
        let logining: Driver<Void> = input.loginTaps.flatMap { Driver.just($0) }
        
        
        // 登录完成返回
        let logined: Driver<DCTResult> = input.loginTaps.withLatestFrom(usernameAndVcode).flatMapLatest {
            
            switch DCTCheckUsernameAndVCode($0.0, vcode: $0.1) {
            case .ok:
                
                return DCTDictResp(DCTApi.swiftLogin($0.0, code: $0.1))
                    .mapObject(type: DCTAccountBean.self)
                    .map({ DCTAccountCache.default.saveAccount(acc: $0) }) // 存储account
                    .map({ $0.toJSON()})
                    .mapObject(type: DCTUserBean.self)
                    .map({ DCTUserInfoCache.default.saveUser(data: $0) })
                    .map({ _ in DCTResult.logined })
                    .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! WLBaseError).description.0)) })
                
            case let .failed(message: msg): return Driver<DCTResult>.just(DCTResult.failed(msg))
                
            default: return Driver<DCTResult>.empty()
            }
        }
        
        let backLogin = input.backLoginTaps.flatMapLatest { Driver.just($0)  }
        
        let verifying: Driver<Void> = input.verifyTaps.flatMap { Driver.just($0) }
        
        let verifyed: Driver<DCTResult> = input
            .verifyTaps
            .withLatestFrom(input.username)
            .flatMapLatest({ (username) in
                
                switch DCTCheckUsername(username) {
                case .ok:
                    //
                    let result: Observable<DCTResult> = Observable<DCTResult>.create({ (ob) -> Disposable in
                        DCTVoidResp(DCTApi.smsCode(username))
                            .subscribe(onNext: { (_) in
                                
                                ob.onNext(DCTResult.ok("验证码已发送到您的手机，请注意查收"))
                                
                                let duration: Int = 60
                                
                                input.timer
                                    .map({ duration - $0 })
                                    .take(61)
                                    .map({ smsResult(count: $0) })
                                    .map({ DCTResult.smsOk(isEnabled: $0, title: $1)})
                                    .subscribe(onNext: { ob.onNext($0) })
                                    .disposed(by: disposed)
                                
                            }, onError: { (error) in
                                
                                ob.onError(error)
                                
                            })
                            .disposed(by: disposed)
                        
                        return Disposables.create { }
                    })
                    
                    return result.asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! WLBaseError).description.0)) })
                    
                case let .failed(message: msg): return Driver<DCTResult>.just(DCTResult.failed( msg))
                    
                default: return Driver<DCTResult>.empty()
                    
                }
            })
        
        let pro = input.proTaps.flatMap { Driver.just($0)}
        
        self.output = WLOutput( logining: logining, logined: logined, verifying: verifying, verifyed: verifyed, backLogin: backLogin, pro: pro)
    }
}

