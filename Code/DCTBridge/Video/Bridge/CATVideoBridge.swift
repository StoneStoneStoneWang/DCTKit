//
//  DCTVideoBridge.swift
//  ZBombBridge
//
//  Created by three stone 王 on 2020/3/22.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import DCTTransition
import DCTHud
import DCTCache

@objc(DCTVideoActionType)
public enum DCTVideoActionType: Int ,Codable {
    
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

public typealias DCTVideoAction = (_ action: DCTVideoActionType) -> ()

@objc (DCTVideoBridge)
public final class DCTVideoBridge: DCTBaseBridge {
    
    var viewModel: DCTVideoViewModel!
    
    weak var vc: DCTTViewController!
}
extension DCTVideoBridge {
    
    @objc public func createVideo(_ vc: DCTTViewController) {
        
        self.vc = vc
    }
}
extension DCTVideoBridge {
    
    @objc public func addBlack(_ OUsEncoded: String,targetEncoded: String ,content: String ,action: @escaping DCTVideoAction) {
        
        if !DCTAccountCache.default.isLogin() {
            
            action(.unLogin)
            
            return
        }
        
        DCTHud.show(withStatus: "添加黑名单中...")
        
        DCTVideoViewModel
            .addBlack(OUsEncoded, targetEncoded: targetEncoded, content: content)
            .drive(onNext: { (result) in
                
                DCTHud.pop()
                
                switch result {
                case .ok(let msg):
                
                    DCTHud.showInfo(msg)
                    
                    action(.black)
                    
                case .failed(let msg):
                    
                    DCTHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    @objc public func focus(_ uid: String ,encode: String ,isFocus: Bool,action: @escaping DCTVideoAction) {
        
        if !DCTAccountCache.default.isLogin() {
            
            action(.unLogin)
            
            return
        }
        
        DCTHud.show(withStatus: isFocus ? "取消关注中..." : "关注中...")
        
        DCTVideoViewModel
            .focus(uid, encode: encode)
            .drive(onNext: { (result) in
                
                DCTHud.pop()
                
                switch result {
                case .ok:
                    
                    action(.focus)
                    
                    DCTHud.showInfo(isFocus ? "取消关注成功" : "关注成功")
                case .failed(let msg):
                    
                    DCTHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
    }

    @objc public func like(_ encoded: String,isLike: Bool,action: @escaping DCTVideoAction) {
        
        if !DCTAccountCache.default.isLogin() {
            
            action(.unLogin)
            
            return
        }
        
        DCTHud.show(withStatus: isLike ? "取消点赞中..." : "点赞中...")
        
        DCTVideoViewModel
            .like(encoded, isLike: !isLike)
            .drive(onNext: { [unowned self] (result) in
                
                DCTHud.pop()
                
                switch result {
                case .ok(let msg):
                
                    action(.like)
                    
                    DCTHud.showInfo(msg)
                case .failed(let msg):
                    
                    DCTHud.showInfo(msg)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
}
