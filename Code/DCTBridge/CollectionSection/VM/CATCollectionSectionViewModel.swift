//
//  DCTCollectionSectionViewModel.swift
//  DCTBridge
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxSwift
import RxCocoa

@objc (DCTCollectionSectionBean)
public final class DCTCollectionSectionBean: NSObject {
    
    @objc public var sTag: Int = 0
    
    @objc public var items: [DCTCollectionItemBean] = []
    
    @objc public var title: String = ""
    
    @objc public static func createSection(_ sTag: Int,title: String ,items: [DCTCollectionItemBean]) -> DCTCollectionSectionBean {
        
        let section = DCTCollectionSectionBean()
        
        section.sTag = sTag
        
        section.title = title
        
        section.items += items
        
        return section
    }
    private override init() { }
}

@objc (DCTCollectionItemBean)
public final class DCTCollectionItemBean: NSObject {
    
    @objc public var iTag: Int = 0
    
    @objc public var title: String = ""
    
    @objc public var icon: String = ""
    
    @objc public var isSelected: Bool = false
    
    @objc public var placeholder: String = ""
    
    @objc public var value: String = ""
    
    @objc public static func createItem(_ iTag: Int,title: String ,icon: String) -> DCTCollectionItemBean {
        
        return DCTCollectionItemBean .createItem(iTag, title: title, icon: icon, isSelected: false, placeholder: "")
    }
    @objc public static func createItem(_ iTag: Int,title: String ,icon: String,isSelected: Bool ,placeholder: String) -> DCTCollectionItemBean {
        
        let item = DCTCollectionItemBean()
        
        item.iTag = iTag
        
        item.title = title
        
        item.icon = icon
        
        item.placeholder = placeholder
        
        item.isSelected = isSelected
        
        return item
    }
    
    private override init() { }
}

struct DCTCollectionSectionViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<DCTCollectionItemBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let sections: [DCTCollectionSectionBean]
    }
    
    struct WLOutput {
        // 获取轮播图序列
        let zip: Observable<(DCTCollectionItemBean,IndexPath)>
        
        let collectionData: BehaviorRelay<[DCTCollectionSectionBean]> = BehaviorRelay<[DCTCollectionSectionBean]>(value:[])
    }
    
    init(_ input: WLInput ) {
        
        self.input = input
        
        output = WLOutput(zip: Observable.zip(input.modelSelect,input.itemSelect))
        
        output.collectionData.accept(input.sections)
    }
}
