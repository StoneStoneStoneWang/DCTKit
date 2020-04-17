//
//  DCTUserInfoViewModel.swift
//  DCTBridge
//
//  Created by three stone 王 on 2019/8/28.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DCTViewModel
import RxCocoa
import RxSwift

import DCTResult
import DCTCache
import DCTApi
import DCTRReq
import DCTBean
import DCTError
import DCTOM


@objc public final class DCTUserInfoBean: NSObject {
    
    @objc public var type: DCTUserInfoType = .header
    
    @objc public var img: UIImage!
    
    @objc public var subtitle: String = ""
    
    @objc public var title: String {
        
        return type.title
    }
    
    static func createUserInfo(_ type: DCTUserInfoType) -> DCTUserInfoBean {
        
        let userInfo = DCTUserInfoBean()
        
        userInfo.type = type
        
        return userInfo
    }
    
    static func createUserInfoTypes(_ hasSpace: Bool) -> [DCTUserInfoBean] {
        
        var result: [DCTUserInfoBean] = []
        
        if hasSpace {
            
            for item in DCTUserInfoType.spaceTypes {
                
                result += [DCTUserInfoBean.createUserInfo(item)]
            }
            
        } else {
            
            for item in DCTUserInfoType.types {
                
                result += [DCTUserInfoBean.createUserInfo(item)]
            }
        }
        
        return result
    }
}

@objc (DCTUserInfoType)
public enum DCTUserInfoType: Int {
    
    case header
    
    case name
    
    case phone
    
    case sex
    
    case signature
    
    case birth
    
    case space
}


extension DCTUserInfoType {
    
    static var spaceTypes: [DCTUserInfoType] {
        
        return [.space ,.header ,.name ,.phone ,.space ,.sex ,.birth ,.signature]
    }
    static var types: [DCTUserInfoType] {
        
        return [.header ,.name ,.phone ,.sex ,.birth ,.signature]
    }
    
    var title: String {
        
        switch self {
            
        case .header: return "头像"
            
        case .name: return "昵称"
            
        case .phone: return "手机号"
            
        case .sex: return "性别"
            
        case .signature: return "个性签名"
            
        case .birth: return "生日"
            
        case .space: return ""
            
        }
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .space: return 10
            
        case .header: return 80
            
        default: return 55
            
        }
    }
    
    var updateKey: String {
        
        switch self {
        case .name: return "users.nickname"
            
        case .birth: return "users.birthday"
            
        case .signature: return "users.signature"
            
        case .sex: return "users.sex"
            
        case .header: return "users.headImg"
        default: return ""
            
        }
    }
}

public struct DCTUserInfoViewModel: DCTViewModel {
    
    public var input: WLInput
    
    public var output: WLOutput
    
    public struct WLInput {
        
        let modelSelect: ControlEvent<DCTUserInfoBean>
        
        let itemSelect: ControlEvent<IndexPath>
        
        let hasSpace: Bool
    }
    public struct WLOutput {
        
        let zip: Observable<(DCTUserInfoBean,IndexPath)>
        
        let tableData: BehaviorRelay<[DCTUserInfoBean]> = BehaviorRelay<[DCTUserInfoBean]>(value: [])
    }
    public init(_ input: WLInput ,disposed: DisposeBag) {
        
        self.input = input
        
        let zip = Observable.zip(input.modelSelect,input.itemSelect)
        
        let output = WLOutput(zip: zip)
        
        output.tableData.accept(DCTUserInfoBean.createUserInfoTypes(input.hasSpace))
        
        DCTUserInfoCache.default
            .rx
            .observe(DCTUserBean.self, "userBean")
            .subscribe(onNext: { (user) in
                
                if let user = user {
                    
                    let values =  output.tableData.value
                    
                    if let headIdx = values.firstIndex(where: { $0.type == .header}) {
                        
                        output.tableData.value[headIdx].subtitle = user.headImg
                    }
                    if let nameIdx = values.firstIndex(where: { $0.type == .name}) {
                        
                        output.tableData.value[nameIdx].subtitle = user.nickname
                    }
                    if let phoneIdx = values.firstIndex(where: { $0.type == .phone}) {
                        
                        output.tableData.value[phoneIdx].subtitle = user.phone
                    }
                    if let sexIdx = values.firstIndex(where: { $0.type == .sex}) {
                        
                        output.tableData.value[sexIdx].subtitle = user.gender.gender
                    }
                    
                    if let birthIdx = values.firstIndex(where: { $0.type == .birth}) {
                        
                        output.tableData.value[birthIdx].subtitle = user.birthday
                    }
                    if let signtureIdx = values.firstIndex(where: { $0.type == .signature}) {
                        
                        output.tableData.value[signtureIdx].subtitle = user.signature
                    }
                }
            })
            .disposed(by: disposed)
        
        self.output = output
    }
    
    public static func updateUserInfo(type: DCTUserInfoType,value: String) -> Driver<DCTResult>{
        
        return DCTDictResp(DCTApi.updateUserInfo(type.updateKey, value: value))
            .mapObject(type: DCTUserBean.self)
            .map({ DCTUserInfoCache.default.saveUser(data: $0) })
            .map { _ in DCTResult.ok("")}
            .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! DCTError).description.0)) })
    }
    
    public static func fetchAliToken() -> Driver<DCTResult> {
        
        return DCTAliResp(DCTApi.aliToken)
            .map { DCTResult.fetchSomeObject($0 as AnyObject)}
            .asDriver(onErrorRecover: { return Driver.just(DCTResult.failed(($0 as! DCTError).description.0)) })
    }
}
