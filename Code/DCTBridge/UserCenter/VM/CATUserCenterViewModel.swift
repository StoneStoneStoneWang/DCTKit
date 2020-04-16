//
//  CATUserCenterViewModel.swift
//  CATBridge
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
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

@objc public final class CATUserCenterBean: NSObject {
    
    @objc public var type: CATUserCenterType = .userInfo
    
    @objc public var title: String = ""
    
    @objc public static func createUserCenter(_ type: CATUserCenterType ,title: String) -> CATUserCenterBean {
        
        let profile = CATUserCenterBean()
        
        profile.type = type
        
        profile.title = title
        
        return profile
    }
    
    static public func createUserCenterTypes() -> [CATUserCenterBean] {
        
        var result: [CATUserCenterBean] = []
        
        for item in CATUserCenterType.types {
            
            result += [CATUserCenterBean.createUserCenter(item, title: item.title)]
        }
        
        return result
    }
    private override init() {
        
    }
}

@objc (CATUserCenterType)
public enum CATUserCenterType : Int{
    
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

extension CATUserCenterType {
    
    static var types: [CATUserCenterType] {
        
        if CATConfigure.fetchPType() == .cleaner {
            
            return [.order,.privacy,.contactUS,.feedBack,.setting]
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

struct CATUserCenterViewModel: WLBaseViewModel {
    
    var input: WLInput
    
    var output: WLOutput
    
    struct WLInput {
        
        let modelSelect: ControlEvent<CATUserCenterBean>
        
        let itemSelect: ControlEvent<IndexPath>
    }
    
    struct WLOutput {
        
        let zip: Observable<(CATUserCenterBean,IndexPath)>
        
        let tableData: BehaviorRelay<[CATUserCenterBean]> = BehaviorRelay<[CATUserCenterBean]>(value: [])
        
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
        
        self.output.tableData.accept(CATUserCenterBean.createUserCenterTypes())
    }
}

