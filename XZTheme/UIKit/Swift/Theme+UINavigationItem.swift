//
//  Theme+UINavigationItem.swift
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZKit

extension Theme.Attribute {
    
    /// UINavigationItem, UISearchBar
    public static let prompt                        = Theme.Attribute.init(rawValue: "prompt")
    /// UINavigationItem.largeTitleDisplayMode
    public static let largeTitleDisplayMode         = Theme.Attribute.init(rawValue: "largeTitleDisplayMode")
    /// UINavigationItem.hidesSearchBarWhenScrolling
    public static let hidesSearchBarWhenScrolling   = Theme.Attribute.init(rawValue: "hidesSearchBarWhenScrolling")
    /// UINavigationItem.leftItemsSupplementBackButton
    public static let leftItemsSupplementBackButton = Theme.Attribute.init(rawValue: "leftItemsSupplementBackButton")
    /// UINavigationItem.hidesBackButton
    public static let hidesBackButton               = Theme.Attribute.init(rawValue: "hidesBackButton")
}

extension Theme.Style {
    
    /// 获取已设置的主题属性值：UIScrollViewIndicatorStyle 。如下值将可以自动转换。
    /// 1. UIScrollViewIndicatorStyle 原始值（Int）。
    /// 2. 字符串 default、black、white 。
    ///
    /// - Parameter themeAttribute: 主题属性。
    /// - Returns: 主题属性值。
    public func navigationItemLargeTitleDisplayMode(forThemeAttribute themeAttribute: Theme.Attribute) -> UINavigationItem.LargeTitleDisplayMode {
        guard let value = value(forThemeAttribute: themeAttribute) else { return .automatic }
        if let navigationItemLargeTitleDisplayMode = value as? UINavigationItem.LargeTitleDisplayMode {
            return navigationItemLargeTitleDisplayMode
        }
        if let number = value as? Int, let navigationItemLargeTitleDisplayMode = UINavigationItem.LargeTitleDisplayMode.init(rawValue: number) {
            return navigationItemLargeTitleDisplayMode
        }
        if let aString = value as? String {
            switch aString {
            case "automatic": return .automatic
            case "always":    return .always
            case "never":     return .never
            default: break
            }
        }
        XZLog("XZTheme: The theme style value (%@) for attribute (%@) is not a UINavigationItem.LargeTitleDisplayMode value, `.automatic` returned.", value, themeAttribute)
        return .automatic
    }
    
    public var prompt: String? {
        get { return stringValue(forThemeAttribute: .prompt) }
        set { setValue(newValue, forThemeAttribute: .prompt) }
    }
    
    public var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode {
        get { return navigationItemLargeTitleDisplayMode(forThemeAttribute: .largeTitleDisplayMode) }
        set { setValue(newValue, forThemeAttribute: .largeTitleDisplayMode) }
    }
    
    public var hidesSearchBarWhenScrolling: Bool {
        get { return boolValue(forThemeAttribute: .hidesSearchBarWhenScrolling)  }
        set { setValue(newValue, forThemeAttribute: .hidesSearchBarWhenScrolling) }
    }
    
    public var leftItemsSupplementBackButton: Bool {
        get { return boolValue(forThemeAttribute: .leftItemsSupplementBackButton)  }
        set { setValue(newValue, forThemeAttribute: .leftItemsSupplementBackButton) }
    }
    
    public var hidesBackButton: Bool {
        get { return boolValue(forThemeAttribute: .hidesBackButton)  }
        set { setValue(newValue, forThemeAttribute: .hidesBackButton) }
    }
    
}

extension UINavigationItem {
    
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.title) {
            self.title = themeStyles.title
        }
        
        if themeStyles.containsThemeAttribute(.hidesBackButton) {
            self.hidesBackButton = themeStyles.hidesBackButton
        }
        
        if themeStyles.containsThemeAttribute(.prompt) {
            self.prompt = themeStyles.prompt
        }
        
        if themeStyles.containsThemeAttribute(.leftItemsSupplementBackButton) {
            self.leftItemsSupplementBackButton = themeStyles.leftItemsSupplementBackButton
        }
        
        if #available(iOS 11.0, *) {
            if themeStyles.containsThemeAttribute(.largeTitleDisplayMode) {
                self.largeTitleDisplayMode = themeStyles.largeTitleDisplayMode
            }
            
            if themeStyles.containsThemeAttribute(.hidesSearchBarWhenScrolling) {
                self.hidesSearchBarWhenScrolling = themeStyles.hidesSearchBarWhenScrolling
            }
        }
    }
    
}
