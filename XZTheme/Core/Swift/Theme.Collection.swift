//
//  Theme.Collection.swift
//  XZTheme
//
//  Created by mlibai on 2018/8/3.
//

import Foundation

extension Theme.Collection {
    
    /// 计算样式。
    
    /// 获取对象的计算样式。
    ///
    /// - Parameter object: 指定的对象。
    /// - Returns: 主题样式集。
    public func themeStyles(for object: NSObject) -> Theme.Style.Collection? {
        // 1. 读取对象的计算样式，如果有，直接使用。
        if let computedThemeStyles = objc_getAssociatedObject(self, &AssociationKey.computedThemeStyles) {
            return computedThemeStyles as? Theme.Style.Collection
        }
        // 2. 从样式表中匹配对象的样式
        let themeStyles = self.theme.themes(for: object).theme//self.fetchThemeStyleSheet(for: object)
        
        // 3. 合并成计算样式，并保存。
        let computedThemeStyles = Theme.Style.Collection.init(for: nil, union: themeStyles, object.themeStylesIfLoaded)
        objc_setAssociatedObject(object, &AssociationKey.computedThemeStyles, computedThemeStyles ?? NSNull(), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    
        return computedThemeStyles
    }
    
    /// 从样式表中匹配对象的样式，并合并成计算样式。
    private func fetchThemeStyleSheet(for object: NSObject) -> Theme.Style.Collection? {
        // TODO: - 从样式表中匹配指定标识符对应的样式。
        // 目前仅根据标识符匹配。
        guard let themeIdentifier = object.themeIdentifier else { return nil }
        return self.themeStylesIfLoaded(for: themeIdentifier)
    }
    
}

extension Theme.Collection {
    
    /// 是否包含指定主题下的主题样式。
    ///
    /// - Parameter theme: 主题。
    /// - Returns: 是否存在主题样式。
    public func containsThemeStyles(for themeIdentifier: Theme.Identifier) -> Bool {
        return identifiedThemeStylesIfLoaded?.keys.contains(themeIdentifier) == true
    }
    
    /// 获取已设置的主题样式（如果有）。
    ///
    /// - Parameter theme: 主题。
    /// - Returns: 主题样式集合。
    public func themeStylesIfLoaded(for themeIdentifier: Theme.Identifier) -> Theme.Style.Collection? {
        return identifiedThemeStylesIfLoaded?[themeIdentifier]
    }
    
    /// 获取已设置的主题样式，如果主题对应的样式不存在，则会自动创建。
    ///
    /// - Parameter theme: 主题。
    /// - Returns: 主题样式。
    public func themeStyles(for themeIdentifier: Theme.Identifier) -> Theme.Style.Collection {
        if let themeStyles = identifiedThemeStylesIfLoaded?[themeIdentifier] {
            return themeStyles
        }
        let themeStyles = Theme.Style.Collection.init(for: self)
        set(themeStyles, for: themeIdentifier)
        return themeStyles
    }
    
}



private struct AssociationKey {
    static var computedThemeStyles:         Int = 1
}

