//
//  UITabBar+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit

extension UITabBar {
    
    open override func applyThemeAttribute(_ themeAttribute: Theme.Attribute, for themeState: Theme.State, in themeAttributes: Theme.Attributes) {
        super.applyThemeAttribute(themeAttribute, for: themeState, in: themeAttributes)
        
        switch themeAttribute {
        case .barTintColor:             self.barTintColor            = themeAttributes.barTintColor;
        case .shadowImage:              self.shadowImage             = themeAttributes.shadowImage;
        case .backgroundImage:          self.backgroundImage         = themeAttributes.backgroundImage;
        case .selectionIndicatorImage:  self.selectionIndicatorImage = themeAttributes.selectionIndicatorImage;
        case .unselectedItemTintColor:
            if #available(iOS 10.0, *) {
                self.unselectedItemTintColor = themeAttributes.unselectedItemTintColor
            } else {
                // Fallback on earlier versions
            };
            
        default: break;
        }
    }
}
