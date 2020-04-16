//
//  DCTLoginBridge.swift
//  DCTBridge
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DCTBase
import DCTHud
import RxCocoa
import RxSwift

@objc(DCTLoginActionType)
public enum DCTLoginActionType: Int ,Codable {
    
    case swiftLogin = 0
    
    case loginSucc = 1
    
    case gotoFindPassword = 2
    
    case backItem = 3
}

public typealias DCTLoginAction = (_ action: DCTLoginActionType) -> ()

@objc (DCTLoginBridge)
public final class DCTLoginBridge: DCTBaseBridge {
    
    public var viewModel: DCTLoginViewModel!
}

// MARK: 201 手机号 202 密码 203 登陆按钮 204 快捷登录按钮 205 忘记密码按钮 206
extension DCTLoginBridge {
    
    @objc public func createLogin(_ vc: DCTBaseViewController ,loginAction: @escaping DCTLoginAction) {
        
        if let phone = vc.view.viewWithTag(201) as? UITextField ,let password = vc.view.viewWithTag(202) as? UITextField ,let loginItem = vc.view.viewWithTag(203) as? UIButton
            , let swiftLoginItem = vc.view.viewWithTag(204) as? UIButton ,let forgetItem = vc.view.viewWithTag(205) as? UIButton , let passwordItem = password.rightView
            as? UIButton ,let backItem = vc.navigationItem.leftBarButtonItem?.customView as? UIButton {
            
            let input = DCTLoginViewModel.WLInput(username: phone.rx.text.orEmpty.asDriver(),
                                                password: password.rx.text.orEmpty.asDriver() ,
                                                loginTaps: loginItem.rx.tap.asSignal(),
                                                swiftLoginTaps: swiftLoginItem.rx.tap.asSignal(),
                                                forgetTaps: forgetItem.rx.tap.asSignal(),
                                                passwordItemTaps: passwordItem.rx.tap.asSignal())
            
            viewModel = DCTLoginViewModel(input)
            
            backItem
                .rx
                .tap
                .subscribe(onNext: { (_) in
                    
                    loginAction(.backItem)
                })
                .disposed(by: disposed)
            
            // MARK: 登录点击中序列
            viewModel
                .output
                .logining
                .drive(onNext: { _ in
                    
                    vc.view.endEditing(true)
                    
                    DCTHud.show(withStatus: "登录中...")
                })
                .disposed(by: disposed)
            
            // MARK: 登录事件返回序列
            viewModel
                .output
                .logined
                .drive(onNext: {
                    
                    DCTHud.pop()
                    
                    switch $0 {
                        
                    case let .failed(msg): DCTHud.showInfo(msg)
                        
                    case .logined:
                        
                        DCTHud.showInfo("登录成功")
                        
                        loginAction(.loginSucc)

                        
                    default: break
                    }
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .swiftLogined
                .drive(onNext: { (_) in
                    
                    loginAction(.swiftLogin)
    
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .forgeted
                .drive(onNext: {(_) in
                    
                    loginAction(.gotoFindPassword)
                    
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .passwordItemed
                .drive(passwordItem.rx.isSelected)
                .disposed(by: disposed)
            
            viewModel
                .output
                .passwordEntryed
                .drive(password.rx.isSecureTextEntry)
                .disposed(by: disposed)
        }
    }
}
