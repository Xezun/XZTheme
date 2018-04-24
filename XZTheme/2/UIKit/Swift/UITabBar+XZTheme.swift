//
//  UITabBar+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit

extension UITabBar {
    
    open override func forwardsThemeAppearanceUpdate() -> Bool {
        return false
    }
    
    open override func updateAppearance(with themeStyles: Theme.Styles) {
        super.updateAppearance(with: themeStyles)
        
        for themeAttribute in themeStyles.themeAttributes {
            
            switch themeAttribute {
            case .barTintColor:             self.barTintColor            = themeStyles.barTintColor;
            case .shadowImage:              self.shadowImage             = themeStyles.shadowImage;
            case .backgroundImage:          self.backgroundImage         = themeStyles.backgroundImage;
            case .selectionIndicatorImage:  self.selectionIndicatorImage = themeStyles.selectionIndicatorImage;
            case .unselectedItemTintColor:
                if #available(iOS 10.0, *) {
                    self.unselectedItemTintColor = themeStyles.unselectedItemTintColor
                } else {
                    // Fallback on earlier versions
                };
                
            default: break;
            }
        }
    }
}
