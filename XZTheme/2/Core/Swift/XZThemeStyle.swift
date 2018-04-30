//
//  XZThemeStyle.swift
//  Example
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation
import XZKit

extension Theme.Style {
    
    /// 获取已设置的整数主题属性值。
    /// - Note: 非 Int 值都返回 0 。
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func integerValue(forThemeAttribute themeAttribute: Theme.Attribute) -> Int {
        guard let value = self.value(forThemeAttribute: themeAttribute) else { return 0 }
        if let number = value as? Int {
            return number
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not an Int value.", value, themeAttribute)
        return 0
    }
    
    /// 获取已设置的浮点数主题属性值。
    /// - Note: 非 Float/Double 值都返回 0 。
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
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a Float value.", value, themeAttribute)
        return 0
    }
    
    /// 获取已设置的双浮点数主题属性值。
    /// - Note: 非 Int/Double 值都返回 0 。
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
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a Double value.", value, themeAttribute)
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
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a Bool value.", value, themeAttribute)
        return false
    }
    
    /// 获取已设置的主题属性值：字符串。
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func stringValue(forThemeAttribute themeAttribute: Theme.Attribute) -> String? {
        guard let value = self.value(forThemeAttribute: themeAttribute) else { return nil }
        if let string = value as? String {
            return string
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a String value.", value, themeAttribute)
        return nil
    }
    
    /// 获取已设置的主题属性值：图片。
    /// - Note: 使用 Theme.imageParser 来解析已存储的属性值。
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func image(forThemeAttribute themeAttribute: Theme.Attribute) -> UIImage? {
        return Theme.imageParser1.parse(self.value(forThemeAttribute: themeAttribute))
    }
    
    public func images(forThemeAttribute themeAttribute: Theme.Attribute) -> [UIImage]? {
        return Theme.imageParser1.parse(self.value(forThemeAttribute: themeAttribute))
    }
    
    /// 获取已设置的主题属性值：颜色。
    /// - Note: 使用 Theme.colorParser 来解析已存储的属性值。
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func color(forThemeAttribute themeAttribute: Theme.Attribute) -> UIColor? {
        return Theme.colorParser1.parse(self.value(forThemeAttribute: themeAttribute))
    }
    
    /// 获取已设置的主题属性值：字体。
    /// - Note: 使用 Theme.fontParser 来解析已存储的属性值。
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func font(forThemeAttribute themeAttribute: Theme.Attribute) -> UIFont? {
        return Theme.fontParser1.parse(self.value(forThemeAttribute: themeAttribute))
    }
    
    /// 获取已设置的主题属性值：富文本。
    /// - Note: 使用 Theme.attribtedStringParser 来解析已存储的属性值。
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func attributedString(forThemeAttribute themeAttribute: Theme.Attribute) -> NSAttributedString? {
        return Theme.attribtedStringParser1.parse(value(forThemeAttribute: themeAttribute))
    }
    
    /// 获取已设置的主题属性值：富文本属性。
    /// - Note: 使用 Theme.stringAttributesParser 来解析已存储的属性值。
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 属性值。
    public func stringAttributes(forThemeAttribute themeAttribute: Theme.Attribute) -> [NSAttributedStringKey: Any]? {
        return Theme.stringAttributesParser1.parse(value(forThemeAttribute: themeAttribute))
    }
    
}

extension Theme.Style {
    
    /// 配置主题样式的链式编程方式支持。
    ///
    /// - Parameters:
    ///   - value: 主题属性值。
    ///   - themeAttribute: 主题属性。
    ///  当前主题样式对象。
    @discardableResult
    open func setting(_ value: Any?, for themeAttribute: Theme.Attribute) -> Theme.Style {
        setValue(value, forThemeAttribute: themeAttribute)
        return self
    }
    
}
