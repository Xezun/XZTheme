//
//  Theme.Collection.swift
//  XZTheme
//
//  Created by mlibai on 2018/8/3.
//

import Foundation

extension Theme.Collection {
    
    /// 计算样式。
    @objc(themeStylesForObject:)
    public func themeStyles(for object: NSObject) -> Theme.Style.Collection? {
        // 1. 读取对象的计算样式，如果有，直接使用。
        // 2. 读取类对象的计算样式、对象的私有样式，并合并成计算样式。
        // 3. 保存计算样式。
        
        
        // TODO: - 计算样式的合成规则
        return object.themeStylesIfLoaded
    }
    
}

extension Theme.Collection {
    
    /// 是否包含指定主题下的主题样式。
    ///
    /// - Parameter theme: 主题。
    /// - Returns: 是否存在主题样式。
    @objc public func containsThemeStyles(for themeIdentifier: Theme.Identifier) -> Bool {
        return identifiedThemeStylesIfLoaded?.keys.contains(themeIdentifier) == true
    }
    
    /// 获取已设置的主题样式（如果有）。
    ///
    /// - Parameter theme: 主题。
    /// - Returns: 主题样式集合。
    @objc(themeStylesIfLoadedForThemeIdentifier:)
    public func themeStylesIfLoaded(for themeIdentifier: Theme.Identifier) -> Theme.Style.Collection? {
        return identifiedThemeStylesIfLoaded?[themeIdentifier]
    }
    
    /// 获取已设置的主题样式，如果主题对应的样式不存在，则会自动创建。
    ///
    /// - Parameter theme: 主题。
    /// - Returns: 主题样式。
    @objc(themeStylesForThemeIdentifier:)
    public func themeStyles(for themeIdentifier: Theme.Identifier) -> Theme.Style.Collection {
        if let themeStyles = identifiedThemeStylesIfLoaded?[themeIdentifier] {
            return themeStyles
        }
        let themeStyles = Theme.Style.Collection.init(for: self)
        set(themeStyles, for: themeIdentifier)
        return themeStyles
    }
    
}
