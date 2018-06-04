//
//  Theme.State.swift
//  XZKit
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZKit

extension Theme.State: Equatable, Hashable {
    
    public static func == (lhs: Theme.State, rhs: Theme.State) -> Bool {
        return lhs.name == rhs.name
    }
    
    /// 主题状态的 hashValue 为其原始值的 hashValue 。
    public var hashValue: Int {
        return name.hashValue
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
            if themeState.children.isEmpty {
                try body(themeState)
            } else {
                try themeState.forEachPrimaryThemeState(body)
            }
        }
    }
    
}

extension Theme.State {
    
}

//extension Theme.State: _ObjectiveCBridgeable {
//
//    public func _bridgeToObjectiveC() -> NSString {
//        return rawValue as NSString
//    }
//
//    public static func _forceBridgeFromObjectiveC(_ source: NSString, result: inout Theme.State?) {
//        result = Theme.State.init(rawValue: source as String, rawType: Any.self, isOptionSetElement: false)
//    }
//
//    public static func _conditionallyBridgeFromObjectiveC(_ source: NSString, result: inout Theme.State?) -> Bool {
//        _forceBridgeFromObjectiveC(source, result: &result)
//        return true
//    }
//
//    public static func _unconditionallyBridgeFromObjectiveC(_ source: NSString?) -> Theme.State {
//        if let value = source as String? {
//            return Theme.State.init(rawValue: value as String, rawType: Any.self, isOptionSetElement: false)
//        }
//        return Theme.State.normal;
//    }
//
//    public typealias _ObjectiveCType = NSString
//}

extension Theme.State {
    
    /// UIControlState.normal
    public static let normal        = Theme.State.init(name: ":normal", rawValue: UIControlState.normal, rawType: UIControlState.self, isOptionSet: true)
    /// UIControlState.selected
    public static let selected     = Theme.State.init(name: ":selected", rawValue: UIControlState.selected, rawType: UIControlState.self, isOptionSet: true)
    /// UIControlState.highlighted
    public static let highlighted  = Theme.State.init(name: ":highlighted", rawValue: UIControlState.highlighted, rawType: UIControlState.self, isOptionSet: true)
    /// UIControlState.disabled
    public static let disabled     = Theme.State.init(name: ":disabled", rawValue: UIControlState.disabled, rawType: UIControlState.self, isOptionSet: true)
    /// UIControlState.focused
    public static let focused      = { () -> Theme.State in
        if #available(iOS 9.0, *) {
            return Theme.State.init( name: ":focused", rawValue: UIControlState.focused, rawType: UIControlState.self, isOptionSet: true)
        } else {
            return Theme.State.init( name: ":focused", rawValue: UIControlState.normal, rawType: UIControlState.self, isOptionSet: true)
        }
    }()
    
}

extension UIControlState {
    
    /// 将主题状态转换为 UIControlState，如果 themeState 中包含不可转换为 UIControlState 的主题状态，将返回 nil 。
    /// - Note: 默认值 .normal 。
    ///
    /// - Parameter themeState: 主题状态。
    public init?(_ themeState: Theme.State) {
        guard themeState.rawType == UIControlState.self else {
            return nil
        }
        if themeState.isPrimary {
            self = themeState.rawValue as! UIControlState
        } else {
            var controlState: UIControlState! = nil
            UIControlState.forEach(themeState.rawValue as! [Any], &controlState)
            self = controlState
        }
    }
    
    private static func forEach(_ states: [Any], _ result: inout UIControlState?) {
        for item in states {
            if let state = item as? UIControlState {
                if result == nil {
                    result = state
                } else {
                    result!.formUnion(state)
                }
            } else {
                forEach(item as! [Any], &result)
            }
        }
    }
    

    
}
