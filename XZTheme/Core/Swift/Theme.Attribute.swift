//
//  Theme.Attribute.swift
//  XZKit
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

extension Theme.Attribute {
    
    /// 空字符串不被视为合法的主题属性。
    public static let notAnAttribute: Theme.Attribute = Theme.Attribute.init(rawValue: "")
    
}

extension Theme.Attribute: ExpressibleByStringLiteral, Equatable, Hashable {
    
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

//extension Theme.Attribute: _ObjectiveCBridgeable {
//    
//    public func _bridgeToObjectiveC() -> NSString {
//        return rawValue as NSString
//    }
//    
//    public static func _forceBridgeFromObjectiveC(_ source: NSString, result: inout Theme.Attribute?) {
//        result = Theme.Attribute.init(rawValue: source as String)
//    }
//    
//    public static func _conditionallyBridgeFromObjectiveC(_ source: NSString, result: inout Theme.Attribute?) -> Bool {
//        _forceBridgeFromObjectiveC(source, result: &result)
//        return true
//    }
//    
//    public static func _unconditionallyBridgeFromObjectiveC(_ source: NSString?) -> Theme.Attribute {
//        if let value = source as String? {
//            return Theme.Attribute.init(rawValue: value)
//        }
//        return Theme.Attribute.notAnAttribute;
//    }
//    
//    public typealias _ObjectiveCType = NSString
//    
//}
