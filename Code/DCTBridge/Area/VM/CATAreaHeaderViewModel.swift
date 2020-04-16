//
//  DCTAreaHeaderViewModel.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/19.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import DCTBean

@objc (DCTAreaHeaderBean)
public class DCTAreaHeaderBean: NSObject {
    
    @objc public var isSelected: Bool = false
    
    @objc public var areaBean: DCTAreaBean!
}


struct DCTAreaHeaderViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<DCTAreaHeaderBean>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    
    struct WLOutput {
        
        let zip: Observable<(DCTAreaHeaderBean,IndexPath)>
        
        let tableData: BehaviorRelay<[DCTAreaHeaderBean]> = BehaviorRelay<[DCTAreaHeaderBean]>(value: [])
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let output = WLOutput(zip: zip)
        
        self.output = output
    }
}
