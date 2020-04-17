//
//  DCTUserCenterViewModel.swift
//  DCTBridge
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
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

@objc public final class DCTUserCenterBean: NSObject {
    
    @objc public var type: DCTUserCenterType = .userInfo
    
    @objc public var title: String = ""
    
    @objc public static func createUserCenter(_ type: DCTUserCenterType ,title: String) -> DCTUserCenterBean {
        
        let profile = DCTUserCenterBean()
        
        profile.type = type
        
        profile.title = title
        
        return profile
    }
    
    static public func createUserCenterTypes() -> [DCTUserCenterBean] {
        
        var result: [DCTUserCenterBean] = []
        
        for item in DCTUserCenterType.types {
            
            result += [DCTUserCenterBean.createUserCenter(item, title: item.title)]
        }
        
        return result
    }
    private override init() {
        
    }
}

@objc (DCTUserCenterType)
public enum DCTUserCenterType : Int{
    
    case about
    
    case userInfo
    
    case setting
    
    case contactUS
    
    case privacy
    
    case focus
    
    case myCircle
    
    case order
    
    case address
    
    case characters
    
    case feedBack
}

extension DCTUserCenterType {
    
    static var types: [DCTUserCenterType] {
        
        if DCTConfigure.fetchPType() == .cleaner {
            
            return [userInfo,.privacy,.contactUS,.feedBack,.setting]
        }
        
        return [userInfo,.contactUS,.privacy,.about,.feedBack,.setting]
    }
    
    var cellHeight: CGFloat {
        
        switch self {
            
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
            
        case .address: return "我的地址"
            
        case .order: return "订单管理"
            
        case .characters: return "角色信息"
            
        case .feedBack: return "意见建议"
        default: return ""
            
        }
    }
}

struct DCTUserCenterViewModel: DCTViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<DCTUserCenterBean>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    
    struct WLOutput {
        
        let zip: Observable<(DCTUserCenterBean,IndexPath)>
        
        let tableData: BehaviorRelay<[DCTUserCenterBean]> = BehaviorRelay<[DCTUserCenterBean]>(value: [])
        
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
        
        self.output.tableData.accept(DCTUserCenterBean.createUserCenterTypes())
    }
}

