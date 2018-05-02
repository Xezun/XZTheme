//
//  Theme.Style.swift
//  Example
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

extension Theme.Style {
    
    public var themeAttributes: [Theme.Attribute] {
        return Array(attributedValues.keys)
    }
    
    public func containsThemeAttribute(_ themeAttribute: Theme.Attribute) -> Bool {
        return attributedValues[themeAttribute] != nil
    }
    
    public func setValue(_ value: Any?, forThemeAttribute themeAttribute: Theme.Attribute) {
        attributedValues[themeAttribute] = value
        object.setNeedsThemeAppearanceUpdate()
    }
    
    public func updateValue(_ value: Any?, forThemeAttribute themeAttribute: Theme.Attribute) {
        attributedValues.updateValue(value, forKey: themeAttribute)
        object.setNeedsThemeAppearanceUpdate()
    }
    
    public func removeValue(forThemeAttribute themeAttribute: Theme.Attribute) -> Any? {
        object.setNeedsThemeAppearanceUpdate()
        if let value = attributedValues.removeValue(forKey: themeAttribute) {
            return value
        }
        return nil
    }
    
    public func value(forThemeAttribute themeAttribute: Theme.Attribute) -> Any? {
        if let value = attributedValues[themeAttribute] {
            return value
        }
        return nil
    }
    
    public subscript(themeAttribute: Theme.Attribute) -> Any? {
        get { return value(forThemeAttribute: themeAttribute)       }
        set { setValue(newValue, forThemeAttribute: themeAttribute) }
    }
    
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

