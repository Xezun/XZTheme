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
    
    /// 主题状态的 hashValue 为其原始值的 hashValue 。
    public var hashValue: Int {
        return rawValue.hashValue
    }
    
}


extension Theme.State {
    
    /// 遍历主题状态中的所有基本元素。
    /// - Note: 与 for-in 不同，当复合状态的子元素也是复合状态时，此方法会遍历更深层次的主题状态。
    /// - Note: 遍历的顺序与 for-in 相同。
    ///
    /// - Parameter body: 遍历子元素所使用的闭包。
    /// - Throws: 抛出异常结束遍历或遍历过程中发生的异常。
    public func forEachPrimaryThemeState(_ body: (Theme.State) throws -> Void) rethrows {
        for themeState in self {
            if themeState.isPrimary {
                try body(themeState)
            } else {
                try themeState.forEachPrimaryThemeState(body)
            }
        }
    }
    
}

extension Theme.State {
    
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
    
    /// 将主题状态转换为 UIControlState，如果 themeState 中包含不可转换为 UIControlState 的主题状态，将返回 nil 。
    /// - Note: 默认值 .normal 。
    ///
    /// - Parameter themeState: 主题状态。
    public init?(_ themeState: Theme.State) {
        var controlState = UIControlState.init(rawValue: 0)
        do {
            try themeState.forEachPrimaryThemeState({ (itemState) in
                switch itemState {
                case .normal:       controlState.formUnion(.normal)
                case .selected:     controlState.formUnion(.selected)
                case .highlighted:  controlState.formUnion(.highlighted)
                case .focused:      if #available(iOS 9.0, *) { controlState.formUnion(.focused) }
                case .disabled:     controlState.formUnion(.disabled)
                default:            throw NSError.init(domain: NSCocoaErrorDomain, code: -1, userInfo: nil)
                }
            })
        } catch {
            return nil
        }
        self = controlState
    }
    
}
