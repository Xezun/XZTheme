//
//  UITabBarItem+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit


extension UITabBarItem {
    
    open override func updateAppearance(with themeStyle: Theme.Style, for themeAttribute: Theme.Attribute) {
        switch themeAttribute {
        case .selectedImage:
            self.selectedImage = themeStyle.selectedImage;
            
        case .image:
            self.image = themeStyle.image;
            
        case .title:
            self.title = themeStyle.title;
            
        case .titleTextAttributes:
            self.setTitleTextAttributes(themeStyle.titleTextAttributes(forState: .normal), for: .normal);
            self.setTitleTextAttributes(themeStyle.titleTextAttributes(forState: .selected), for: .selected);
            
        case .largeContentSizeImage:
            if #available(iOS 11.0, *) {
                self.largeContentSizeImage = themeStyle.largeContentSizeImage;
            } else {
                // Fallback on earlier versions
            }
            
        case .landscapeImagePhone:
            self.landscapeImagePhone = themeStyle.landscapeImagePhone;
            
        default: break;
            
        }
    }
    
}

