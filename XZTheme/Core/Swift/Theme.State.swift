//
//  Theme.State.swift
//  XZKit
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

extension Theme.State: ExpressibleByStringLiteral, Equatable, Hashable {
    
    public typealias StringLiteralType = String
    
    /// 通过字符串字面量创建主题属性状态。
    ///
    /// - Parameter value: 字符串字面量
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
    
    public var hashValue: Int {
        return rawValue.hashValue
    }
    
}

extension Theme.State: _ObjectiveCBridgeable {
    
    public func _bridgeToObjectiveC() -> NSString {
        return rawValue as NSString
    }
    
    public static func _forceBridgeFromObjectiveC(_ source: NSString, result: inout Theme.State?) {
        result = Theme.State.init(source as String)
    }
    
    public static func _conditionallyBridgeFromObjectiveC(_ source: NSString, result: inout Theme.State?) -> Bool {
        _forceBridgeFromObjectiveC(source, result: &result)
        return true
    }
    
    public static func _unconditionallyBridgeFromObjectiveC(_ source: NSString?) -> Theme.State {
        if let value = source as String? {
            return Theme.State.init(value)
        }
        return Theme.State.normal;
    }
    
    public typealias _ObjectiveCType = NSString
}

extension Theme.State {
    public static let normal:       Theme.State = ":normal"
    public static let selected:     Theme.State = ":selected"
    public static let highlighted:  Theme.State = ":highlighted"
    public static let disabled:     Theme.State = ":disabled"
    public static let focused:      Theme.State = ":focused"
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
