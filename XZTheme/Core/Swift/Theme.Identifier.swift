//
//  Theme.Identifier.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/11.
//

import Foundation


extension Theme.Identifier {
    
    /// 空字符串不被视为合法的主题标识符。
    public static let notAnIdentifier: Theme.Identifier = Theme.Identifier.init(rawValue: "")
    
}

extension Theme.Identifier: ExpressibleByStringLiteral, Equatable, Hashable {
    
    public typealias StringLiteralType = String
    
    /// 通过字符串字面量创建主题属性。
    ///
    /// - Parameter value: 字符串字面量
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
    
    /// Returns rawValue's hashValue.
    public var hashValue: Int {
        return rawValue.hashValue
    }
    
}

extension Theme.Identifier: ExpressibleByArrayLiteral {
    
    public typealias ArrayLiteralElement = Theme.Identifier
    
    /// 主题标识符的数组字面量表示法。数组 [.id1, .id2] 字面量为 .id1.id2 标识符。
    ///
    /// - Parameter elements: 主题标识符数组字面量。
    public init(arrayLiteral elements: Theme.Identifier...) {
        var rawValue = String.init()
        for element in elements {
            rawValue.append(element.rawValue)
        }
        self.init(rawValue: rawValue)
    }
    
    /// 标识符是否包含另一个标识符。
    public func contains(_ other: Theme.Identifier) -> Bool {
        if let range = rawValue.range(of: other.rawValue) {
            if range.upperBound == rawValue.endIndex {
                return true
            } else if rawValue[rawValue.index(after: range.upperBound)] == "." {
                return true
            }
        }
        return false
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
        result = Theme.Identifier.init(rawValue: source as String)
    }
    
    public static func _conditionallyBridgeFromObjectiveC(_ source: NSString, result: inout Theme.Identifier?) -> Bool {
        _forceBridgeFromObjectiveC(source, result: &result)
        return true
    }
    
    public static func _unconditionallyBridgeFromObjectiveC(_ source: NSString?) -> Theme.Identifier {
        if let value = source as String? {
            return Theme.Identifier.init(rawValue: value)
        }
        return Theme.Identifier.notAnIdentifier;
    }
    
    public typealias _ObjectiveCType = NSString
    
}
