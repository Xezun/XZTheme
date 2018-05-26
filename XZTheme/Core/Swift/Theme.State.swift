//
//  Theme.State.swift
//  XZKit
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZKit

extension Theme.State: ExpressibleByStringLiteral, Equatable, Hashable {
    
    public typealias StringLiteralType = String
    
    private static let trimmingCharacterSet = CharacterSet.whitespacesAndNewlines.union(CharacterSet.init(charactersIn: ":"))
    
    /// 通过字符串字面量创建主题属性状态。
    /// - Note: 支持的字面量形式如 `":normal"` 或多个组合 `":normal:selected"` 。
    ///
    /// - Parameter value: 字符串字面量
    public init(stringLiteral value: String) {
        var children: Set<Theme.State> = []
        
        // 过滤字符
        for item in value.components(separatedBy: ":") {
            let string = item.trimmingCharacters(in: Theme.State.trimmingCharacterSet)
            guard !string.isEmpty else {
                XZLog("Theme.State: Empty state string in `%@` was ignored.", value)
                continue
            }
            children.insert(Theme.State.init(rawValue: ":" + string))
        }
        
        self.init(children)
    }
    
    public var hashValue: Int {
        return rawValue.hashValue
    }
    
}


extension Theme.State: Sequence, IteratorProtocol {
    
    public mutating func next() -> Theme.State? {
        if self.isEmpty {
            return nil
        }
        if self.children.isEmpty {
            let state = self
            self = .notThemeState
            return state
        } else {
            var children = self.children
            let state = children.removeFirst()
            self = Theme.State.init(children)
            return state
        }
    }
    
}

extension Theme.State {
    
    public init() {
        self = .notThemeState
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
    public init?(_ themeState: Theme.State) {
        if themeState.isEmpty {
            return nil
        }
        if themeState.children.isEmpty {
            switch themeState {
            case .normal:       self = .normal
            case .selected:     self = .selected
            case .highlighted:  self = .highlighted
            case .focused:      if #available(iOS 9.0, *) { self = .focused } else { return nil }
            case .disabled:     self = .disabled
            default:            return nil
            }
            return
        }
        var controlState = UIControlState.init(rawValue: 0)
        for itemState in themeState {
            switch itemState {
            case .normal:       controlState.formUnion(.normal)
            case .selected:     controlState.formUnion(.selected)
            case .highlighted:  controlState.formUnion(.highlighted)
            case .focused:      if #available(iOS 9.0, *) { controlState.formUnion(.focused) }
            case .disabled:     controlState.formUnion(.disabled)
            default:            break
            }
        }
        self = controlState
    }
    
}
