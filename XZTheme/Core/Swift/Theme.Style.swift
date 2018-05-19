//
//  Theme.Style.swift
//  XZKit
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

extension Theme.Style {
    
    /// 当前主题样式所在主题集的父集中，与当前主题样式（主题、状态）相同的主题样式。
    @objc public var superThemeStyle: Theme.Style? {
        return self.themes.superThemes?.effectiveThemeStyles(forTheme: self.theme)?.effectiveThemeStyle(forThemeState: self.state)
    }
    
    
    /// 主题样式是否包含主题属性。
    /// - Note: 因为属性值可以为 nil ，所以判断是否包含属性，不能根据其值来判断。
    ///
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 是否包含。
    @objc public func containsThemeAttribute(_ themeAttribute: Theme.Attribute) -> Bool {
        guard attributedValuesIfLoaded?[themeAttribute] == nil else {
            return true
        }
        return self.superThemeStyle?.containsThemeAttribute(themeAttribute) == true
    }
    
    /// 添加/更新/删除主题属性值。
    /// - Note: 设置 nil 值，请使用 updateValue(_:forThemeAttribute:) 方法。
    ///
    /// - Parameter value: 主题属性值。
    /// - Parameter themeAttribute: 主题属性。
    @objc public func setValue(_ value: Any?, forThemeAttribute themeAttribute: Theme.Attribute) {
        attributedValues[themeAttribute] = value
    }
    
    /// 添加/更新/删除主题属性值。
    ///
    /// - Parameter value: 主题属性值。
    /// - Parameter themeAttribute: 主题属性。
    @objc public func updateValue(_ value: Any?, forThemeAttribute themeAttribute: Theme.Attribute) {
        attributedValues.updateValue(value, forKey: themeAttribute)
    }
    
    /// 删除主题属性值。
    ///
    /// - Parameter themeAttribute: 主题属性。
    @objc public func removeValue(forThemeAttribute themeAttribute: Theme.Attribute) -> Any? {
        if let value = attributedValuesIfLoaded?.removeValue(forKey: themeAttribute) {
            return value
        }
        return nil
    }
    
    /// 获取已设置的主题属性值，返回值可能是全局主题集中的值。
    ///
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 主题属性值。
    @objc public func value(forThemeAttribute themeAttribute: Theme.Attribute) -> Any? {
        if let value = attributedValuesIfLoaded?[themeAttribute] {
            return value
        }
        /// 读取全局配置。
        if let value = self.superThemeStyle?.value(forThemeAttribute: themeAttribute) {
            return value
        }
        return nil
    }
    
    /// 获取/添加/更新/删除主题属性值。
    ///
    /// - Parameter themeAttribute: 主题属性。
    @objc public subscript(themeAttribute: Theme.Attribute) -> Any? {
        get { return value(forThemeAttribute: themeAttribute)       }
        set { setValue(newValue, forThemeAttribute: themeAttribute) }
    }
    
    /// 配置主题样式的链式编程方式支持。
    ///
    /// - Parameters:
    ///   - value: 主题属性值。
    ///   - themeAttribute: 主题属性。
    /// - Returns: 当前主题样式对象。
    @discardableResult
    open func setting(_ value: Any?, for themeAttribute: Theme.Attribute) -> Theme.Style {
        setValue(value, forThemeAttribute: themeAttribute)
        return self
    }
    
    /// 更新主题属性值。链式编程支持。
    ///
    /// - Parameters:
    ///   - value: 主题属性值。
    ///   - themeAttribute: 主题属性。
    @discardableResult
    public func updating(_ value: Any?, for themeAttribute: Theme.Attribute) -> Theme.Style {
        updateValue(value, forThemeAttribute: themeAttribute)
        return self
    }
    
    /// 从另外一个样式中复制属性和值。
    /// - Note: 当前样式中已有的值，将会被替换。
    /// - Note: 不会复制被复制样式相关联的全局样式。
    ///
    /// - Parameter themeStyle: 被复制的样式。
    @objc public func addValuesAndAttributes(from themeStyle: Theme.Style) {
        guard let attributedValues = themeStyle.attributedValuesIfLoaded else { return }
        for attributedValue in attributedValues {
            updateValue(attributedValue.value, forThemeAttribute: attributedValue.key)
        }
    }
    
}



