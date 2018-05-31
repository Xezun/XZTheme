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
    
    /// 过滤主题状态字符串中多余的空白字符。
    private static let trimmingCharacterSet = CharacterSet.whitespacesAndNewlines.union(CharacterSet.init(charactersIn: ":"))
    
    /// 通过字符串字面量创建主题属性状态。
    /// - Note: 支持的字面量形式如 `":normal"` 或多个组合 `":normal:selected"` 。
    /// - Note: 会自动忽略一些空白字符。
    ///
    /// - Parameter value: 字符串字面量
    public init(stringLiteral value: String) {
        var children: [Theme.State] = []
        
        // 过滤字符
        for item in value.components(separatedBy: ":") {
            let string = item.trimmingCharacters(in: Theme.State.trimmingCharacterSet)
            guard !string.isEmpty else {
                XZLog("Theme.State: Empty state string in `%@` was ignored.", value)
                continue
            }
            children.append(Theme.State.init(rawValue: ":" + string))
        }
        
        self.init(children)
    }
    
    public var hashValue: Int {
        return rawValue.hashValue
    }
    
}


extension Theme.State: Sequence, IteratorProtocol {
    
    /// 遍历主题状态中的所有基本元素，遍历顺序为正序。
    ///
    /// - Returns: 剩余未遍历的主题状态。
    public mutating func next() -> Theme.State? {
        if self.isEmpty {
            return nil
        }
        if self.isPrimary {
            let state = self
            self = .Empty
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
    
    /// 判断主题状态是否包含另一状态，或者某一主题状态是否为当前主题状态的。
    ///
    /// - Parameter member: <#member description#>
    /// - Returns: <#return value description#>
    public func contains(_ member: Theme.State) -> Bool {
        if self.rawValue == member.rawValue {
            return true
        }
        if self.isPrimary {
            return false
        }
        if member.isPrimary {
            return self.children.contains(member)
        }
        for m in 0 ..< self.children.count {
            // 找到第一个相等的子元素。
            guard self.children[m] == member.children[0] else { continue }
            for n in 1 ..< member.children.count {
                /// 遍历 member ，从第一个匹配位置开始，后续所有子元素都相等，否则返回 false 。
                guard m + n < self.children.count, self.children[m + n] == member.children[n] else { return false }
            }
            // member 遍历完成，说明完全相同。
            break
        }
        return true
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
    /// - Note: 对于设置带触控状态的属性，仅支持基本状态。
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
        if themeState.isPrimary {
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
