//
//  UIView+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit

extension UIView {
    
    open override func applyThemeAttribute(_ themeAttribute: Theme.Attribute, for themeState: Theme.State, in themeAttributes: Theme.Attributes) {
        super.applyThemeAttribute(themeAttribute, for: themeState, in: themeAttributes)
        
        switch themeAttribute {
        case .backgroundColor: self.backgroundColor = themeAttributes.backgroundColor;
        case .tintColor:       self.tintColor       = themeAttributes.tintColor;
        case .isHidden:        self.isHidden        = themeAttributes.isHidden;
        case .alpha:           self.alpha           = themeAttributes.alpha;
        case .isOpaque:        self.isOpaque        = themeAttributes.isOpaque;
        default:               break;
        }
        
    }
    
}


