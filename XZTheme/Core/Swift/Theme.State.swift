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

extension Theme.State: OptionSet {
    
    public init() {
        self = .normal
    }
    
    public mutating func formUnion(_ other: Theme.State) {
        if self == other {
            return
        }
        var stateItems = rawValue.components(separatedBy: ":")
        let otherStateItems = other.rawValue.components(separatedBy: ":")
        for otherItem in otherStateItems {
            if !stateItems.contains(otherItem) {
                stateItems.append(otherItem)
            }
        }
        self = Theme.State.init(stateItems.joined(separator: ":"))
    }
    
    public mutating func formIntersection(_ other: Theme.State) {
        if self == other {
            return
        }
        let stateItems = rawValue.components(separatedBy: ":")
        let otherStateItems = other.rawValue.components(separatedBy: ":")
        self = Theme.State.init(stateItems.filter({ (item) -> Bool in
            return otherStateItems.contains(item)
        }).joined(separator: ":"))
    }
    
    public mutating func formSymmetricDifference(_ other: Theme.State) {
        if self == other {
            return
        }
        let stateItems = Set.init(rawValue.components(separatedBy: ":"))
        self = Theme.State.init(stateItems.symmetricDifference(other.rawValue.components(separatedBy: ":")).joined(separator: ":"))
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
    
    /// 表示对象在正常或者默认状态下，一般与 UIControlState.normal 相对应。
    public static let normal       : Theme.State = ":normal"
    /// 表示对象在被选中的状态下，一般与 UIControlState.selected 相对应。
    public static let selected     : Theme.State = ":selected"
    /// 表示对象处高亮状态下，一般与 UIControlState.highlighted 相对应。
    public static let highlighted  : Theme.State = ":highlighted"
    /// 表示对象处于被禁用状态下，一般与 UIControlState.disabled 相对应。
    public static let disabled     : Theme.State = ":disabled"
    /// 表示对象处于焦点状态下，一般与 UIControlState.focused 相对应。
    public static let focused      : Theme.State = ":focused"
}

extension UIControlState {
    
    /// 将主题状态转换为 UIControlState 。
    /// - Note: 默认值 .normal 。
    ///
    /// - Parameter themeState: 主题状态。
    public init(_ themeState: Theme.State) {
        var controlStates = [UIControlState]()
        if themeState.contains(.normal) {
            controlStates.append(.normal)
        }
        if themeState.contains(.selected) {
            controlStates.append(.selected)
        }
        if themeState.contains(.highlighted) {
            controlStates.append(.highlighted)
        }
        if #available(iOS 9.0, *), themeState.contains(.focused) {
            controlStates.append(.focused)
        }
        if themeState.contains(.disabled) {
            controlStates.append(.disabled)
        }
        self.init(controlStates)
    }
    
}
