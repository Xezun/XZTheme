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
    public var `default`: Theme.Style.Collection {
        return themeStyles(forTheme: .default)
    }
    
}

extension Theme.Collection {
    
    /// 获取已设置的主题样式（如果有）。
    ///
    /// - Parameter theme: 主题。
    /// - Returns: 主题样式集合。
    public func themeStylesIfLoaded(forTheme theme: Theme) -> Theme.Style.Collection? {
        return themedStyles[theme]
    }
    
    /// 获取已设置的主题样式，如果主题对应的样式不存在，则会自动创建。
    ///
    /// - Parameter theme: 主题。
    /// - Returns: 主题样式。
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
    /// - Parameter themeStyles: 主题样式。
    /// - Parameter theme: 主题。
    public func setThemeStyles(_ themeStyles: Theme.Style.Collection, forTheme theme: Theme) {
        themedStyles[theme] = themeStyles
        object.setNeedsThemeAppearanceUpdate()
    }
}


extension Array where Element == Theme {
    
    /// 将 Theme.Collection 对象转换为 Theme 数组。
    ///
    /// - Parameter themeCollection: Theme.Collection 对象。
    public init(_ themeCollection: Theme.Collection) {
        self.init(themeCollection.themedStyles.keys)
    }
}
