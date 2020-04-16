//
//  DCTAreaViewModel.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/13.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import DCTBean

struct DCTAreaViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let areas: [DCTAreaBean]
        
        let modelSelect: ControlEvent<DCTAreaBean>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    
    struct WLOutput {
        
        let zip: Observable<(DCTAreaBean,IndexPath)>
        
        let tableData: BehaviorRelay<[DCTAreaBean]> = BehaviorRelay<[DCTAreaBean]>(value: [])
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let output = WLOutput(zip: zip)
        
        output.tableData.accept(input.areas)
        
        self.output = output
    }
}
