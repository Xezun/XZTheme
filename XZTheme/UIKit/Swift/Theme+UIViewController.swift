//
//  Theme+UIViewController.swift
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZKit

extension Theme.Attribute {
    
    /// UIViewController.statusBarStyle
    public static let statusBarStyle = Theme.Attribute.init(rawValue: "statusBarStyle")
    
}

extension Theme.Style {
    
    /// 获取已设置的主题属性值：UIStatusBarStyle 。如下值将可以自动转换。
    /// 1. UIStatusBarStyle 原始值（Int）。
    /// 2. 字符串 default、lightContent 。
    ///
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 主题属性值。
    public func statusBarStyle(forThemeAttribute themeAttribute: Theme.Attribute) -> UIStatusBarStyle {
        guard let value = value(forThemeAttribute: themeAttribute) else { return .default }
        if let statusBarStyle = value as? UIStatusBarStyle {
            return statusBarStyle
        }
        if let number = value as? Int, let statusBarStyle = UIStatusBarStyle.init(rawValue: number) {
            return statusBarStyle
        }
        if let aString = value as? String {
            switch aString {
            case "default":      return .default
            case "lightContent": return .lightContent
            default: break
            }
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UIStatusBarStyle value, `.default` returned.", value, themeAttribute)
        return .default
    }
    
    public var statusBarStyle: UIStatusBarStyle {
        get { return statusBarStyle(forThemeAttribute: .statusBarStyle) }
        set { setValue(newValue, forThemeAttribute: .statusBarStyle)    }
    }
    
}

extension UIViewController {
    
    
    /// 自动应用样式：.title, .statusBarStyle 。
    ///
    /// - Parameter themeStyles: 主题样式。
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.title) {
            self.title = themeStyles.title
        }
        
        if themeStyles.containsThemeAttribute(.statusBarStyle) {
            self.statusBarStyle = themeStyles.statusBarStyle
        }
        
    }
    
}
