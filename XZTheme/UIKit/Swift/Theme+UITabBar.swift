//
//  Theme+UITabBar.swift
//  XZKit
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
    /// UITabBar.barStyle
    public static let barStyle = Theme.Attribute.init("barStyle")
    /// UITabBar.isTranslucent
    public static let isTranslucent = Theme.Attribute.init("isTranslucent")
    // UITabBar.backgroundImage
    // See UIButton.
    
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
    
    public var barStyle: UIBarStyle {
        get { return barStyle(forThemeAttribute: .barStyle) }
        set { setValue(newValue, forThemeAttribute: .barStyle)  }
    }
    
    public var isTranslucent: Bool {
        get { return boolValue(forThemeAttribute: .isTranslucent) }
        set { setValue(newValue, forThemeAttribute: .isTranslucent) }
    }
    
    /// public var backgroundImage: UIImage?
    
}

extension UITabBar {
    
    /// 默认情况下，UITabBar 不向其子视图发送主题变更事件。
    open override var forwardsThemeAppearanceUpdate: Bool {
        return false
    }
    
    /// 除父类应用的属性以外，UITabBar 自动应用以下属性样式：
    /// - .barTintColor, .shadowImage, .backgroundImage, .selectionIndicatorImage, .barStyle, .isTranslucent, unselectedItemTintColor
    ///
    /// - Parameter themeStyles: 主题样式。
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
        
        if themeStyles.containsThemeAttribute(.barStyle) {
            self.barStyle = themeStyles.barStyle
        }
        
        if themeStyles.containsThemeAttribute(.isTranslucent) {
            self.isTranslucent = themeStyles.isTranslucent
        }
        
        if #available(iOS 10.0, *) {
            if themeStyles.containsThemeAttribute(.unselectedItemTintColor) {
                self.unselectedItemTintColor = themeStyles.unselectedItemTintColor
            }
        }

    }
    
}
