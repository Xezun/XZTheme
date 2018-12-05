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
    
    /// 将另一个主题样式集并入到当前样式集中。
    /// - Note: 当前样式集中已存在的样式会被覆盖。
    ///
    /// - Parameter themeStyles: 待并入的样式集。
    public func union(_ themeStyles: Theme.Style.Collection?) {
        guard let themeStyles = themeStyles else { return }
        guard let statedThemeStyles = themeStyles.statedThemeStylesIfLoaded else { return }
        for statedThemeStyle in statedThemeStyles {
            for attributedValue in statedThemeStyle.value.attributedValues {
                /// 样式在合并的过程中为复制，即样式在合并过程中的私有性可能会发生改变。
                updateValue(attributedValue.value, for: attributedValue.key, for: statedThemeStyle.key)
            }
        }
    }
    
    /// 将多个样式合并成一个样式。
    ///
    /// - Parameters:
    ///   - object: 样式集的所有者。
    ///   - themeStyles: 待合并的样式集。
    public convenience init?(for object: NSObject?, union themeStyles: Theme.Style.Collection?...) {
        guard themeStyles.contains(where: {$0 != nil}) else {
            return nil
        }
        self.init(for: object)
        for itemStyles in themeStyles {
            self.union(itemStyles)
        }
    }
    
}

extension Theme.Style.Collection {
    
    /// 默认状态样式，Theme.State.normal 状态下的主题样式，当前集合自身。
    public var normal: Theme.Style {
        return self
    }
    
    /// Theme.State.highlighted 状态下的主题样式，懒加载。
    public var highlighted: Theme.Style {
        return themeStyle(for: .highlighted)
    }
    
    /// Theme.State.selected 状态下的主题样式，懒加载。
    public var selected: Theme.Style {
        return themeStyle(for: .selected)
    }
    
    /// Theme.State.disabled 状态下的主题样式，懒加载。
    public var disabled: Theme.Style {
        return themeStyle(for: .disabled)
    }
    
    /// Theme.State.highlighted 状态下的主题样式，非懒加载。
    public var highlightedIfLoaded: Theme.Style? {
        return themeStyleIfLoaded(for: .highlighted)
    }
    
    /// Theme.State.selected 状态下的主题样式，非懒加载。
    public var selectedIfLoaded: Theme.Style? {
        return themeStyleIfLoaded(for: .selected)
    }
    
    /// Theme.State.disabled 状态下的主题样式，非懒加载。
    public var disabledIfLoaded: Theme.Style? {
        return themeStyleIfLoaded(for: .disabled)
    }
    
}

extension Theme.Style.Collection {
    
    /// 获取指定状态的主题样式，如果主题样式不存在，将自动创建。
    ///
    /// - Parameter themeState: 主题状态。
    /// - Returns: 主题样式。
    public func themeStyle(for themeState: Theme.State) -> Theme.Style {
        if let themeStyle = themeStyleIfLoaded(for: themeState) {
            return themeStyle
        }
        let themeStyle = Theme.Style.init(for: object)
        set(themeStyle, for: themeState)
        return themeStyle
    }
    
    /// 设置指定主题状态的主题属性值，如果指定状态的主题样式不存在，则自动创建。
    ///
    /// - Parameters:
    ///   - value: 值。
    ///   - themeAttribute: 主题属性。
    ///   - themeState: 主题状态。
    public func setValue(_ value: Any?, for themeAttribute: Theme.Attribute, for themeState: Theme.State) {
        self.themeStyle(for: themeState).setValue(value, for: themeAttribute)
    }
    
    
    public func updateValue(_ value: Any?, for themeAttribute: Theme.Attribute, for themeState: Theme.State) {
        self.themeStyle(for: themeState).updateValue(value, for: themeAttribute)
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
        self.themeStyle(for: themeState).setValue(value, for: themeAttribute)
        return self
    }
    
    /// 更新指定状态样式的链式编程支持。
    ///
    /// - Parameters:
    ///   - themeStyle: 主题样式。
    ///   - themeState: 主题样式状态。
    /// - Returns: 当前主题样式集合对象。
    @discardableResult
    public func setting(_ themeStyle: Theme.Style, for themeState: Theme.State) -> Theme.Style.Collection {
        set(themeStyle, for: themeState)
        return self
    }
    
//    /// 通过主题样式配置更新主题样式的链式编程支持。
//    /// - Note: 如果指定状态的样式不存在，则自动创建。
//    ///
//    /// - Parameters:
//    ///   - configuration: 主题样式配置。
//    ///   - themeState: 主题样式状态。
//    /// - Returns: 当前主题样式集合对象。
//    @discardableResult
//    public func updating(byUsing configuration: [Theme.Attribute: Any?], for themeState: Theme.State) -> Theme.Style.Collection {
//        let themeStyle: Theme.Style = self.themeStyle(for: themeState)
//        for item in configuration {
//            themeStyle.updateValue(item.value, forThemeAttribute: item.key)
//        }
//        return self
//    }
    
//    /// 通过样式配置字典来更新样式配置。使用指定类型的字典，方便使用预定义的值。
//    /// - Note: 得益于 Swift 的字面量构造法，即使指定类型，构造配置字典并不是很繁琐。
//    ///
//    /// - Parameter configuration: 样式配置字典。
//    public func updateThemeStyles(byUsing configuration: [Theme.State: [Theme.Attribute: Any?]]) {
//        for item in configuration {
//            updatingThemeStyle(byUsing: item.value, for: item.key)
//        }
//    }
}





