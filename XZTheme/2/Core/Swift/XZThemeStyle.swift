//
//  XZThemeStyle.swift
//  Example
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

extension Theme.Style {
    
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
    
}
