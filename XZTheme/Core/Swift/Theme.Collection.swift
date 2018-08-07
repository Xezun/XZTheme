//
//  Theme.Collection.swift
//  XZTheme
//
//  Created by mlibai on 2018/8/3.
//

import Foundation

private struct AssociationKey {
    static var computedThemeStyles:         Int = 1
}

extension NSObject {
    /// 计算样式，最终应用到对象上的样式。
    /// - Note: 计算样式由内部维护，外部修改不同步到当前状态中。
    @objc(xz_computedThemeStyles)
    open var computedThemeStyles: Theme.Style.Collection? {
        get { return objc_getAssociatedObject(self, &AssociationKey.computedThemeStyles) as? Theme.Style.Collection }
        set { objc_setAssociatedObject(self, &AssociationKey.computedThemeStyles, themeStyles, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
}

extension Theme.Collection {
    
    /// 计算样式。
    public func themeStyles(forObject object: NSObject) -> Theme.Style.Collection? {
        // 1. 读取对象的计算样式，如果有，直接使用。
        if let computedThemeStyles = objc_getAssociatedObject(self, &AssociationKey.computedThemeStyles) {
            return computedThemeStyles as? Theme.Style.Collection
        }
        // 2. 从样式表中匹配对象的样式
        let themeStyles = self.themeStylesFromXZSS(for: object)
        
        // 3. 合并成计算样式，并保存。
        let computedThemeStyles = Theme.Style.Collection.init(for: nil, union: themeStyles, object.themeStylesIfLoaded)
        objc_setAssociatedObject(object, &AssociationKey.computedThemeStyles, computedThemeStyles ?? NSNull(), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    
        return computedThemeStyles
    }
    
    /// 从样式表中匹配对象的样式，并合并成计算样式。
    private func themeStylesFromXZSS(for object: NSObject) -> Theme.Style.Collection? {
        // TODO: - 从样式表中匹配指定标识符对应的样式。
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
