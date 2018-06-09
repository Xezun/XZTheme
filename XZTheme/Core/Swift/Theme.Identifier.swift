//
//  Theme.Identifier.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/11.
//

import Foundation


extension Theme.Identifier {
    
    /// 空字符串不被视为合法的主题标识符。
    public static let notAnIdentifier: Theme.Identifier = Theme.Identifier.init("")
    
}

extension Theme.Identifier: ExpressibleByStringLiteral, Equatable, Hashable {
    
    public typealias StringLiteralType = String
    
    /// 通过字符串字面量创建主题属性。
    ///
    /// - Parameter value: 字符串字面量
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
    
    public var hashValue: Int {
        return rawValue.hashValue
    }
    
}

extension Theme.Identifier: ReferenceConvertible {
    
    public typealias ReferenceType = NSString
    
    public var description: String {
        return rawValue.description
    }
    
    public var debugDescription: String {
        return rawValue.debugDescription
    }
    
    
    public func _bridgeToObjectiveC() -> NSString {
        return rawValue as NSString
    }
    
    public static func _forceBridgeFromObjectiveC(_ source: NSString, result: inout Theme.Identifier?) {
        result = Theme.Identifier.init(source as String)
    }
    
    public static func _conditionallyBridgeFromObjectiveC(_ source: NSString, result: inout Theme.Identifier?) -> Bool {
        _forceBridgeFromObjectiveC(source, result: &result)
        return true
    }
    
    public static func _unconditionallyBridgeFromObjectiveC(_ source: NSString?) -> Theme.Identifier {
        if let value = source as String? {
            return Theme.Identifier.init(value)
        }
        return Theme.Identifier.notAnIdentifier;
    }
    
    public typealias _ObjectiveCType = NSString
    
}
