//
//  UIView+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit

extension UIView {
    
    open override func updateAppearance(with themeStyle: Theme.Style, for themeAttribute: Theme.Attribute) {
        super.updateAppearance(with: themeStyle, for: themeAttribute);
        
        switch themeAttribute {
        case .backgroundColor: self.backgroundColor = themeStyle.backgroundColor;
        case .tintColor:       self.tintColor       = themeStyle.tintColor;
        case .isHidden:        self.isHidden        = themeStyle.isHidden;
        case .alpha:           self.alpha           = themeStyle.alpha;
        case .isOpaque:        self.isOpaque        = themeStyle.isOpaque;
        default: break;
        }
    }
    
}


