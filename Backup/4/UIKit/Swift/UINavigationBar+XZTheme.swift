//
//  UINavigationBar+XZTheme.swift
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

extension UINavigationBar {
    
    open override func forwardsThemeAppearanceUpdate() -> Bool {
        return false
    }
    
    open override func updateAppearance(with themeStyles: Theme.StyleSet) {
        super.updateAppearance(with: themeStyles)
        
        for themeAttribute in themeStyles.themeAttributes {
            
            switch themeAttribute {
            case .barTintColor:             self.barTintColor            = themeStyles.barTintColor;
            case .shadowImage:              self.shadowImage             = themeStyles.shadowImage;
//            case .backgroundImage:          self.backgroundImage         = themeStyles.backgroundImage;
//            case .selectionIndicatorImage:  self.selectionIndicatorImage = themeStyles.selectionIndicatorImage;
//            case .unselectedItemTintColor:
//                if #available(iOS 10.0, *) {
//                    self.unselectedItemTintColor = themeStyles.unselectedItemTintColor
//                } else {
//                    // Fallback on earlier versions
//                };
//
            default: break;
            }
        }
    }
    
}
