//
//  DCTMessageViewModel.swift
//  DCTBridge
//
//  Created by 王磊 on 2020/4/13.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import DCTViewModel
import RxCocoa
import RxSwift

import DCTResult
import DCTApi
import DCTBean
import DCTRReq

struct DCTMessageViewModel: DCTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<DCTMessageBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let headerRefresh: Driver<Void>
        
    }
    
    struct WLOutput {
        
        let zip: Observable<(DCTMessageBean,IndexPath)>
        
        let collectionData: BehaviorRelay<[DCTMessageBean]> = BehaviorRelay<[DCTMessageBean]>(value: [])
        
        let endHeaderRefreshing: Driver<DCTResult>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let headerRefreshData = input
            .headerRefresh
            .startWith(())
            .flatMapLatest({_ in
                return DCTArrayResp(DCTApi.fetchSystemMsg(1))
                    .mapArray(type: DCTMessageBean.self)
                    .map({ return $0.count > 0 ? DCTResult.fetchList($0) : DCTResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! WLBaseError).description.0)) })
            })
        
        let endHeaderRefreshing = headerRefreshData.map { $0 }
        
        let output = WLOutput(zip: zip, endHeaderRefreshing: endHeaderRefreshing)
        
        headerRefreshData
            .drive(onNext: { (result) in
                
                switch result {
                case let .fetchList(items):
                    
                    output.collectionData.accept(items as! [DCTMessageBean])
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
        self.output = output
    }
}
extension DCTMessageViewModel {
    
    static func messageRead(_ encode: String) -> Driver<DCTResult> {
        
        return DCTVoidResp(DCTApi.readMsg(encode))
            .flatMapLatest({ return Driver.just(DCTResult.ok("")) })
            .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! WLBaseError).description.0)) })
    }
    
    static func fetchFirstMessage() -> Driver<DCTResult> {
        
        return DCTArrayResp(DCTApi.fetchFirstMsg)
            .mapArray(type: DCTMessageBean.self)
            .flatMapLatest({ return Driver.just(DCTResult.fetchList($0)) })
            .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! WLBaseError).description.0)) })
    }
}
