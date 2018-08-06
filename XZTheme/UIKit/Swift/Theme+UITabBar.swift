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
    public static let barTintColor              = Theme.Attribute.init(rawValue: "barTintColor")
    /// UITabBar.shadowImage
    public static let shadowImage               = Theme.Attribute.init(rawValue: "shadowImage")
    /// UITabBar.unselectedItemTintColor
    public static let unselectedItemTintColor   = Theme.Attribute.init(rawValue: "unselectedItemTintColor")
    /// UITabBar.selectionIndicatorImage
    public static let selectionIndicatorImage   = Theme.Attribute.init(rawValue: "selectionIndicatorImage")
    /// UITabBar, UISearchBar
    public static let barStyle                  = Theme.Attribute.init(rawValue: "barStyle")
    /// UITabBar, UISearchBar
    public static let isTranslucent             = Theme.Attribute.init(rawValue: "isTranslucent")
    // UITabBar.backgroundImage
    // See UIButton.
    
}

extension Theme.Style {
    
    /// 如果存储的值不是 UIBarStyle 或 UIBarStyle 有效原始值，则返回 UIBarStyle.default 。
    /// 字符串 default、black 可转换对应的 UIBarStyle 值。
    ///
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 主题属性值 UIBarStyle 。
    public func barStyle(for themeAttribute: Theme.Attribute) -> UIBarStyle {
        guard let value = value(for: themeAttribute) else { return .default }
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
        get { return color(for: .barTintColor)        }
        set { setValue(newValue, for: .barTintColor)  }
    }
    
    public var shadowImage: UIImage? {
        get { return image(for: .shadowImage) }
        set { setValue(newValue, for: .shadowImage) }
    }
    
    public var unselectedItemTintColor: UIColor? {
        get { return color(for: .unselectedItemTintColor) }
        set { setValue(newValue, for: .unselectedItemTintColor) }
    }
    
    public var selectionIndicatorImage: UIImage? {
        get { return image(for: .selectionIndicatorImage)          }
        set { setValue(newValue, for: .selectionIndicatorImage)    }
    }
    
    public var barStyle: UIBarStyle {
        get { return barStyle(for: .barStyle) }
        set { setValue(newValue, for: .barStyle)  }
    }
    
    public var isTranslucent: Bool {
        get { return boolValue(for: .isTranslucent) }
        set { setValue(newValue, for: .isTranslucent) }
    }
    
    /// public var backgroundImage: UIImage?
    
}

extension UITabBar {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)

        if themeStyles.contains(.barTintColor) {
            self.barTintColor = themeStyles.barTintColor
        }
        
        if themeStyles.contains(.shadowImage) {
            self.shadowImage = themeStyles.shadowImage
        }
        
        if themeStyles.contains(.backgroundImage) {
            self.backgroundImage = themeStyles.backgroundImage
        }
        
        if themeStyles.contains(.selectionIndicatorImage) {
            self.selectionIndicatorImage = themeStyles.selectionIndicatorImage
        }
        
        if themeStyles.contains(.barStyle) {
            self.barStyle = themeStyles.barStyle
        }
        
        if themeStyles.contains(.isTranslucent) {
            self.isTranslucent = themeStyles.isTranslucent
        }
        
        if #available(iOS 10.0, *) {
            if themeStyles.contains(.unselectedItemTintColor) {
                self.unselectedItemTintColor = themeStyles.unselectedItemTintColor
            }
        }

    }
    
}
