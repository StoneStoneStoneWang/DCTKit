//
//  DCTReportViewModel.swift
//  DCTBridge
//
//  Created by three stone 王 on 2019/9/9.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DCTViewModel
import RxCocoa
import RxSwift

import DCTResult
import ObjectMapper
import RxDataSources
import DCTApi
import DCTRReq
import DCTError

@objc public final class DCTReportBean: NSObject,IdentifiableType ,Mappable {
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


struct DCTReportViewModel: DCTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let reports: [[String: Any]]
        
        let modelSelect: ControlEvent<DCTReportBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let completeTaps: Signal<Void>
        
        let uid: String
        
        let encode: String
        
        /*  序列*/
        let report: Driver<String>
        
        let content: Driver<String>
    }
    
    struct WLOutput {
        
        let zip: Observable<(DCTReportBean,IndexPath)>
        
        let tableData: BehaviorRelay<[DCTReportBean]> = BehaviorRelay<[DCTReportBean]>(value: [])
        
        /* 完成中... 序列*/
        let completing: Driver<Void>
        /* 完成结果... 序列*/
        let completed: Driver<DCTResult>
    }
    
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let combine = Driver.combineLatest(input.report.asDriver(),input.content.asDriver())
        
        let completing = input.completeTaps.flatMap { Driver.just($0) }
        
        let completed: Driver<DCTResult> = input
            .completeTaps
            .withLatestFrom(combine)
            .flatMapLatest {

                return DCTVoidResp(DCTApi.report(input.uid, targetEncoded: input.encode, type: $0.0, content: $0.1))
                    .map({ _ in DCTResult.ok("举报成功") })
                    .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! DCTError).description.0)) })
        }
        
        let output = WLOutput(zip: zip, completing: completing, completed: completed)
        
        for item in input.reports {
            
            let res = DCTReportBean(JSON: item)
            
            output.tableData.accept( output.tableData.value + [res!])
        }
        
        self.output = output
    }
    
}
