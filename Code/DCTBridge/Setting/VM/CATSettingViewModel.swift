//
//  DCTSettingViewModel.swift
//  DCTBridge
//
//  Created by three stone 王 on 2019/8/26.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DCTViewModel
import RxCocoa
import RxSwift
import DCTCache
import DCTSign

@objc public final class DCTSettingBean: NSObject {
    
    @objc public var type: DCTSettingType = .space
    
    @objc public var title: String = ""
    
    @objc public var subTitle: String = ""
    
    @objc public static func createSetting(_ type: DCTSettingType ,title: String ,sub: String) -> DCTSettingBean {
        
        let setting = DCTSettingBean()
        
        setting.type = type
        
        setting.title = title
        
        setting.subTitle = sub
        
        return setting
    }
    
    static func createTabledata(_ hasspace: Bool ) -> [DCTSettingBean] {
        
        var result: [DCTSettingBean] = []
        
        if hasspace {
            
            for item in DCTSettingType.spaceTypes {
                
                result += [DCTSettingBean.createSetting(item, title: item.title, sub: "")]
            }
            
        } else {
            
            for item in DCTSettingType.types {
                
                result += [DCTSettingBean.createSetting(item, title: item.title, sub: "")]
            }
        }
        
        return result
    }
    private override init() { }
}

@objc (DCTSettingType)
public enum DCTSettingType: Int {
    
    case pwd  = 0 // 未登录
    
    case password = 1// 已登录
    
    case logout = 2
    
    case clear = 3
    
    case push = 4
    
    case space = 5
    
    case black = 6
}

extension DCTSettingType {
    
    static var spaceTypes: [DCTSettingType] {
        
        if DCTAccountCache.default.isLogin() {
            
            if DCTConfigure.fetchPType() == .cleaner {
                
                return [.space,.password,.space,.clear,.push,.space,.logout]
            }
        }
        return [.space,.pwd,.space,.clear,.push]
    }
    static var types: [DCTSettingType] {
        
        if DCTAccountCache.default.isLogin() {
            
            if DCTConfigure.fetchPType() == .cleaner {
                
                return [.password,.black,.clear,.push,.logout]
            }
        }
        
        return [.pwd,.clear,.push]
    }
    
    
    public var title: String {
        
        switch self {
            
        case .pwd: return "忘记密码"
            
        case .password: return "修改密码"
            
        case .logout: return "退出登录"
            
        case .clear: return "清理缓存"
            
        case .push: return "推送设置"
            
        case .black: return "黑名单"
            
        default: return ""
            
        }
    }
    
    var cellHeight: CGFloat {
        
        switch self {
        case .space: return 10
            
        default: return 55
        }
    }
}

public struct DCTSettingViewModel: DCTViewModel {
    
    public var input: WLInput
    
    public var output: WLOutput
    
    public struct WLInput {
        
        let modelSelect: ControlEvent<DCTSettingBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let hasSpace: Bool
    }
    public struct WLOutput {
        
        let zip: Observable<(DCTSettingBean,IndexPath)>
        
        let tableData: BehaviorRelay<[DCTSettingBean]> = BehaviorRelay<[DCTSettingBean]>(value: [])
    }
    
    init(_ input: WLInput) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        self.output = WLOutput(zip: zip)
        
        self.output.tableData.accept(DCTSettingBean.createTabledata(input.hasSpace))
    }
}

