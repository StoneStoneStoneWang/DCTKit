//
//  CATAreaHeaderViewModel.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/19.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import CATBean

@objc (CATAreaHeaderBean)
public class CATAreaHeaderBean: NSObject {
    
    @objc public var isSelected: Bool = false
    
    @objc public var areaBean: CATAreaBean!
}


struct CATAreaHeaderViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<CATAreaHeaderBean>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    
    struct WLOutput {
        
        let zip: Observable<(CATAreaHeaderBean,IndexPath)>
        
        let tableData: BehaviorRelay<[CATAreaHeaderBean]> = BehaviorRelay<[CATAreaHeaderBean]>(value: [])
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let output = WLOutput(zip: zip)
        
        self.output = output
    }
}
