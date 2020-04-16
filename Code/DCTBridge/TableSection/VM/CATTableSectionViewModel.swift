//
//  CATTableSectionViewModel.swift
//  CATBridge
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxSwift
import RxCocoa

@objc (CATTableSectionBean)
public final class CATTableSectionBean: NSObject {
    
    @objc public var sTag: Int = 0
    
    @objc public var items: [CATTableRowBean] = []
    
    @objc public var title: String = ""
    
    @objc public static func createSection(_ sTag: Int,title: String ,items: [CATTableRowBean]) -> CATTableSectionBean {
        
        let section = CATTableSectionBean()
        
        section.sTag = sTag
        
        section.title = title
        
        section.items += items
        
        return section
    }
    private override init() { }
}

@objc (CATTableRowBean)
public final class CATTableRowBean: NSObject {
    
    @objc public var iTag: Int = 0
    
    @objc public var title: String = ""
    
    @objc public var icon: String = ""
    
    @objc public var value: String = ""
    
    @objc public var placeholder: String = ""
    
    @objc public var isSelected: Bool = false
    
    @objc public static func createRow(_ iTag: Int,title: String ,icon: String) -> CATTableRowBean {
        
        let item = CATTableRowBean()
        
        item.iTag = iTag
        
        item.title = title
        
        item.icon = icon
        
        return item
    }
    @objc public static func createRow(_ iTag: Int,title: String ,icon: String ,isSelected: Bool ,placeholder: String) -> CATTableRowBean {
        
        let item = CATTableRowBean()
        
        item.iTag = iTag
        
        item.title = title
        
        item.icon = icon
        
        item.isSelected = isSelected
        
        item.placeholder = placeholder
        
        return item
    }
    private override init() { }
}

struct CATTableSectionViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<CATTableRowBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let sections: [CATTableSectionBean]
    }
    
    struct WLOutput {
        // 获取轮播图序列
        let zip: Observable<(CATTableRowBean,IndexPath)>
        
        let tableData: BehaviorRelay<[CATTableSectionBean]> = BehaviorRelay<[CATTableSectionBean]>(value:[])
    }
    
    init(_ input: WLInput ) {
        
        self.input = input
        
        output = WLOutput(zip: Observable.zip(input.modelSelect,input.itemSelect))
        
        output.tableData.accept(input.sections)
    }
}
