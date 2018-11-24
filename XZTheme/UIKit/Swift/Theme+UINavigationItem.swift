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
    public func navigationItemLargeTitleDisplayMode(for themeAttribute: Theme.Attribute) -> UINavigationItem.LargeTitleDisplayMode {
        guard let value = self.value(for: themeAttribute) else { return .automatic }
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
        get { return stringValue(for: .prompt) }
        set { setValue(newValue, for: .prompt) }
    }
    
    public var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode {
        get { return navigationItemLargeTitleDisplayMode(for: .largeTitleDisplayMode) }
        set { setValue(newValue, for: .largeTitleDisplayMode) }
    }
    
    public var hidesSearchBarWhenScrolling: Bool {
        get { return boolValue(for: .hidesSearchBarWhenScrolling)  }
        set { setValue(newValue, for: .hidesSearchBarWhenScrolling) }
    }
    
    public var leftItemsSupplementBackButton: Bool {
        get { return boolValue(for: .leftItemsSupplementBackButton)  }
        set { setValue(newValue, for: .leftItemsSupplementBackButton) }
    }
    
    public var hidesBackButton: Bool {
        get { return boolValue(for: .hidesBackButton)  }
        set { setValue(newValue, for: .hidesBackButton) }
    }
    
}

extension UINavigationItem {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.contains(.title) {
            self.title = themeStyles.title
        }
        
        if themeStyles.contains(.hidesBackButton) {
            self.hidesBackButton = themeStyles.hidesBackButton
        }
        
        if themeStyles.contains(.prompt) {
            self.prompt = themeStyles.prompt
        }
        
        if themeStyles.contains(.leftItemsSupplementBackButton) {
            self.leftItemsSupplementBackButton = themeStyles.leftItemsSupplementBackButton
        }
        
        if #available(iOS 11.0, *) {
            if themeStyles.contains(.largeTitleDisplayMode) {
                self.largeTitleDisplayMode = themeStyles.largeTitleDisplayMode
            }
            
            if themeStyles.contains(.hidesSearchBarWhenScrolling) {
                self.hidesSearchBarWhenScrolling = themeStyles.hidesSearchBarWhenScrolling
            }
        }
    }
    
}
