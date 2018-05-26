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

extension Theme.State {
    
    public init() {
        self.rawValue = ""
        self.children = []
    }
    
    public var isEmpty: Bool {
        return rawValue.isEmpty
    }
    
    public func contains(_ member: Theme.State) -> Bool {
        if self.rawValue == member.rawValue {
            return true
        }
        if self.children.isEmpty {
            return false
        }
        if member.children.isEmpty {
            return self.children.contains(member)
        }
        return self.children.isSuperset(of: member.children)
    }
    
    public mutating func formUnion(_ other: Theme.State) {
        if self == other {
            return
        }
        self = Theme.State.init(self.children.union(other.children))
    }
    
    public mutating func formIntersection(_ other: Theme.State) {
        if self == other {
            return
        }
        self = Theme.State.init(self.children.intersection(other.children))
    }
    
    public mutating func formSymmetricDifference(_ other: Theme.State) {
        if self == other {
            return
        }
        self = Theme.State.init(self.children.symmetricDifference(other.children))
    }
    
    
}

extension Theme.State: _ObjectiveCBridgeable {
    
    public func _bridgeToObjectiveC() -> NSString {
        return rawValue as NSString
    }
    
    public static func _forceBridgeFromObjectiveC(_ source: NSString, result: inout Theme.State?) {
        result = Theme.State.init(rawValue: source as String)
    }
    
    public static func _conditionallyBridgeFromObjectiveC(_ source: NSString, result: inout Theme.State?) -> Bool {
        _forceBridgeFromObjectiveC(source, result: &result)
        return true
    }
    
    public static func _unconditionallyBridgeFromObjectiveC(_ source: NSString?) -> Theme.State {
        if let value = source as String? {
            return Theme.State.init(rawValue: value as String)
        }
        return Theme.State.normal;
    }
    
    public typealias _ObjectiveCType = NSString
}

extension Theme.State {
    
    /// 表示对象在正常或者默认状态下，一般与 UIControlState.normal 相对应。
    public static let normal       = Theme.State.init(rawValue: ":normal")
    /// 表示对象在被选中的状态下，一般与 UIControlState.selected 相对应。
    public static let selected     = Theme.State.init(rawValue: ":selected")
    /// 表示对象处高亮状态下，一般与 UIControlState.highlighted 相对应。
    public static let highlighted  = Theme.State.init(rawValue: ":highlighted")
    /// 表示对象处于被禁用状态下，一般与 UIControlState.disabled 相对应。
    public static let disabled     = Theme.State.init(rawValue: ":disabled")
    /// 表示对象处于焦点状态下，一般与 UIControlState.focused 相对应。
    public static let focused      = Theme.State.init(rawValue: ":focused")
}

extension UIControlState {
    
    /// 将主题状态转换为 UIControlState 。
    /// - Note: 默认值 .normal 。
    ///
    /// - Parameter themeState: 主题状态。
    public init(_ themeState: Theme.State) {
        if themeState.children.isEmpty {
            switch themeState {
            case .normal:       self = .normal
            case .selected:     self = .selected
            case .highlighted:  self = .highlighted
            case .focused:      if #available(iOS 9.0, *) { self = .focused } else { self = .normal }
            case .disabled:     self = .disabled
            default:            self = .normal
            }
            return;
        }
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
