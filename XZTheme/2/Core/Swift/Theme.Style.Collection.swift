//
//  Theme.Style.Collection.swift
//  XZKit
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

extension Theme.Style.Collection {
    
    /// 默认状态样式，Theme.State.normal 状态下的主题样式，当前集合自身。
    public var normal: Theme.Style {
        return self
    }
    
    /// Theme.State.highlighted 状态下的主题样式，懒加载。
    public var highlighted: Theme.Style {
        return themeStyle(forThemeState: .highlighted)
    }
    
    /// Theme.State.selected 状态下的主题样式，懒加载。
    public var selected: Theme.Style {
        return themeStyle(forThemeState: .selected)
    }
    
    /// Theme.State.disabled 状态下的主题样式，懒加载。
    public var disabled: Theme.Style {
        return themeStyle(forThemeState: .disabled)
    }
    
    /// Theme.State.focused 状态下的主题样式，懒加载。
    public var focused: Theme.Style {
        return themeStyle(forThemeState: .focused)
    }
    
    /// Theme.State.highlighted 状态下的主题样式，非懒加载。
    public var highlightedIfLoaded: Theme.Style? {
        return themeStyle(forThemeState: .highlighted)
    }
    
     /// Theme.State.selected 状态下的主题样式，非懒加载。
    public var selectedIfLoaded: Theme.Style? {
        return themeStyle(forThemeState: .selected)
    }
    
    /// Theme.State.disabled 状态下的主题样式，非懒加载。
    public var disabledIfLoaded: Theme.Style? {
        return themeStyle(forThemeState: .disabled)
    }
    
    /// Theme.State.focused 状态下的主题样式，非懒加载。
    public var focusedIfLoaded: Theme.Style? {
        return themeStyle(forThemeState: .focused)
    }
    
}

extension Theme.Style.Collection {
    
    /// 主题样式集合中的所有主题状态。
    /// - Note: 样式集合将主题样式按状态分类存储。
    /// - Note: 状态至少包含 normal 。
    public var themeStates: [Theme.State] {
        return [Theme.State.normal] + Array(statedStyles.keys)
    }
    
    /// 获取指定状态的主题样式。
    /// - Note: 如果主题样式不存在，将自动创建。
    ///
    /// - Parameter themeState: 主题状态。
    /// - Returns: 主题样式。
    public func themeStyle(forThemeState themeState: Theme.State) -> Theme.Style {
        if let themeStyle = themeStyleIfLoaded(forThemeState: themeState) {
            return themeStyle
        }
        let themeStyle = Theme.Style.init(self.object)
        setThemeStyle(themeStyle, forThemeState: themeState)
        return themeStyle
    }
    
    /// 获取指定状态的主题样式，如果已创建。
    ///
    /// - Parameter themeState: 主题状态。
    /// - Returns: 主题样式。
    public func themeStyleIfLoaded(forThemeState themeState: Theme.State) -> Theme.Style? {
        if themeState == .normal {
            return self
        }
        return statedStyles[themeState]
    }
    
    /// 设置指定状态下的主题样式。
    /// - Note: 无需设置状态状态 normal 的样式。
    /// - Note: 被设置的样式的所有者，必须与当前集合的所有者相同。
    ///
    /// - Parameters:
    ///   - themeStyle: 主题样式。
    ///   - themeState: 主题状态。
    public func setThemeStyle(_ themeStyle: Theme.Style, forThemeState themeState: Theme.State) {
        if themeState == .normal {
            return
        }
        guard themeStyle.object === self.object else {
            return
        }
        statedStyles[themeState] = themeStyle
        object.setNeedsThemeAppearanceUpdate()
    }
    
    /// 更新指定状态样式的链式编程支持。
    ///
    /// - Parameters:
    ///   - themeStyle: 主题样式。
    ///   - themeState: 主题样式状态。
    /// - Returns: 当前主题样式集合对象。
    @discardableResult
    public func setting(_ themeStyle: Theme.Style, for themeState: Theme.State) -> Theme.Style.Collection {
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
    @discardableResult
    public func setting(_ configuration: [Theme.Attribute: Any?], for themeState: Theme.State) -> Theme.Style.Collection {
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
    public func setThemeStyles(byUsing configuration: [Theme.State: [Theme.Attribute: Any?]]) {
        for item in configuration {
            setting(item.value, for: item.key)
        }
    }
    
}


extension Array where Element == Theme.State {
    
    /// 获取主题样式集合中所有已配置的状态。
    ///
    /// - Parameter themeStyleCollection: 主题样式集合。
    public init(_ themeStyleCollection: Theme.Style.Collection) {
        self.init(themeStyleCollection.statedStyles.keys)
    }
}


