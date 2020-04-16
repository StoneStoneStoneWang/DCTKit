//
//  DCTVideoViewModel.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/22.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import DCTViewModel
import RxCocoa
import RxSwift

import DCTResult
import DCTRReq
import DCTApi

struct DCTVideoViewModel: DCTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
    }
    
    struct WLOutput {
    
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        self.output = WLOutput()
    }
    
    static func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String) -> Driver<DCTResult> {
        
        return DCTVoidResp(DCTApi.addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content))
            .map({ _ in DCTResult.ok("添加黑名单成功")})
            .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! WLBaseError).description.0)) })
    }
    static func focus(_ uid: String ,encode: String) -> Driver<DCTResult> {
        
        return DCTVoidResp(DCTApi.focus(uid, targetEncoded: encode))
            .flatMapLatest({ return Driver.just(DCTResult.ok("关注或取消关注成功")) })
            .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! WLBaseError).description.0)) })
    }
    
    static func like(_ encoded: String ,isLike: Bool) -> Driver<DCTResult> {
        
        return DCTVoidResp(DCTApi.like(encoded))
            .flatMapLatest({ return Driver.just(DCTResult.ok( isLike ? "点赞成功" : "取消点赞成功")) })
            .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! WLBaseError).description.0)) })
    }
}
