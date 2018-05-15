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
    @objc(normalThemeStyle) public var normal: Theme.Style {
        return self
    }
    
    /// Theme.State.highlighted 状态下的主题样式，懒加载。
    @objc(highlightedThemeStyle) public var highlighted: Theme.Style {
        return themeStyle(forThemeState: .highlighted)
    }
    
    /// Theme.State.selected 状态下的主题样式，懒加载。
    @objc(selectedThemeStyle) public var selected: Theme.Style {
        return themeStyle(forThemeState: .selected)
    }
    
    /// Theme.State.disabled 状态下的主题样式，懒加载。
    @objc(disabledThemeStyle) public var disabled: Theme.Style {
        return themeStyle(forThemeState: .disabled)
    }
    
    /// Theme.State.focused 状态下的主题样式，懒加载。
    @objc(focusedThemeStyle) public var focused: Theme.Style {
        return themeStyle(forThemeState: .focused)
    }
    
    /// Theme.State.highlighted 状态下的主题样式，非懒加载。
    @objc(highlightedThemeStyleIfLoaded) public var highlightedIfLoaded: Theme.Style? {
        return themeStyleIfLoaded(forThemeState: .highlighted)
    }
    
     /// Theme.State.selected 状态下的主题样式，非懒加载。
    @objc(selectedThemeStyleIfLoaded) public var selectedIfLoaded: Theme.Style? {
        return themeStyleIfLoaded(forThemeState: .selected)
    }
    
    /// Theme.State.disabled 状态下的主题样式，非懒加载。
    @objc(disabledThemeStyleIfLoaded) public var disabledIfLoaded: Theme.Style? {
        return themeStyleIfLoaded(forThemeState: .disabled)
    }
    
    /// Theme.State.focused 状态下的主题样式，非懒加载。
    @objc(focusedThemeStyleIfLoaded) public var focusedIfLoaded: Theme.Style? {
        return themeStyleIfLoaded(forThemeState: .focused)
    }
    
}

extension Theme.Style.Collection {
    
    /// 获取指定状态的主题样式，如果主题样式不存在，将自动创建。
    ///
    /// - Parameter themeState: 主题状态。
    /// - Returns: 主题样式。
    @objc public func themeStyle(forThemeState themeState: Theme.State) -> Theme.Style {
        if let themeStyle = themeStyleIfLoaded(forThemeState: themeState) {
            return themeStyle
        }
        let themeStyle = Theme.Style.init(object: self.object, theme: self.theme, state: themeState)
        setThemeStyle(themeStyle, forThemeState: themeState)
        return themeStyle
    }
    
    /// 获取指定状态的主题样式，如果已创建。
    /// - Note: 该方法不会返回全局的主题样式集，以避免全局主题样式被意外修改。
    ///
    /// - Parameter themeState: 主题状态。
    /// - Returns: 主题样式。
    @objc public func themeStyleIfLoaded(forThemeState themeState: Theme.State) -> Theme.Style? {
        if themeState == .normal {
            return self
        }
        return statedThemeStyles[themeState]
    }
    
    /// 设置指定状态下的主题样式。
    /// - Note: 无需设置状态状态 normal 的样式。
    /// - Note: 被设置的样式的所有者，必须与当前集合的所有者相同。
    ///
    /// - Parameters:
    ///   - themeStyle: 主题样式。
    ///   - themeState: 主题状态。
    @objc public func setThemeStyle(_ themeStyle: Theme.Style, forThemeState themeState: Theme.State) {
        if themeState == .normal {
            return
        }
        guard themeStyle.object === self.object else {
            return
        }
        statedThemeStyles[themeState] = themeStyle
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
    
    /// 从另外一个样式集中复制所有样式。
    /// - Note: 如果相同状态的样式已存在，则合并两个样式，否则添加。
    /// - Note: 被复制的主题集相关联的全局样式不会被复制。
    ///
    /// - Parameter themeStyles: 被复制的主题集。
    @objc public func addThemeStyle(from themeStyles: Theme.Style.Collection) {
        guard let statedThemeStyles = themeStyles.statedThemeStylesIfLoaded else { return }
        for statedThemeStyle in statedThemeStyles {
            if let oldValue = self.themeStyleIfLoaded(forThemeState: statedThemeStyle.key) {
                oldValue.addValuesAndAttributes(from: statedThemeStyle.value)
            } else {
                self.setThemeStyle(statedThemeStyle.value, forThemeState: statedThemeStyle.key)
            }
        }
    }
    
    
    /// 当前所有者的全局的主题样式集。
    @objc public var defaultThemeStyles: Theme.Style.Collection? {
        guard let object = self.object else { return nil }
        let objectClass = type(of: object)
        if let themeIdentifier = object.themeIdentifier {
            if let themes = objectClass.themesIfLoaded(forThemeIdentifier: themeIdentifier) {
                if let themeStyles = themes.themeStylesIfLoaded(forTheme: self.theme) {
                    return themeStyles
                }
            }
        }
        return type(of: object).themesIfLoaded?.themeStylesIfLoaded(forTheme: self.theme)
    }
    
    /// 获取指定状态下的主题属性值。
    /// - Note: 如果没有配置主题样式，会尝试读取全局主题样式。
    ///
    /// - Parameters:
    ///   - themeAttribute: 主题属性。
    ///   - themeState: 主题状态。
    /// - Returns: 主题属性值。
    public func value(forThemeAttribute themeAttribute: Theme.Attribute, forThemeState themeState: Theme.State) -> Any? {
        if let themeStyle = themeStyleIfLoaded(forThemeState: themeState) {
            return themeStyle.value(forThemeAttribute: themeAttribute)
        }
        return defaultThemeStyles?.value(forThemeAttribute: themeAttribute, forThemeState: themeState)
    }
    
    
    /// 设置指定状态下的主题属性值。
    ///
    /// - Parameters:
    ///   - value: 主题属性值。
    ///   - themeAttribute: 主题属性。
    ///   - themeState: 主题状态。
    public func setValue(_ value: Any?, forThemeAttribute themeAttribute: Theme.Attribute, forThemeState themeState: Theme.State) {
        self.themeStyle(forThemeState: themeState).setValue(value, forThemeAttribute: themeAttribute)
    }
    
    /// 判断样式中是否包含指定状态下的主题属性。
    ///
    /// - Parameters:
    ///   - themeAttribute: 主题属性。
    ///   - themeState: 主题状态。
    /// - Returns: 是否包含。
    public func containsThemeAttribute(_ themeAttribute: Theme.Attribute, forThemeState themeState: Theme.State) -> Bool {
        if let themeStyle = themeStyleIfLoaded(forThemeState: themeState) {
            return themeStyle.containsThemeAttribute(themeAttribute)
        }
        return defaultThemeStyles?.containsThemeAttribute(themeAttribute) == true
    }
    
    /// 指定状态下，当前生效的主题样式。
    /// - Note: 如果当前对象没有配置该状态的样式，则返回全局设置下的指定样式（如果有）。
    ///
    /// - Parameter themeState: 主题状态。
    /// - Returns: 主题样式。
    @objc public func effectiveThemeStyleIfLoaded(forThemeState themeState: Theme.State) -> Theme.Style? {
        if let themeStyle = themeStyleIfLoaded(forThemeState: themeState) {
            return themeStyle
        }
        return defaultThemeStyles?.themeStyleIfLoaded(forThemeState: themeState)
    }
}


