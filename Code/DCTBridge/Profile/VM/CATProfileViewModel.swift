//
//  CATProfileViewModel.swift
//  CATBridge
//
//  Created by three stone 王 on 2019/8/27.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import WLBaseViewModel
import RxCocoa
import RxSwift
import CATBean
import CATSign
import CATApi
import CATRReq
import CATCache

@objc public final class CATProfileBean: NSObject {
    
    @objc public var type: CATProfileType = .space
    
    @objc public var title: String = ""
    
    @objc public static func createProfile(_ type: CATProfileType ,title: String) -> CATProfileBean {
        
        let profile = CATProfileBean()
        
        profile.type = type
        
        profile.title = title
        
        return profile
    }
    
    static public func createProfileTypes(_ hasSpace: Bool) -> [CATProfileBean] {
        
        var result: [CATProfileBean] = []
        
        if hasSpace {
            
            for item in CATProfileType.spaceTypes {
                
                result += [CATProfileBean.createProfile(item, title: item.title)]
            }
            
        } else {
            
            for item in CATProfileType.types {
                
                result += [CATProfileBean.createProfile(item, title: item.title)]
            }
        }
        
        return result
    }
    private override init() {
        
    }
}

@objc (CATProfileType)
public enum CATProfileType : Int{
    
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

extension CATProfileType {
    
    static var spaceTypes: [CATProfileType] {
        
        if CATConfigure.fetchPType() == .cleaner {
            
            return [.space,userInfo,.order,.address,.favor,.space,.contactUS,.privacy,.about,.space,.feedBack,.setting]
        }
        
        return [.space,userInfo,.space,.contactUS,.privacy,.about,.space,.feedBack,.setting]
        
    }
    
    static var types: [CATProfileType] {
        
        if CATConfigure.fetchPType() == .cleaner {
            
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

struct CATProfileViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<CATProfileBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let hasSpace: Bool
    }
    
    struct WLOutput {
        
        let zip: Observable<(CATProfileBean,IndexPath)>
        
        let tableData: BehaviorRelay<[CATProfileBean]> = BehaviorRelay<[CATProfileBean]>(value: [])
        
        let userInfo: Observable<CATUserBean?>
    }
    init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let userInfo: Observable<CATUserBean?> = CATUserInfoCache.default.rx.observe(CATUserBean.self, "userBean")
        
        CATUserInfoCache.default.userBean = CATUserInfoCache.default.queryUser()
        
        CATDictResp(CATApi.fetchProfile)
            .mapObject(type: CATUserBean.self)
            .map({ CATUserInfoCache.default.saveUser(data: $0) })
            .subscribe(onNext: { (_) in })
            .disposed(by: disposed)
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        self.output = WLOutput(zip: zip, userInfo: userInfo)
        
        self.output.tableData.accept(CATProfileBean.createProfileTypes(input.hasSpace))
    }
}

