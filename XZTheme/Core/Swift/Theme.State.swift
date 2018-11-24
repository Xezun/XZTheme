//
//  Theme.State.swift
//  XZKit
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZKit

extension Theme.State: Equatable, Hashable, ExpressibleByArrayLiteral, CustomStringConvertible {
    
    /// 根据 name 比较两个 Theme.State 是否相同。
    public static func == (lhs: Theme.State, rhs: Theme.State) -> Bool {
        return lhs.name == rhs.name
    }
    
    /// 主题状态的 hashValue 为其原始值的 hashValue 。
    public var hashValue: Int {
        return name.hashValue
    }
    
    public typealias ArrayLiteralElement = Theme.State
    
    public init(arrayLiteral elements: Theme.State...) {
        self.init(elements)
    }
    
    /// 与 name 属性相同。
    public var description: String {
        return name
    }
    
    
}


extension Theme.State {
    
    /// 遍历主题状态中的所有基本元素。
    /// - Important: 与 for-in 不同，此方法遍历当前状态包含的所有基本状态。
    ///
    /// - Parameter body: 遍历子元素所使用的闭包。
    /// - Throws: 抛出异常结束遍历或遍历过程中发生的异常。
    public func forEach(_ body: (Theme.State) throws -> Void) rethrows {
        for themeState in self {
            if themeState.isPrimary {
                try body(themeState)
            } else {
                try themeState.forEach(body)
            }
        }
    }
    
}

extension Theme.State {
    /// UIControl.State.normal 正常状态。
    public static let normal = Theme.State.init(name: ":normal", rawValue: UIControl.State.normal, isOptionSet: true)
    /// UIControl.State.selected 选中状态。
    public static let selected = Theme.State.init(name: ":selected", rawValue: UIControl.State.selected, isOptionSet: true)
    /// UIControl.State.highlighted 高亮状态。
    public static let highlighted = Theme.State.init(name: ":highlighted", rawValue: UIControl.State.highlighted, isOptionSet: true)
    /// UIControl.State.disabled 禁用状态。
    public static let disabled = Theme.State.init(name: ":disabled", rawValue: UIControl.State.disabled, isOptionSet: true)
}

extension UIControl.State {
    
    /// 将主题状态转换为 UIControlState，如果 themeState 中包含不可转换为 UIControlState 的主题状态，将返回 nil 。
    /// - Note: 默认值 .normal 。
    ///
    /// - Parameter themeState: 主题状态。
    public init?(_ themeState: Theme.State) {
        guard themeState.rawType == UIControl.State.self else {
            return nil
        }
        if themeState.isPrimary {
            self = themeState.rawValue as! UIControl.State
        } else {
            /// 合并可能包含 [UIControlState] 或 UIControlState 的数组中的所有 UIControlState 元素。
            func formUnionEachState(in states: [Any], _ result: inout UIControl.State) {
                for item in states {
                    if let state = item as? UIControl.State {
                        result.formUnion(state)
                    } else {
                        formUnionEachState(in: item as! [Any], &result)
                    }
                }
            }
            var controlState = UIControl.State.init(rawValue: 0)
            formUnionEachState(in: themeState.rawValue as! [Any], &controlState)
            self = controlState
        }
    }
    
    
    

    
}
