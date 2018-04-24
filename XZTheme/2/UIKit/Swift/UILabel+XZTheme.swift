//
//  UILabel+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit


extension UILabel {
    
    open override func forwardsThemeAppearanceUpdate() -> Bool {
        return false
    }
    
    open override func updateAppearance(with themeStyles: Theme.Styles) {
        super.updateAppearance(with: themeStyles)
        
        for themeAttribute in themeStyles.themeAttributes {
            switch themeAttribute {
            case .text:                 self.text                   = themeStyles.text;
            case .textColor:            self.textColor              = themeStyles.textColor;
            case .font:                 self.font                   = themeStyles.font;
            case .shadowColor:          self.shadowColor            = themeStyles.shadowColor;
            case .highlightedTextColor: self.highlightedTextColor   = themeStyles.highlightedTextColor;
            default:                    break; 
            }
        }
        
    }
    
}
