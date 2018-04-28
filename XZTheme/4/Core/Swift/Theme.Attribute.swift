//
//  Theme.Attribute.swift
//  Hello
//
//  Created by mlibai on 2018/4/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

extension Theme.Attribute {
    
    static let notAnAttribute = Theme.Attribute.init(rawValue: "")
    
    static let backgroundColor = Theme.Attribute.init(rawValue: "backgroundColor")
    
    static let title = Theme.Attribute.init(rawValue: "title")
}

extension Theme.Attribute: ExpressibleByStringLiteral, Equatable, Hashable {
    
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
    
    public static func == (lhs: Theme.Attribute, rhs: Theme.Attribute) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    public var hashValue: Int {
        return rawValue.hashValue
    }
}


extension Theme.Attribute: ReferenceConvertible {
    
    public var description: String {
        return rawValue
    }
    
    public var debugDescription: String {
        return rawValue
    }
    
    public typealias ReferenceType = NSString
    public typealias _ObjectiveCType = NSString
    
    public func _bridgeToObjectiveC() -> NSString {
        return rawValue as NSString
    }
    
    public static func _forceBridgeFromObjectiveC(_ source: NSString, result: inout Theme.Attribute?) {
        result = Theme.Attribute.init(rawValue: source as String)
    }
    
    public static func _conditionallyBridgeFromObjectiveC(_ source: NSString, result: inout Theme.Attribute?) -> Bool {
        _forceBridgeFromObjectiveC(source, result: &result)
        return true
    }
    
    public static func _unconditionallyBridgeFromObjectiveC(_ source: NSString?) -> Theme.Attribute {
        if let value = source {
            return Theme.Attribute.init(rawValue: value as String)
        }
        return Theme.Attribute.notAnAttribute
    }
    
}

