//
//  UITabBarItem+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit


extension UITabBarItem {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        for themeAttribute in themeStyles.themeAttributes {
            switch themeAttribute {
            case .selectedImage:        self.selectedImage       = themeStyles.selectedImage;
            case .image:                self.image               = themeStyles.image;
            case .title:                self.title               = themeStyles.title;
            case .landscapeImagePhone:  self.landscapeImagePhone = themeStyles.landscapeImagePhone;
            case .titleTextAttributes:  self.setTitleTextAttributes(themeStyles.titleTextAttributes, for: .normal);
            case .largeContentSizeImage:
                if #available(iOS 11.0, *) {
                    self.largeContentSizeImage = themeStyles.largeContentSizeImage;
                } else {
                    // Fallback on earlier versions
                }
                
            default: break;
                
            }
        }
        
        if let titleTextAttributes = themeStyles.selectedIfLoaded?.titleTextAttributes {
            self.setTitleTextAttributes(titleTextAttributes, for: .selected)
        }
        
        if let titleTextAttributes = themeStyles.disabledIfLoaded?.titleTextAttributes {
            self.setTitleTextAttributes(titleTextAttributes, for: .disabled)
        }
        
        if let titleTextAttributes = themeStyles.highlightedIfLoaded?.titleTextAttributes {
            self.setTitleTextAttributes(titleTextAttributes, for: .highlighted)
        }
        
        if #available(iOS 9.0, *) {
            if let titleTextAttributes = themeStyles.focusedIfLoaded?.titleTextAttributes {
                self.setTitleTextAttributes(titleTextAttributes, for: .focused)
            }
        }
        
    }
    
}

