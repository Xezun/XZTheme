//
//  Theme.State.swift
//  Hello
//
//  Created by mlibai on 2018/4/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation


//extension Theme.State {
//    
//    static let normal = Theme.State.init(rawValue: ":normal")
//    
//}
//
//extension Theme.State: ExpressibleByStringLiteral, Equatable, Hashable {
//    
//    public typealias StringLiteralType = String
//    
//    public init(stringLiteral value: String) {
//        self.init(rawValue: value)
//    }
//    
//    public static func == (lhs: Theme.State, rhs: Theme.State) -> Bool {
//        return lhs.rawValue == rhs.rawValue
//    }
//    
//    public var hashValue: Int {
//        return rawValue.hashValue
//    }
//}
//
//
//extension Theme.State: ReferenceConvertible {
//    
//    public var description: String {
//        return rawValue
//    }
//    
//    public var debugDescription: String {
//        return rawValue
//    }
//    
//    public typealias ReferenceType = NSString
//    public typealias _ObjectiveCType = NSString
//    
//    public func _bridgeToObjectiveC() -> NSString {
//        return rawValue as NSString
//    }
//    
//    public static func _forceBridgeFromObjectiveC(_ source: NSString, result: inout Theme.State?) {
//        result = Theme.State.init(rawValue: source as String)
//    }
//    
//    public static func _conditionallyBridgeFromObjectiveC(_ source: NSString, result: inout Theme.State?) -> Bool {
//        _forceBridgeFromObjectiveC(source, result: &result)
//        return true
//    }
//    
//    public static func _unconditionallyBridgeFromObjectiveC(_ source: NSString?) -> Theme.State {
//        if let value = source {
//            return Theme.State.init(rawValue: value as String)
//        }
//        return Theme.State.normal
//    }
//    
//}
