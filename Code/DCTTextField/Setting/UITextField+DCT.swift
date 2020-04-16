//
//  UITextField+WL.swift
//  TSTFKit_Swift
//
//  Created by three stone 王 on 2018/11/17.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    @objc (DCT_backgroundColor:)
    public func DCT_backgroundColor(_ color: UIColor) {
        
        backgroundColor = color
    }
    @objc (DCT_font:)
    public func DCT_font(_ font: UIFont) {
        
        self.font = font
    }
    @objc (DCT_textColor:)
    public func DCT_textColor(_ color: UIColor) {
        
        textColor = color
    }
    @objc (DCT_textAlignment:)
    public func DCT_textAlignment(_ alignment: NSTextAlignment) {
        
        textAlignment = alignment
    }
    @objc (DCT_keyboardType:)
    public func DCT_keyboardType(_ keyboardType: UIKeyboardType) {
        
        self.keyboardType = keyboardType
    }
    @objc (DCT_clearButtonMode:)
    public func DCT_clearButtonMode(_ clearButtonMode: UITextField.ViewMode) {
        
        self.clearButtonMode = clearButtonMode
        
    }
    @objc (DCT_returnKeyType:)
    public func DCT_returnKeyType(_ returnKeyType: UIReturnKeyType) {
        
        self.returnKeyType = returnKeyType
    }
    @objc (DCT_rightViewMode:)
    public func DCT_rightViewMode(_ rightViewMode: UITextField.ViewMode) {
        
        self.rightViewMode = rightViewMode
    }
    @objc (DCT_leftViewMode:)
    public func DCT_leftViewMode(_ leftViewMode: UITextField.ViewMode) {
        
        self.leftViewMode = leftViewMode
    }
    @objc (DCT_leftView:)
    public func DCT_leftView(_ leftView: UIView) {
        
        self.leftView = leftView
    }
    @objc (DCT_rightView:)
    public func DCT_rightView(_ rightView: UIView) {
        
        self.rightView = rightView
    }
}

public typealias DCTShouldReturn = () -> Bool

public typealias DCTShouldClear = () -> Bool

extension UITextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    fileprivate var shouldReturn: DCTShouldReturn! {
        set {
            
            objc_setAssociatedObject(self, "shouldReturn", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            
            return objc_getAssociatedObject(self, "shouldReturn") as? DCTShouldReturn
        }
    }
    @objc (DCT_shouldReturn:)
    public func DCT_shouldReturn(_ shouldReturn: @escaping () -> Bool) {
        
        self.shouldReturn = shouldReturn
    }
    @objc (textFieldShouldReturn:)
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if shouldReturn == nil {
            
            return true
        }
        
        return shouldReturn!()
    }
    
    fileprivate var shouldClear: DCTShouldClear! {
        
        set {
            
            objc_setAssociatedObject(self, "shouldClear", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            
            return objc_getAssociatedObject(self, "shouldClear") as? DCTShouldClear
        }
    }
    @objc (DCT_shouldClear:)
    public func DCT_shouldClear(_ shouldClear: @escaping () -> Bool) {
        
        self.shouldClear = shouldClear
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        if shouldClear == nil {
            
            return true
        }
        
        return shouldClear!()
    }
}

