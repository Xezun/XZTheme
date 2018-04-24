//
//  UITabBar+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit

extension UITabBar {
    
    open override func updateAppearance(with themeStyle: Theme.Style) {
        super.updateAppearance(with: themeStyle)
        
        for themeAttribute in themeStyle.themeAttributes {
            
            switch themeAttribute {
            case .barTintColor:             self.barTintColor            = themeStyle.barTintColor;
            case .shadowImage:              self.shadowImage             = themeStyle.shadowImage;
            case .backgroundImage:          self.backgroundImage         = themeStyle.backgroundImage;
            case .selectionIndicatorImage:  self.selectionIndicatorImage = themeStyle.selectionIndicatorImage;
            case .unselectedItemTintColor:
                if #available(iOS 10.0, *) {
                    self.unselectedItemTintColor = themeStyle.unselectedItemTintColor
                } else {
                    // Fallback on earlier versions
                };
                
            default: break;
            }
        }
    }
}
