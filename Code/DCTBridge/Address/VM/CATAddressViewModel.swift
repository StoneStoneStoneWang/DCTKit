//
//  DCTAddressViewModel.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/20.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import DCTViewModel
import RxCocoa
import RxSwift

import DCTResult
import DCTApi
import DCTBean
import DCTRReq

struct DCTAddressViewModel: DCTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<DCTAddressBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let headerRefresh: Driver<Void>
        
        let itemAccessoryButtonTapped: Driver<IndexPath>
        
        let addItemTaps: Signal<Void>
    }
    
    struct WLOutput {
        
        let zip: Observable<(DCTAddressBean,IndexPath)>
        
        let tableData: BehaviorRelay<[DCTAddressBean]> = BehaviorRelay<[DCTAddressBean]>(value: [])
        
        let endHeaderRefreshing: Driver<DCTResult>
        
        let addItemed: Driver<Void>
        
        let itemAccessoryButtonTapped: Driver<IndexPath>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let headerRefreshData = input
            .headerRefresh
            .startWith(())
            .flatMapLatest({_ in
                return DCTArrayResp(DCTApi.fetchAddress)
                    .mapArray(type: DCTAddressBean.self)
                    .map({ return $0.count > 0 ? DCTResult.fetchList($0) : DCTResult.empty })
                    .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! WLBaseError).description.0)) })
            })
        
        let itemAccessoryButtonTapped: Driver<IndexPath> = input.itemAccessoryButtonTapped.map { $0 }
        
        let endHeaderRefreshing = headerRefreshData.map { $0 }
        
        let addItemed: Driver<Void> = input.addItemTaps.flatMap { Driver.just($0) }
        
        let output = WLOutput(zip: zip, endHeaderRefreshing: endHeaderRefreshing, addItemed: addItemed, itemAccessoryButtonTapped: itemAccessoryButtonTapped)
        
        headerRefreshData
            .drive(onNext: { (result) in
                
                switch result {
                case let .fetchList(items):
                    
                    output.tableData.accept(items as! [DCTAddressBean])
                    
                default: break
                }
            })
            .disposed(by: disposed)
        
        self.output = output
    }
}
extension DCTAddressViewModel {
    
    static func removeAddress(_ encode: String) -> Driver<DCTResult> {
        
        return DCTVoidResp(DCTApi.deleteAddress(encode))
            .flatMapLatest({ return Driver.just(DCTResult.ok("移除成功")) })
            .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! WLBaseError).description.0)) })
    }
}
