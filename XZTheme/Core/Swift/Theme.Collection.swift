//
//  Theme.Collection.swift
//  XZKit
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

extension Theme.Collection {
    
    /// 获取默认主题的样式的快捷方法。
    /// - Note: 该方法等同于调用 themeStyle(forTheme:) 方法。
    /// - Note: 建议给自定义主题添加类似的访问方法。
    /// ```
    /// let view = UIView()
    /// // 设置 default 主题的样式。
    /// view.themes.default.backgroundColor = .white
    /// ```
    /// ```
    /// // 自定义主题
    /// extension Theme {
    ///     /// 夜间主题
    ///     static let night = Theme.init(name: "night")
    /// }
    /// // 便利访问方式
    /// extension Theme.Colletion {
    ///     var day: Theme.Style.Collection {
    ///         return themeStyles(forTheme: .night)
    ///     }
    /// }
    /// ```
    public var `default`: Theme.Style.Collection {
        return themeStyles(forTheme: .default)
    }
    
}

extension Theme.Collection {
    
    /// 获取已设置的主题样式（如果有）。
    ///
    /// - Parameter theme: 主题。
    /// - Returns: 主题样式集合。
    @objc public func themeStylesIfLoaded(forTheme theme: Theme) -> Theme.Style.Collection? {
        return themeStyleCollectionIfLoaded?[theme]
    }
    
    /// 获取已设置的主题样式，如果主题对应的样式不存在，则会自动创建。
    ///
    /// - Parameter theme: 主题。
    /// - Returns: 主题样式。
    @objc public func themeStyles(forTheme theme: Theme) -> Theme.Style.Collection {
        if let themeStyles = themeStyleCollectionIfLoaded?[theme] {
            return themeStyles
        }
        let themeStyles = Theme.Style.Collection.init(themeCollection: self, theme: theme)
        setThemeStyles(themeStyles, forTheme: theme)
        return themeStyles
    }
    
    /// 设置主题样式。
    ///
    /// - Parameter themeStyles: 主题样式。
    /// - Parameter theme: 主题。
    @objc public func setThemeStyles(_ themeStyles: Theme.Style.Collection, forTheme theme: Theme) {
        themeStyleCollection[theme] = themeStyles
    }
    
    /// 当前生效的主题样式集。如果所有者没有配置主题样式集，则返回全局主题样式集（如果有）。
    ///
    /// - Parameter theme: 主题。
    /// - Returns: 主题样式集。
    @objc public func effectiveThemeStyles(forTheme theme: Theme) -> Theme.Style.Collection? {
        if let themeStyles = themeStylesIfLoaded(forTheme: theme) {
            return themeStyles
        }
        var superThemes: Theme.Collection! = self.superThemes
        
        while superThemes != nil {
            if let themeStyles = superThemes.themeStylesIfLoaded(forTheme: theme) {
                return themeStyles
            }
            superThemes = superThemes.superThemes
        }
        
        return nil
    }
    
}
