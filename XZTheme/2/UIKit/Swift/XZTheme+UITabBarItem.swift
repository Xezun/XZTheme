//
//  XZTheme+UITabBarItem.swift
//  Example
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit


extension Theme.Attribute {
    
    /// UITabBarItem.selectedImage
    public static let selectedImage = Theme.Attribute.init("selectedImage")
    /// UITabBarItem.titleTextAttributes
    public static let titleTextAttributes = Theme.Attribute.init("titleTextAttributes")
    /// UITabBarItem.landscapeImagePhone
    public static let landscapeImagePhone = Theme.Attribute.init("landscapeImagePhone")
    /// UITabBarItem.largeContentSizeImage
    public static let largeContentSizeImage = Theme.Attribute.init("largeContentSizeImage")
}

extension Theme.Style {
    
    public var selectedImage: UIImage? {
        get { return image(forThemeAttribute: .selectedImage) }
        set { setValue(newValue, forThemeAttribute: .selectedImage)}
    }
    
    public var titleTextAttributes: [NSAttributedStringKey : Any]? {
        get { return stringAttributes(forThemeAttribute: .titleTextAttributes) }
        set { setValue(newValue, forThemeAttribute: .titleTextAttributes) }
    }
    
    public var landscapeImagePhone: UIImage? {
        get { return image(forThemeAttribute: .landscapeImagePhone) }
        set { setValue(newValue, forThemeAttribute: .landscapeImagePhone)}
    }
    
    
    public var largeContentSizeImage: UIImage? {
        get { return image(forThemeAttribute: .largeContentSizeImage) }
        set { setValue(newValue, forThemeAttribute: .largeContentSizeImage)}
    }
    
}

extension UITabBarItem {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.selectedImage) {
            self.selectedImage = themeStyles.selectedImage
        }
        
        if themeStyles.containsThemeAttribute(.image) {
            self.image = themeStyles.image
        }
        
        if themeStyles.containsThemeAttribute(.title) {
            self.title = themeStyles.title
        }
        
        if themeStyles.containsThemeAttribute(.landscapeImagePhone) {
            self.landscapeImagePhone = themeStyles.landscapeImagePhone
        }
        
        if #available(iOS 11.0, *) {
            if themeStyles.containsThemeAttribute(.largeContentSizeImage) {
                self.largeContentSizeImage = themeStyles.largeContentSizeImage
            }
        }
        
        if themeStyles.containsThemeAttribute(.titleTextAttributes) {
            self.setTitleTextAttributes(themeStyles.titleTextAttributes, for: .normal)
        }
        
        if let themeStyle = themeStyles.selectedIfLoaded {
            if themeStyle.containsThemeAttribute(.titleTextAttributes) {
                self.setTitleTextAttributes(themeStyle.titleTextAttributes, for: .selected)
            }
        }
        
        if let themeStyle = themeStyles.disabledIfLoaded {
            if themeStyle.containsThemeAttribute(.titleTextAttributes) {
                self.setTitleTextAttributes(themeStyle.titleTextAttributes, for: .disabled)
            }
        }
        
        if let themeStyle = themeStyles.highlightedIfLoaded {
            if themeStyle.containsThemeAttribute(.titleTextAttributes) {
                self.setTitleTextAttributes(themeStyle.titleTextAttributes, for: .highlighted)
            }
        }
        
        if #available(iOS 9.0, *) {
            if let themeStyle = themeStyles.focusedIfLoaded {
                if themeStyle.containsThemeAttribute(.titleTextAttributes) {
                    self.setTitleTextAttributes(themeStyle.titleTextAttributes, for: .focused)
                }
            }
        }
        

    }
    
}
