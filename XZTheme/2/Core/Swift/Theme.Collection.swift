//
//  Theme.Collection.swift
//  Example
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

extension Theme.Collection {
    
    /// 获取默认主题的样式的快捷方法。
    /// - Note: 该方法等同于调用 -themeStyleForTheme: 方法。
    public var `default`: Theme.Style.Collection {
        return themeStyles(forTheme: .default)
    }
    
    /// 获取已设置的主题样式（如果有）。
    ///
    /// @param theme 主题。
    /// @return 主题样式。
    public func themeStylesIfLoaded(forTheme theme: Theme) -> Theme.Style.Collection? {
        return themedStyles[theme]
    }
    
    /// 获取已设置的主题样式。
    /// - Note: 懒加载，如果主题对应的样式不存在，则会自动创建一个空的主题样式对象。
    ///
    /// @param theme 主题。
    /// @return 主题样式。
    public func themeStyles(forTheme theme: Theme) -> Theme.Style.Collection {
        if let themeStyles = themedStyles[theme] {
            return themeStyles
        }
        let themeStyles = Theme.Style.Collection.init(self.object)
        setThemeStyles(themeStyles, forTheme: theme)
        return themeStyles
    }
    
    /// 设置主题样式。
    ///
    /// @param themeStyles 主题样式。
    /// @param theme 主题。
    public func setThemeStyles(_ themeStyles: Theme.Style.Collection, forTheme theme: Theme) {
        themedStyles[theme] = themeStyles
        object.setNeedsThemeAppearanceUpdate()
    }
}


extension Array where Element == Theme {
    
    /// 将 Theme.Collection 对象转换为 Theme 数组。
    ///
    /// - Parameter themeCollection: Theme.Collection 对象。
    public init<T: Theme.Collection>(_ themeCollection: T) {
        self.init(themeCollection.themedStyles.keys)
    }
}
