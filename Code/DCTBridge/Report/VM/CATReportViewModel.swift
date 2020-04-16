//
//  CATReportViewModel.swift
//  CATBridge
//
//  Created by three stone 王 on 2019/9/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import WLReqKit
import WLBaseResult
import ObjectMapper
import RxDataSources
import CATApi
import CATRReq

@objc public final class CATReportBean: NSObject,IdentifiableType ,Mappable {
    public init?(map: Map) {
        
        
    }
    
    public func mapping(map: Map) {
        
        title <- map["title"]
        
        isSelected <- map["isSelected"]
        
        type <- map["type"]
    }
    
    public var identity: String = NSUUID().uuidString
    
    public typealias Identity = String
    
    
    @objc public var title: String = ""
    
    @objc public var isSelected: Bool = false
    
    @objc public var type: String = ""
    
    private override init() { }
    
}


struct CATReportViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let reports: [[String: Any]]
        
        let modelSelect: ControlEvent<CATReportBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let completeTaps: Signal<Void>
        
        let uid: String
        
        let encode: String
        
        /*  序列*/
        let report: Driver<String>
        
        let content: Driver<String>
    }
    
    struct WLOutput {
        
        let zip: Observable<(CATReportBean,IndexPath)>
        
        let tableData: BehaviorRelay<[CATReportBean]> = BehaviorRelay<[CATReportBean]>(value: [])
        
        /* 完成中... 序列*/
        let completing: Driver<Void>
        /* 完成结果... 序列*/
        let completed: Driver<WLBaseResult>
    }
    
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let combine = Driver.combineLatest(input.report.asDriver(),input.content.asDriver())
        
        let completing = input.completeTaps.flatMap { Driver.just($0) }
        
        let completed: Driver<WLBaseResult> = input
            .completeTaps
            .withLatestFrom(combine)
            .flatMapLatest {

                return CATVoidResp(CATApi.report(input.uid, targetEncoded: input.encode, type: $0.0, content: $0.1))
                    .map({ _ in WLBaseResult.ok("举报成功") })
                    .asDriver(onErrorRecover: { return Driver.just(WLBaseResult.failed(($0 as! WLBaseError).description.0)) })
        }
        
        let output = WLOutput(zip: zip, completing: completing, completed: completed)
        
        for item in input.reports {
            
            let res = CATReportBean(JSON: item)
            
            output.tableData.accept( output.tableData.value + [res!])
        }
        
        self.output = output
    }
    
}
