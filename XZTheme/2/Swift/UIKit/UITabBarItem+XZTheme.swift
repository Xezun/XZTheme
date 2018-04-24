//
//  UITabBarItem+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit


extension UITabBarItem {
    
    open override func updateAppearance(with themeStyle: Theme.Style) {
        super.updateAppearance(with: themeStyle)
        
        
        
        for themeAttribute in themeStyle.themeAttributes {
            switch themeAttribute {
            case .selectedImage:        self.selectedImage       = themeStyle.selectedImage;
            case .image:                self.image               = themeStyle.image;
            case .title:                self.title               = themeStyle.title;
            case .landscapeImagePhone:  self.landscapeImagePhone = themeStyle.landscapeImagePhone;
            case .titleTextAttributes:  self.setTitleTextAttributes(themeStyle.titleTextAttributes, for: .normal);
            case .largeContentSizeImage:
                if #available(iOS 11.0, *) {
                    self.largeContentSizeImage = themeStyle.largeContentSizeImage;
                } else {
                    // Fallback on earlier versions
                }
                
            default: break;
                
            }
        }
        
        if let titleTextAttributes = themeStyle.selectedIfLoaded?.titleTextAttributes {
            self.setTitleTextAttributes(titleTextAttributes, for: .selected)
        }
        
        if let titleTextAttributes = themeStyle.disabledIfLoaded?.titleTextAttributes {
            self.setTitleTextAttributes(titleTextAttributes, for: .disabled)
        }
        
        if let titleTextAttributes = themeStyle.highlightedIfLoaded?.titleTextAttributes {
            self.setTitleTextAttributes(titleTextAttributes, for: .highlighted)
        }
        
        if #available(iOS 9.0, *) {
            if let titleTextAttributes = themeStyle.focusedIfLoaded?.titleTextAttributes {
                self.setTitleTextAttributes(titleTextAttributes, for: .focused)
            }
        }
        
    }
    
}

