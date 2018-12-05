//
//  Theme.Collection.swift
//  XZTheme
//
//  Created by mlibai on 2018/8/3.
//

import Foundation

extension NSObject {
    

    
}

extension Theme.Collection {
    
    /// 获取样式表中某对象的样式。
    ///
    /// - Parameter object: 指定的对象。
    /// - Returns: 主题样式集。
    public func themeStylesIfLoaded(for object: NSObject) -> Theme.Style.Collection? {
        // 1. 读取对象的计算样式，如果有，直接使用。
        if let computedThemeStyles = objc_getAssociatedObject(self, &AssociationKey.computedThemeStyles) {
            return computedThemeStyles as? Theme.Style.Collection
        }
        // 2. 从样式表中匹配对象的样式
        guard let identifiedThemeStyles = self.identifiedThemeStylesIfLoaded else { return nil }
        
        let identifier = { (_ object: NSObject) -> Theme.Identifier in
            let classIdentifier = Theme.Identifier.init(rawValue: String.init(describing: type(of: object)))
            if let id1 = object.themeIdentifier {
                return [classIdentifier, id1]
            }
            return classIdentifier
        }(object)
        
        var themeStyles: Theme.Style.Collection? = nil
        for item in identifiedThemeStyles {
            guard item.key.contains(identifier) else { continue }
            if themeStyles != nil {
                themeStyles!.union(item.value)
            } else {
                themeStyles = Theme.Style.Collection.init(for: object, union: item.value)
            }
        }
        
        return themeStyles
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

