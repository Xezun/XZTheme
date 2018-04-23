//
//  UILabel+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit


extension UILabel {
    
    open override func applyThemeAttribute(_ themeAttribute: Theme.Attribute, for themeState: Theme.State, in themeAttributes: Theme.Attributes) {
        super.applyThemeAttribute(themeAttribute, for: themeState, in: themeAttributes)
        switch themeAttribute {
        case .text:                 self.text                   = themeAttributes.text;
        case .textColor:            self.textColor              = themeAttributes.textColor;
        case .font:                 self.font                   = themeAttributes.font;
        case .shadowColor:          self.shadowColor            = themeAttributes.shadowColor;
        case .highlightedTextColor: self.highlightedTextColor   = themeAttributes.highlightedTextColor;
        default:                    break;
        }
        
    }
    
}
