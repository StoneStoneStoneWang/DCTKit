//
//  DCTCollectionsViewModel.swift
//  DCTBridge
//
//  Created by three stone 王 on 2019/8/29.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DCTViewModel
import RxCocoa
import RxSwift

import DCTResult
import DCTBean
import DCTRReq
import DCTApi

struct DCTCollectionsViewModel: DCTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let isMy: Bool
        
        let modelSelect: ControlEvent<DCTCircleBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let headerRefresh: Driver<Void>
        
        let footerRefresh: Driver<Void>
        
        let page: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 1)
        
        let tag: String
    }
    
    struct WLOutput {
        
        let zip: Observable<(DCTCircleBean,IndexPath)>
        
        let collectionData: BehaviorRelay<[DCTCircleBean]> = BehaviorRelay<[DCTCircleBean]>(value: [])
        
        let endHeaderRefreshing: Driver<DCTResult>
        
        let endFooterRefreshing: Driver<DCTResult>
        
        let footerHidden: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let headerRefreshData = input
            .headerRefresh
            .flatMapLatest({_ in
  
                return DCTArrayResp(input.isMy ? DCTApi.fetchMyList(input.tag, page: 1) : DCTApi.fetchList(input.tag, page: 1))
                    .mapArray(type: DCTCircleBean.self)
                    .map({ return $0.count > 0 ? DCTResult.fetchList($0) : DCTResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! WLBaseError).description.0)) })
            })
        
        let endHeaderRefreshing = headerRefreshData.map { $0 }
        
        let footerRefreshData = input
            .footerRefresh
            .flatMapLatest({_ in
                
                return DCTArrayResp(input.isMy ? DCTApi.fetchMyList(input.tag, page: input.page.value) : DCTApi.fetchList(input.tag, page: input.page.value))
                    .mapArray(type: DCTCircleBean.self)
                    .map({ return $0.count > 0 ? DCTResult.fetchList($0) : DCTResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! WLBaseError).description.0)) })
            })
        
        let endFooterRefreshing = footerRefreshData.map { $0 }
        
        let output = WLOutput(zip: zip, endHeaderRefreshing: endHeaderRefreshing, endFooterRefreshing: endFooterRefreshing)
        
        headerRefreshData
            .drive(onNext: { (result) in
                
                switch result {
                case let .fetchList(items):
                    
                    if !items.isEmpty {
                        
                        input.page.accept(2)
                        
                        if items.count < 20 {
                            
                            output.footerHidden.accept(true)
                            
                            input.page.accept(1)
                        } else {
                            
                            output.footerHidden.accept(false)
                        }
                    } else {
                        
                        input.page.accept(1)
                        
                        output.footerHidden.accept(true)
                    }
                    
                    output.collectionData.accept(items as! [DCTCircleBean])
                    
                case .empty: output.collectionData.accept([])
                default: break
                }
            })
            .disposed(by: disposed)
        
        footerRefreshData
            .drive(onNext: { (result) in
                
                switch result {
                case let .fetchList(items):
                    
                    if !items.isEmpty {
                        
                        var page = input.page.value
                        
                        page += 1
                        
                        input.page.accept(page)
                        
                        if items.count < 20 {
                            
                            output.footerHidden.accept(true)
                            
                        } else {
                            
                            output.footerHidden.accept(false)
                        }
                    } else {
                        
                        output.footerHidden.accept(true)
                    }
                    
                    var values = output.collectionData.value
                    
                    values += items as! [DCTCircleBean]
                    
                    output.collectionData.accept(values )
                default: break
                }
            })
            .disposed(by: disposed)
        
        self.output = output
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
    static func removeMyCircle(_ encoded: String ) -> Driver<DCTResult> {
        
        return DCTVoidResp(DCTApi.deleteMyCircle(encoded))
            .map({ DCTResult.ok("删除成功！")  })
            .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! WLBaseError).description.0)) })
    }
}
