//
//  Theme.Style.swift
//  XZKit
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

extension Theme.Style {
    
    /// 主题样式是否包含主题属性。
    /// - Note: 因为属性值可以为 nil ，所以判断是否包含属性，不能根据其值来判断。
    ///
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 是否包含。
    @objc public func contains(_ themeAttribute: Theme.Attribute) -> Bool {
        return (attributedValuesIfLoaded?.keys.contains(themeAttribute) == true)
    }
    
    /// 获取已设置的主题属性值，返回值可能是全局主题集中的值。
    ///
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 主题属性值。
    @objc public func value(for themeAttribute: Theme.Attribute) -> Any? {
        guard let value = attributedValuesIfLoaded?[themeAttribute] else {
            return nil
        }
        return value
    }
    
    /// 获取/添加/更新/删除主题属性值。
    ///
    /// - Parameter themeAttribute: 主题属性。
    @objc public subscript(themeAttribute: Theme.Attribute) -> Any? {
        get { return self.value(for: themeAttribute)       }
        set { self.setValue(newValue, for: themeAttribute) }
    }
    
    /// 配置主题样式的链式编程方式支持。
    ///
    /// - Parameters:
    ///   - value: 主题属性值。
    ///   - themeAttribute: 主题属性。
    /// - Returns: 当前主题样式对象。
    @discardableResult
    open func setting(_ value: Any?, for themeAttribute: Theme.Attribute) -> Theme.Style {
        self.setValue(value, for: themeAttribute)
        return self
    }
    
    /// 更新主题属性值。链式编程支持。
    ///
    /// - Parameters:
    ///   - value: 主题属性值。
    ///   - themeAttribute: 主题属性。
    @discardableResult
    public func updating(_ value: Any?, for themeAttribute: Theme.Attribute) -> Theme.Style {
        updateValue(value, for: themeAttribute)
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
            updateValue(attributedValue.value, for: attributedValue.key)
        }
    }
    
}



