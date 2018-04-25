//
//  XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/10/25.
//

import Foundation


extension Theme {
    
    /// 当前已应用的主题。
    /// — Note: 与 Themes.current 属性相同。
    public var current: Theme {
        get { return Themes.current     }
        set { Themes.current = newValue }
    }

}

extension Theme.Style {
    
    @objc(settingValue:forThemeAttribute:) @discardableResult func setting(_ value: Any?, for themeAttribute: Theme.Attribute) -> Theme.Style {
        setValue(value, forThemeAttribute: themeAttribute)
        return self
    }
}

extension Theme.State: ExpressibleByStringLiteral {

    public typealias StringLiteralType = String

    /// 通过字符串字面量创建主题属性状态。
    ///
    /// - Parameter value: 字符串字面量
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}


extension Theme.Attribute: ExpressibleByStringLiteral {
    
    public typealias StringLiteralType = String
    
    /// 通过字符串字面量创建主题属性。
    ///
    /// - Parameter value: 字符串字面量
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
}


extension UIControlState {
    
    public init?(_ themeState: Theme.State) {
        switch themeState {
        case .normal:       self = .normal
        case .selected:     self = .selected
        case .highlighted:  self = .highlighted
        case .focused:      if #available(iOS 9.0, *) { self = .focused } else { return nil }
        case .disabled:     self = .disabled
        default:            return nil
        }
    }
    
}
