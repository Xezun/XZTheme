//
//  XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/10/25.
//

import Foundation

extension Theme.Style {

    /// 配置主题样式的链式编程方式支持。
    ///
    /// - Parameters:
    ///   - value: 主题属性值。
    ///   - themeAttribute: 主题属性。
    /// - Returns: 当前主题样式对象。
    @discardableResult
    open func setting(_ value: Any?, for themeAttribute: Theme.Attribute) -> Theme.Style {
        setValue(value, forThemeAttribute: themeAttribute)
        return self
    }
    
}

extension Theme.StyleSet {
    
    /// 更新指定状态样式的链式编程支持。
    ///
    /// - Parameters:
    ///   - themeStyle: 主题样式。
    ///   - themeState: 主题样式状态。
    /// - Returns: 当前主题样式集合对象。
    @discardableResult open func setting(_ themeStyle: Theme.Style?, for themeState: Theme.State) -> Theme.StyleSet {
        setThemeStyle(themeStyle, forThemeState: themeState)
        return self
    }
    
    /// 通过主题样式配置更新主题样式的链式编程支持。
    /// - Note: 属性值将以 NSNull 存储。
    ///
    /// - Parameters:
    ///   - configuration: 主题样式配置。
    ///   - themeState: 主题样式状态。
    /// - Returns: 当前主题样式集合对象。
    @discardableResult open func setting(_ configuration: [Theme.Attribute: Any?], for themeState: Theme.State) -> Theme.StyleSet {
        let themeStyle: Theme.Style = themeStyleLazyLoad(forThemeState: themeState)
        for item in configuration {
            if let themeValue = item.value {
                themeStyle.setValue(themeValue, forThemeAttribute: item.key)
            } else {
                themeStyle.setValue(NSNull(), forThemeAttribute: item.key)
            }
        }
        return self
    }
    
    /// 通过样式配置字典来配置样式。使用指定类型的字典，方便使用预定义的值。
    /// - Note: 得益于 Swift 的字面量构造法，即使指定类型，构造配置字典并不是很繁琐。
    /// - Note: 灵活的配置字典可能会方便构造，但是对性能来说不一定值得。
    /// - Parameter configuration: 样式配置字典。
    open func setThemeStyles(byUsing configuration: [Theme.State: [Theme.Attribute: Any?]]) {
        for item in configuration {
            setting(item.value, for: item.key)
        }
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



//struct Theme: RawRepresentable {
//
//    typealias RawValue = String
//
//    let rawValue: String
//
//    init(rawValue: String) {
//        self.rawValue = rawValue
//    }
//
//
//}
//
//extension Theme: ReferenceConvertible, Equatable {
//
//    typealias ReferenceType = XZTheme
//    typealias _ObjectiveCType = XZTheme
//
//    func _bridgeToObjectiveC() -> XZTheme {
//        return XZTheme.init(name: rawValue)
//    }
//
//    static func _forceBridgeFromObjectiveC(_ source: XZTheme, result: inout Theme?) {
//        result = Theme.init(rawValue: source.name)
//    }
//
//    static func _conditionallyBridgeFromObjectiveC(_ source: XZTheme, result: inout Theme?) -> Bool {
//        _forceBridgeFromObjectiveC(source, result: &result)
//        return true
//    }
//
//    static func _unconditionallyBridgeFromObjectiveC(_ source: XZTheme?) -> Theme {
//        if let theme = source {
//            return Theme.init(rawValue: theme.name)
//        }
//        return Theme.init(rawValue: "default")
//    }
//
//    var hashValue: Int {
//        return rawValue.hashValue
//    }
//
//    var description: String {
//        return rawValue
//    }
//
//    var debugDescription: String {
//        return rawValue
//    }
//
//}
