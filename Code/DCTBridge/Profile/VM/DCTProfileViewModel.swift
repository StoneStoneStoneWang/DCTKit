//
//  DCTProfileViewModel.swift
//  DCTBridge
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DCTViewModel
import RxCocoa
import RxSwift
import DCTBean
import DCTSign
import DCTApi
import DCTRReq
import DCTCache
import DCTOM

@objc public final class DCTProfileBean: NSObject {
    
    @objc public var type: DCTProfileType = .space
    
    @objc public var title: String = ""
    
    @objc public static func createProfile(_ type: DCTProfileType ,title: String) -> DCTProfileBean {
        
        let profile = DCTProfileBean()
        
        profile.type = type
        
        profile.title = title
        
        return profile
    }
    
    static public func createProfileTypes(_ hasSpace: Bool) -> [DCTProfileBean] {
        
        var result: [DCTProfileBean] = []
        
        if hasSpace {
            
            for item in DCTProfileType.spaceTypes {
                
                result += [DCTProfileBean.createProfile(item, title: item.title)]
            }
            
        } else {
            
            for item in DCTProfileType.types {
                
                result += [DCTProfileBean.createProfile(item, title: item.title)]
            }
        }
        
        return result
    }
    private override init() {
        
    }
}

@objc (DCTProfileType)
public enum DCTProfileType : Int{
    
    case about
    
    case userInfo
    
    case setting
    
    case contactUS
    
    case privacy
    
    case focus
    
    case space
    
    case myCircle
    
    case order
    
    case address
    
    case characters
    
    case feedBack
    
    case favor
}

extension DCTProfileType {
    
    static var spaceTypes: [DCTProfileType] {
        
        if DCTConfigure.fetchPType() == .cleaner {
            
            return [.space,userInfo,.order,.address,.favor,.space,.contactUS,.privacy,.about,.space,.feedBack,.setting]
        }
        
        return [.space,userInfo,.space,.contactUS,.privacy,.about,.space,.feedBack,.setting]
        
    }
    
    static var types: [DCTProfileType] {
        
        if DCTConfigure.fetchPType() == .cleaner {
            
            return [userInfo,.order,.address,.favor,.contactUS,.privacy,.about,.feedBack,.setting]
        }
        return [userInfo,.contactUS,.privacy,.about,.feedBack,.setting]
    }
    
    var cellHeight: CGFloat {
        
        switch self {
        case .space: return 10
            
        default: return 55
        }
    }
    
    var title: String {
        
        switch self {
            
        case .about: return "关于我们"
            
        case .contactUS: return "联系我们"
            
        case .userInfo: return "用户资料"
            
        case .setting: return "设置"
            
        case .privacy: return "隐私政策"
            
        case .focus: return "我的关注"
            
        case .myCircle: return "我的发布"
            
        case .address: return "地址管理"
            
        case .order: return "订单管理"
            
        case .characters: return "角色信息"
            
        case .feedBack: return "意见建议"
            
        case .favor: return "我的收藏"
            
        default: return ""
            
        }
    }
}

struct DCTProfileViewModel: DCTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<DCTProfileBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let hasSpace: Bool
    }
    
    struct WLOutput {
        
        let zip: Observable<(DCTProfileBean,IndexPath)>
        
        let tableData: BehaviorRelay<[DCTProfileBean]> = BehaviorRelay<[DCTProfileBean]>(value: [])
        
        let userInfo: Observable<DCTUserBean?>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let userInfo: Observable<DCTUserBean?> = DCTUserInfoCache.default.rx.observe(DCTUserBean.self, "userBean")
        
        DCTUserInfoCache.default.userBean = DCTUserInfoCache.default.queryUser()
        
        DCTDictResp(DCTApi.fetchProfile)
            .mapObject(type: DCTUserBean.self)
            .map({ DCTUserInfoCache.default.saveUser(data: $0) })
            .subscribe(onNext: { (_) in })
            .disposed(by: disposed)
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        self.output = WLOutput(zip: zip, userInfo: userInfo)
        
        self.output.tableData.accept(DCTProfileBean.createProfileTypes(input.hasSpace))
    }
}

