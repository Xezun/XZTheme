//
//  UITabBarItem+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit


extension UITabBarItem {
    
    open override func applyThemeAttribute(_ themeAttribute: Theme.Attribute, for themeState: Theme.State, in themeAttributes: Theme.Attributes) {
        super.applyThemeAttribute(themeAttribute, for: themeState, in: themeAttributes)
        switch themeAttribute {
        case .selectedImage:        self.selectedImage = themeAttributes.selectedImage;
        case .image:                self.image = themeAttributes.image;
        case .title:                self.title = themeAttributes.title;
        case .titleTextAttributes:  self.setTitleTextAttributes(themeAttributes.titleTextAttributes, for: UIControlState(themeState));
        case .landscapeImagePhone:  self.landscapeImagePhone = themeAttributes.landscapeImagePhone;
            
        case .largeContentSizeImage:
            if #available(iOS 11.0, *) {
                self.largeContentSizeImage = themeAttributes.largeContentSizeImage;
            } else {
                // Fallback on earlier versions
            }
            
        default: break;
            
        }
    }
    
}

