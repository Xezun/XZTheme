//
//  Theme.Style.Collection.swift
//  Example
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

extension Theme.Style.Collection {
    
    public var themeStates: [Theme.State] {
        return Array(statedStyles.keys)
    }
    
    public func themeStyle(forThemeState themeState: Theme.State) -> Theme.Style {
        if let themeStyle = statedStyles[themeState] {
            return themeStyle
        }
        let themeStyle = Theme.Style.init(self.object)
        setThemeStyle(themeStyle, forThemeState: themeState)
        return themeStyle
    }
    
    public func themeStyleIfLoaded(forThemeState themeState: Theme.State) -> Theme.Style? {
        return statedStyles[themeState]
    }
    
    public func setThemeStyle(_ themeStyle: Theme.Style, forThemeState themeState: Theme.State) {
        statedStyles[themeState] = themeStyle
        object.setNeedsThemeAppearanceUpdate()
    }
    
    /// 更新指定状态样式的链式编程支持。
    ///
    /// - Parameters:
    ///   - themeStyle: 主题样式。
    ///   - themeState: 主题样式状态。
    /// - Returns: 当前主题样式集合对象。
    @discardableResult open func setting(_ themeStyle: Theme.Style, for themeState: Theme.State) -> Theme.Style.Collection {
        setThemeStyle(themeStyle, forThemeState: themeState)
        return self
    }
    
    /// 通过主题样式配置更新主题样式的链式编程支持。
    /// - Note: 属性值将以 NSNull 存储。
    ///
    /// - Parameters:
    ///   - configuration: 主题样式配置。
    ///   - themeState: 主题样式状态。
    /// - Returns: 当前主题样式集合对象。
    @discardableResult open func setting(_ configuration: [Theme.Attribute: Any?], for themeState: Theme.State) -> Theme.Style.Collection {
        let themeStyle: Theme.Style = self.themeStyle(forThemeState: themeState)
        for item in configuration {
            themeStyle.updateValue(item.value, forThemeAttribute: item.key)
        }
        return self
    }
    
    /// 通过样式配置字典来配置样式。使用指定类型的字典，方便使用预定义的值。
    /// - Note: 得益于 Swift 的字面量构造法，即使指定类型，构造配置字典并不是很繁琐。
    /// - Note: 灵活的配置字典可能会方便构造，但是对性能来说不一定值得。
    /// - Parameter configuration: 样式配置字典。
    open func setThemeStyles(byUsing configuration: [Theme.State: [Theme.Attribute: Any?]]) {
        for item in configuration {
            setting(item.value, for: item.key)
        }
    }
    
}


