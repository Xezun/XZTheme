//
//  XZTheme+UITabBar.swift
//  Example
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

extension Theme.Attribute {
    
    /// UITabBar.barTintColor
    public static let barTintColor = Theme.Attribute.init("barTintColor")
    /// UITabBar.shadowImage
    public static let shadowImage = Theme.Attribute.init("shadowImage")
    /// UITabBar.unselectedItemTintColor
    public static let unselectedItemTintColor = Theme.Attribute.init("unselectedItemTintColor")
    /// UITabBar.selectionIndicatorImage
    public static let selectionIndicatorImage = Theme.Attribute.init("selectionIndicatorImage")
    /// UITabBar.backgroundImage
    
}

extension Theme.Style {
    
    public var barTintColor: UIColor? {
        get { return color(forThemeAttribute: .barTintColor)        }
        set { setValue(newValue, forThemeAttribute: .barTintColor)  }
    }
    
    public var shadowImage: UIImage? {
        get { return image(forThemeAttribute: .shadowImage) }
        set { setValue(newValue, forThemeAttribute: .shadowImage) }
    }
    
    public var unselectedItemTintColor: UIColor? {
        get { return color(forThemeAttribute: .unselectedItemTintColor) }
        set { setValue(newValue, forThemeAttribute: .unselectedItemTintColor) }
    }
    
    public var selectionIndicatorImage: UIImage? {
        get { return image(forThemeAttribute: .selectionIndicatorImage)          }
        set { setValue(newValue, forThemeAttribute: .selectionIndicatorImage)    }
    }
    
    /// public var backgroundImage: UIImage?
    
}

extension UITabBar {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.barTintColor) {
            self.barTintColor = themeStyles.barTintColor
        }
        
        if themeStyles.containsThemeAttribute(.shadowImage) {
            self.shadowImage = themeStyles.shadowImage
        }
        
        if themeStyles.containsThemeAttribute(.backgroundImage) {
            self.backgroundImage = themeStyles.backgroundImage
        }
        
        if themeStyles.containsThemeAttribute(.selectionIndicatorImage) {
            self.selectionIndicatorImage = themeStyles.selectionIndicatorImage
        }
        
        if #available(iOS 10.0, *) {
            if themeStyles.containsThemeAttribute(.unselectedItemTintColor) {
                self.unselectedItemTintColor = themeStyles.unselectedItemTintColor
            }
        }

    }
    
}
