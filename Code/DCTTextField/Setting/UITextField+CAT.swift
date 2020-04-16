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
    @objc (CAT_backgroundColor:)
    public func CAT_backgroundColor(_ color: UIColor) {
        
        backgroundColor = color
    }
    @objc (CAT_font:)
    public func CAT_font(_ font: UIFont) {
        
        self.font = font
    }
    @objc (CAT_textColor:)
    public func CAT_textColor(_ color: UIColor) {
        
        textColor = color
    }
    @objc (CAT_textAlignment:)
    public func CAT_textAlignment(_ alignment: NSTextAlignment) {
        
        textAlignment = alignment
    }
    @objc (CAT_keyboardType:)
    public func CAT_keyboardType(_ keyboardType: UIKeyboardType) {
        
        self.keyboardType = keyboardType
    }
    @objc (CAT_clearButtonMode:)
    public func CAT_clearButtonMode(_ clearButtonMode: UITextField.ViewMode) {
        
        self.clearButtonMode = clearButtonMode
        
    }
    @objc (CAT_returnKeyType:)
    public func CAT_returnKeyType(_ returnKeyType: UIReturnKeyType) {
        
        self.returnKeyType = returnKeyType
    }
    @objc (CAT_rightViewMode:)
    public func CAT_rightViewMode(_ rightViewMode: UITextField.ViewMode) {
        
        self.rightViewMode = rightViewMode
    }
    @objc (CAT_leftViewMode:)
    public func CAT_leftViewMode(_ leftViewMode: UITextField.ViewMode) {
        
        self.leftViewMode = leftViewMode
    }
    @objc (CAT_leftView:)
    public func CAT_leftView(_ leftView: UIView) {
        
        self.leftView = leftView
    }
    @objc (CAT_rightView:)
    public func CAT_rightView(_ rightView: UIView) {
        
        self.rightView = rightView
    }
}

public typealias CATShouldReturn = () -> Bool

public typealias CATShouldClear = () -> Bool

extension UITextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    fileprivate var shouldReturn: CATShouldReturn! {
        set {
            
            objc_setAssociatedObject(self, "shouldReturn", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            
            return objc_getAssociatedObject(self, "shouldReturn") as? CATShouldReturn
        }
    }
    @objc (CAT_shouldReturn:)
    public func CAT_shouldReturn(_ shouldReturn: @escaping () -> Bool) {
        
        self.shouldReturn = shouldReturn
    }
    @objc (textFieldShouldReturn:)
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if shouldReturn == nil {
            
            return true
        }
        
        return shouldReturn!()
    }
    
    fileprivate var shouldClear: CATShouldClear! {
        
        set {
            
            objc_setAssociatedObject(self, "shouldClear", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            
            return objc_getAssociatedObject(self, "shouldClear") as? CATShouldClear
        }
    }
    @objc (CAT_shouldClear:)
    public func CAT_shouldClear(_ shouldClear: @escaping () -> Bool) {
        
        self.shouldClear = shouldClear
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        if shouldClear == nil {
            
            return true
        }
        
        return shouldClear!()
    }
}

