//
//  XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/10/25.
//

import Foundation
import XZKit

extension Theme.Style {
    
    /// 获取已设置的整数主题属性值，值转换规则：
    /// 1. 非 Int 值都返回 0 。
    ///
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func integerValue(forThemeAttribute themeAttribute: Theme.Attribute) -> Int {
        guard let value = self.value(forThemeAttribute: themeAttribute) else { return 0 }
        if let number = value as? Int {
            return number
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not an Int value, `0` returned.", value, themeAttribute)
        return 0
    }
    
    /// 获取已设置的浮点数主题属性值，非 Float 值将如下转换：
    /// 1. 如果值为 Int/Double ，则会被转换为相应的 Float 值。
    /// 2. 其它情况一律返回 0 。
    ///
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func floatValue(forThemeAttribute themeAttribute: Theme.Attribute) -> Float {
        guard let value = self.value(forThemeAttribute: themeAttribute) else { return 0 }
        if let number = value as? Float {
            return number
        }
        if let number = value as? Double {
            return Float(number)
        }
        if let number = value as? Int {
            return Float(number)
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a Float value, `0` returned.", value, themeAttribute)
        return 0
    }
    
    /// 获取已设置的浮点数主题属性值，非 CGFloat 值将如下转换：
    /// 1. 如果值为 Int/Double/Float ，则会被转换为相应的 CGFloat 值。
    /// 2. 其它情况一律返回 0 。
    ///
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func floatValue(forThemeAttribute themeAttribute: Theme.Attribute) -> CGFloat {
        guard let value = self.value(forThemeAttribute: themeAttribute) else { return 0 }
        if let number = value as? CGFloat {
            return number
        }
        if let number = value as? Int {
            return CGFloat(number)
        }
        if let number = value as? Double {
            return CGFloat(number)
        }
        if let number = value as? Float {
            return CGFloat(number)
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a CGFloat value, `0` returned.", value, themeAttribute)
        return 0
    }
    
    /// 获取已设置的双浮点数主题属性值。
    /// - Note: 非 Int/Double 值都返回 0 。
    ///
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func doubleValue(forThemeAttribute themeAttribute: Theme.Attribute) -> Double {
        guard let value = self.value(forThemeAttribute: themeAttribute) else { return 0 }
        if let number = value as? Double {
            return number
        }
        if let number = value as? Int {
            return Double(number)
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a Double value, `0` returned.", value, themeAttribute)
        return 0
    }
    
    /// 获取已设置的主题属性布尔值。
    /// - Note: 非 Bool 值都返回 false 。
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func boolValue(forThemeAttribute themeAttribute: Theme.Attribute) -> Bool {
        guard let value = self.value(forThemeAttribute: themeAttribute) else { return false }
        if let number = value as? Bool {
            return number
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a Bool value, `false` returned.", value, themeAttribute)
        return false
    }
    
    /// 获取已设置的主题属性值：字符串。
    /// - 非字符串对象将返回其 describing 值。
    ///
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func stringValue(forThemeAttribute themeAttribute: Theme.Attribute) -> String? {
        guard let value = self.value(forThemeAttribute: themeAttribute) else { return nil }
        if let string = value as? String {
            return string
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a String value, `describing` returned.", value, themeAttribute)
        return String.init(describing: value)
    }
    
    /// 获取已设置的主题属性值：图片。
    /// - Note: 使用 Theme.parser 来解析已存储的属性值。
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func image(forThemeAttribute themeAttribute: Theme.Attribute) -> UIImage? {
        return Theme.parser.parse(self.value(forThemeAttribute: themeAttribute))
    }
    
    /// 获取已设置的主题属性值：图片。
    /// - Note: 使用 Theme.parser 来解析已存储的属性值。
    ///
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 主题属性值。
    public func images(forThemeAttribute themeAttribute: Theme.Attribute) -> [UIImage]? {
        return Theme.parser.parse(self.value(forThemeAttribute: themeAttribute))
    }
    
    /// 获取已设置的主题属性值：颜色。
    /// - Note: 使用 Theme.parser 来解析已存储的属性值。
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func color(forThemeAttribute themeAttribute: Theme.Attribute) -> UIColor? {
        return Theme.parser.parse(self.value(forThemeAttribute: themeAttribute))
    }
    
    /// 获取已设置的主题属性值：字体。
    /// - Note: 使用 Theme.parser 来解析已存储的属性值。
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func font(forThemeAttribute themeAttribute: Theme.Attribute) -> UIFont? {
        return Theme.parser.parse(self.value(forThemeAttribute: themeAttribute))
    }
    
    /// 获取已设置的主题属性值：富文本。
    /// - Note: 使用 Theme.parser 来解析已存储的属性值。
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func attributedString(forThemeAttribute themeAttribute: Theme.Attribute) -> NSAttributedString? {
        return Theme.parser.parse(value(forThemeAttribute: themeAttribute))
    }
    
    /// 获取已设置的主题属性值：富文本属性。
    /// - Note: 使用 Theme.parser 来解析已存储的属性值。
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func stringAttributes(forThemeAttribute themeAttribute: Theme.Attribute) -> [NSAttributedStringKey: Any]? {
        return Theme.parser.parse(value(forThemeAttribute: themeAttribute))
    }
    
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
    
    /// 获取已设置的主题属性值：UIScrollViewIndicatorStyle 。如下值将可以自动转换。
    /// 1. UIScrollViewIndicatorStyle 原始值（Int）。
    /// 2. 字符串 default、black、white 。
    ///
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 主题属性值。
    public func indicatorStyle(forThemeAttribute themeAttribute: Theme.Attribute) -> UIScrollViewIndicatorStyle {
        guard let value = value(forThemeAttribute: themeAttribute) else { return .default }
        if let indicatorStyle = value as? UIScrollViewIndicatorStyle {
            return indicatorStyle
        }
        if let number = value as? Int, let indicatorStyle = UIScrollViewIndicatorStyle.init(rawValue: number) {
            return indicatorStyle
        }
        if let aString = value as? String {
            switch aString {
            case "default": return .default
            case "black":   return .black
            case "white":   return .white
            default: break
            }
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UIScrollViewIndicatorStyle value, `.default` returned.", value, themeAttribute)
        return .default
    }
}



