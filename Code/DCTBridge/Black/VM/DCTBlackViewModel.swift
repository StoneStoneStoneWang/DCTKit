//
//  DCTBlackViewModel.swift
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
import DCTRReq
import DCTBean
import DCTApi
import DCTError
import DCTOM

public struct DCTBlackViewModel: DCTViewModel {
    
    public var input: WLInput
    
    public var output: WLOutput
    
    public struct WLInput {
        
        let modelSelect: ControlEvent<DCTBlackBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let headerRefresh: Driver<Void>
    }
    
    public struct WLOutput {
        
        let zip: Observable<(DCTBlackBean,IndexPath)>
        
        let tableData: BehaviorRelay<[DCTBlackBean]> = BehaviorRelay<[DCTBlackBean]>(value: [])
        
        let endHeaderRefreshing: Driver<DCTResult>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let headerRefreshData = input
            .headerRefresh
            .startWith(())
            .flatMapLatest({_ in

                return DCTArrayResp(DCTApi.fetchBlackList)
                    .mapArray(type: DCTBlackBean.self)
                    .map({ return $0.count > 0 ? DCTResult.fetchList($0) : DCTResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! DCTError).description.0)) })
            })
        
        let endHeaderRefreshing = headerRefreshData.map { $0 }
        
        let output = WLOutput(zip: zip, endHeaderRefreshing: endHeaderRefreshing)
        
        headerRefreshData
            .drive(onNext: { (result) in
                
                switch result {
                case let .fetchList(items):
                    
                    output.tableData.accept(items as! [DCTBlackBean])
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
        self.output = output
    }
}
extension DCTBlackViewModel {
    
    static func removeBlack(_ encode: String) -> Driver<DCTResult> {
        
        return DCTVoidResp(DCTApi.removeBlack(encode))
            .flatMapLatest({ return Driver.just(DCTResult.ok("移除成功")) })
            .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! DCTError).description.0)) })
    }
}
