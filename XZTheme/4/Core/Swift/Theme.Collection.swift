//
//  ThemeSet.swift
//  Hello
//
//  Created by mlibai on 2018/4/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation


extension Theme.Collection {
    
    /// 获取默认主题的样式的快捷方法。
    /// - Note: 该方法等同于调用 styles(for:) 方法。
    /// - Note: 可以参照此方法来为自定义主题添加便捷访问方式。
    /// ```
    /// // 比如自定义 night 主题的便捷访问方式。
    /// extension Theme {
    ///     static let night: Theme = "night"
    /// }
    /// extension Theme.Collection {
    ///     public var night: Theme.Style.Collection<T> {
    ///         return styles(for: .night)
    ///     }
    /// }
    /// ```
    public var `default`: Theme.Style.Collection<T> {
        return styles(for: .default)
    }
    
    /// 获取已设置的主题样式。
    /// - Note: 懒加载，如果主题对应的样式不存在，则会自动创建一个空的主题样式对象。
    ///
    /// - Parameter theme: 主题。
    /// - Returns: 主题样式。
    public func styles(for theme: Theme) -> Theme.Style.Collection<T> {
        if let style = themedStyles[theme] {
            return style
        }
        let style = Theme.Style.Collection.init(object)
        themedStyles[theme] = style
        return style
    }
    
    /// 设置主题样式。
    ///
    /// - Parameters:
    ///   - styles: 主题样式。
    ///   - theme: 主题。
    public func set(_ styles: Theme.Style.Collection<T>, for theme: Theme) {
        self.themedStyles[theme] = styles
    }
    
    /// 获取已设置的主题样式（如果有）。
    ///
    /// - Parameter theme: 主题。
    /// - Returns: 主题样式。
    public func stylesIfLoaded(for theme: Theme) -> Theme.StyleCollection<T>? {
        return self.themedStyles[theme]
    }
    
}


