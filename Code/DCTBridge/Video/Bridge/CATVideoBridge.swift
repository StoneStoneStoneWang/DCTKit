//
//  CATVideoBridge.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/22.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import CATTransition
import CATHud
import CATCache

@objc(CATVideoActionType)
public enum CATVideoActionType: Int ,Codable {
    
    case myCircle = 0
    
    case circle = 1
    
    case comment = 2
    
    case watch = 3
    
    case report = 4
    
    case unLogin = 5
    
    case like = 6
    
    case focus = 7
    
    case black = 8
    
    case remove = 9
    
    case share = 10
}

public typealias CATVideoAction = (_ action: CATVideoActionType) -> ()

@objc (CATVideoBridge)
public final class CATVideoBridge: CATBaseBridge {
    
    var viewModel: CATVideoViewModel!
    
    weak var vc: CATTViewController!
}
extension CATVideoBridge {
    
    @objc public func createVideo(_ vc: CATTViewController) {
        
        self.vc = vc
    }
}
extension CATVideoBridge {
    
    @objc public func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String ,action: @escaping CATVideoAction) {
        
        if !CATAccountCache.default.isLogin() {
            
            action(.unLogin)
            
            return
        }
        
        CATHud.show(withStatus: "添加黑名单中...")
        
        CATVideoViewModel
            .addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content)
            .drive(onNext: { (result) in
                
                CATHud.pop()
                
                switch result {
                case .ok(let msg):
                
                    CATHud.showInfo(msg)
                    
                    action(.black)
                    
                case .failed(let msg):
                    
                    CATHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    @objc public func focus(_ uid: String ,encode: String ,isFocus: Bool,action: @escaping CATVideoAction) {
        
        if !CATAccountCache.default.isLogin() {
            
            action(.unLogin)
            
            return
        }
        
        CATHud.show(withStatus: isFocus ? "取消关注中..." : "关注中...")
        
        CATVideoViewModel
            .focus(uid, encode: encode)
            .drive(onNext: { (result) in
                
                CATHud.pop()
                
                switch result {
                case .ok:
                    
                    action(.focus)
                    
                    CATHud.showInfo(isFocus ? "取消关注成功" : "关注成功")
                case .failed(let msg):
                    
                    CATHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
    }

    @objc public func like(_ encoded: String,isLike: Bool,action: @escaping CATVideoAction) {
        
        if !CATAccountCache.default.isLogin() {
            
            action(.unLogin)
            
            return
        }
        
        CATHud.show(withStatus: isLike ? "取消点赞中..." : "点赞中...")
        
        CATVideoViewModel
            .like(encoded, isLike: !isLike)
            .drive(onNext: { [unowned self] (result) in
                
                CATHud.pop()
                
                switch result {
                case .ok(let msg):
                
                    action(.like)
                    
                    CATHud.showInfo(msg)
                case .failed(let msg):
                    
                    CATHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
}
