//
//  Theme+UITabBar.swift
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZKit

extension Theme.Attribute {
    
    /// UITabBar, UISearchBar
    public static let barTintColor = Theme.Attribute.init("barTintColor")
    /// UITabBar.shadowImage
    public static let shadowImage = Theme.Attribute.init("shadowImage")
    /// UITabBar.unselectedItemTintColor
    public static let unselectedItemTintColor = Theme.Attribute.init("unselectedItemTintColor")
    /// UITabBar.selectionIndicatorImage
    public static let selectionIndicatorImage = Theme.Attribute.init("selectionIndicatorImage")
    /// UITabBar, UISearchBar
    public static let barStyle = Theme.Attribute.init("barStyle")
    /// UITabBar, UISearchBar
    public static let isTranslucent = Theme.Attribute.init("isTranslucent")
    // UITabBar.backgroundImage
    // See UIButton.
    
}

extension Theme.Style {
    
    /// 如果存储的值不是 UIBarStyle 或 UIBarStyle 有效原始值，则返回 UIBarStyle.default 。
    /// 字符串 default、black 可转换对应的 UIBarStyle 值。
    ///
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 主题属性值 UIBarStyle 。
    public func barStyle(forThemeAttribute themeAttribute: Theme.Attribute) -> UIBarStyle {
        guard let value = value(forThemeAttribute: themeAttribute) else { return .default }
        if let barStyle = value as? UIBarStyle {
            return barStyle
        }
        if let number = value as? Int, let barStyle = UIBarStyle(rawValue: number) {
            return barStyle
        }
        if let aString = value as? String {
            switch aString {
            case "default":  return .default
            case "black": return .black
            default: break
            }
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UIBarStyle value, `.default` returned.", value, themeAttribute)
        return .default
    }
    
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
