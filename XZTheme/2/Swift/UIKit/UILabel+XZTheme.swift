//
//  UILabel+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit


extension UILabel {
    
    open override func updateAppearance(with themeStyle: Theme.Style) {
        super.updateAppearance(with: themeStyle)
        
        for themeAttribute in themeStyle.themeAttributes {
            switch themeAttribute {
            case .text:                 self.text                   = themeStyle.text;
            case .textColor:            self.textColor              = themeStyle.textColor;
            case .font:                 self.font                   = themeStyle.font;
            case .shadowColor:          self.shadowColor            = themeStyle.shadowColor;
            case .highlightedTextColor: self.highlightedTextColor   = themeStyle.highlightedTextColor;
            default:                    break; 
            }
        }
        
    }
    
}
