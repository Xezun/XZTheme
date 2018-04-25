//
//  XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/10/25.
//

import Foundation

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
