//
//  CATCollectionSectionViewModel.swift
//  CATBridge
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxSwift
import RxCocoa

@objc (CATCollectionSectionBean)
public final class CATCollectionSectionBean: NSObject {
    
    @objc public var sTag: Int = 0
    
    @objc public var items: [CATCollectionItemBean] = []
    
    @objc public var title: String = ""
    
    @objc public static func createSection(_ sTag: Int,title: String ,items: [CATCollectionItemBean]) -> CATCollectionSectionBean {
        
        let section = CATCollectionSectionBean()
        
        section.sTag = sTag
        
        section.title = title
        
        section.items += items
        
        return section
    }
    private override init() { }
}

@objc (CATCollectionItemBean)
public final class CATCollectionItemBean: NSObject {
    
    @objc public var iTag: Int = 0
    
    @objc public var title: String = ""
    
    @objc public var icon: String = ""
    
    @objc public var isSelected: Bool = false
    
    @objc public var placeholder: String = ""
    
    @objc public var value: String = ""
    
    @objc public static func createItem(_ iTag: Int,title: String ,icon: String) -> CATCollectionItemBean {
        
        return CATCollectionItemBean .createItem(iTag, title: title, icon: icon, isSelected: false, placeholder: "")
    }
    @objc public static func createItem(_ iTag: Int,title: String ,icon: String,isSelected: Bool ,placeholder: String) -> CATCollectionItemBean {
        
        let item = CATCollectionItemBean()
        
        item.iTag = iTag
        
        item.title = title
        
        item.icon = icon
        
        item.placeholder = placeholder
        
        item.isSelected = isSelected
        
        return item
    }
    
    private override init() { }
}

struct CATCollectionSectionViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<CATCollectionItemBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let sections: [CATCollectionSectionBean]
    }
    
    struct WLOutput {
        // 获取轮播图序列
        let zip: Observable<(CATCollectionItemBean,IndexPath)>
        
        let collectionData: BehaviorRelay<[CATCollectionSectionBean]> = BehaviorRelay<[CATCollectionSectionBean]>(value:[])
    }
    
    init(_ input: WLInput ) {
        
        self.input = input
        
        output = WLOutput(zip: Observable.zip(input.modelSelect,input.itemSelect))
        
        output.collectionData.accept(input.sections)
    }
}
