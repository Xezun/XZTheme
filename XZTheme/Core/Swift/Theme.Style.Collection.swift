//
//  Theme.Style.Collection.swift
//  XZKit
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation
import XZKit

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

}

extension Theme.Style.Collection {
    
    /// 获取指定状态的主题样式，如果主题样式不存在，将自动创建。
    ///
    /// - Parameter themeState: 主题状态。
    /// - Returns: 主题样式。
    public func themeStyle(forThemeState themeState: Theme.State) -> Theme.Style {
        if let themeStyle = themeStyleIfLoaded(forThemeState: themeState) {
            return themeStyle
        }
        let themeStyle = Theme.Style.init(collection: self.collection, theme: self.theme, state: themeState)
        setThemeStyle(themeStyle, forThemeState: themeState)
        return themeStyle
    }
    
    /// 获取指定状态的主题样式，如果已创建。
    /// - Note: 主题状态 Empty 与 normal 返回当前对象自身。
    /// - Note: 该方法不会返回全局的主题样式集，以避免全局主题样式被意外修改。
    ///
    /// - Parameter themeState: 主题状态。
    /// - Returns: 主题样式。
    public func themeStyleIfLoaded(forThemeState themeState: Theme.State) -> Theme.Style? {
        if themeState == .normal || themeState.isEmpty {
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
    public func setThemeStyle(_ themeStyle: Theme.Style, forThemeState themeState: Theme.State) {
        if themeState == .normal || themeState.isEmpty {
            return
        }
        guard themeStyle.collection === self.collection else {
            return
        }
        statedThemeStyles[themeState] = themeStyle
    }
    
    /// 设置指定主题状态的主题属性值，如果指定状态的主题样式不存在，则自动创建。
    ///
    /// - Parameters:
    ///   - value: 值。
    ///   - themeAttribute: 主题属性。
    ///   - themeState: 主题状态。
    public func setValue(_ value: Any?, forThemeAttribute themeAttribute: Theme.Attribute, forThemeState themeState: Theme.State) {
        self.themeStyle(forThemeState: themeState).setValue(value, forThemeAttribute: themeAttribute)
    }
    
    
    /// 设置指定主题状态的主题属性值，链式函数。
    ///
    /// - Parameters:
    ///   - value: 值。
    ///   - themeAttribute: 主题属性。
    ///   - themeState: 主题状态。
    /// - Returns: 主题样式集对象。
    @discardableResult
    public func setting(_ value: Any?, for themeAttribute: Theme.Attribute, for themeState: Theme.State) -> Theme.Style.Collection {
        self.themeStyle(forThemeState: themeState).setValue(value, forThemeAttribute: themeAttribute)
        return self
    }
    
    /// 更新指定状态样式的链式编程支持。
    ///
    /// - Parameters:
    ///   - themeStyle: 主题样式。
    ///   - themeState: 主题样式状态。
    /// - Returns: 当前主题样式集合对象。
    @discardableResult
    public func settingThemeStyle(_ themeStyle: Theme.Style, forThemeState themeState: Theme.State) -> Theme.Style.Collection {
        setThemeStyle(themeStyle, forThemeState: themeState)
        return self
    }
    
    /// 通过主题样式配置更新主题样式的链式编程支持。
    /// - Note: 如果指定状态的样式不存在，则自动创建。
    ///
    /// - Parameters:
    ///   - configuration: 主题样式配置。
    ///   - themeState: 主题样式状态。
    /// - Returns: 当前主题样式集合对象。
    @discardableResult
    public func updatingThemeStyle(byUsing configuration: [Theme.Attribute: Any?], forThemeState themeState: Theme.State) -> Theme.Style.Collection {
        let themeStyle: Theme.Style = self.themeStyle(forThemeState: themeState)
        for item in configuration {
            themeStyle.updateValue(item.value, forThemeAttribute: item.key)
        }
        return self
    }
    
    /// 通过样式配置字典来更新样式配置。使用指定类型的字典，方便使用预定义的值。
    /// - Note: 得益于 Swift 的字面量构造法，即使指定类型，构造配置字典并不是很繁琐。
    ///
    /// - Parameter configuration: 样式配置字典。
    public func updateThemeStyles(byUsing configuration: [Theme.State: [Theme.Attribute: Any?]]) {
        for item in configuration {
            updatingThemeStyle(byUsing: item.value, forThemeState: item.key)
        }
    }
    
    /// 如果当前主题样式集，没有配置指定状态下的主题样式，那么该方法尝试获取主题集的父集中指定的主题样式。
    ///
    /// - Parameter themeState: 主题状态。
    /// - Returns: 主题样式。
    public func effectiveThemeStyle(forThemeState themeState: Theme.State) -> Theme.Style? {
        if let themeStyle = self.themeStyleIfLoaded(forThemeState: themeState) {
            return themeStyle
        }
        return self.themes.superThemes?.effectiveThemeStyles(forTheme: self.theme)?.effectiveThemeStyle(forThemeState: themeState)
    }
    
    /// 获取当前主题下所有已配置的主题状态（包括全局样式中的以及默认的 `.normal` 状态）。
    public var effectiveThemeStates: Set<Theme.State> {
        if statedThemeStylesIfLoaded == nil {
            return [.normal]
        }
        
        var effectiveThemeStates: Set<Theme.State> = [.normal]
        
        var themes: Theme.Collection? = self.themes
        
        while themes != nil {
            if let statedThemeStyles = themes!.themeStyles(forTheme: self.theme).statedThemeStylesIfLoaded {
                for item in statedThemeStyles {
                    effectiveThemeStates.insert(item.key)
                }
            }
            themes = themes?.superThemes
        }
        
        return effectiveThemeStates
    }
    
    
}



