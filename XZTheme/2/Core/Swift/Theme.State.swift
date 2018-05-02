//
//  Theme.State.swift
//  Example
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
    public static let normal: Theme.State        = ":normal"
    public static let selected: Theme.State      = ":selected"
    public static let highlighted: Theme.State   = ":highlighted"
    public static let disabled: Theme.State      = ":disabled"
    public static let focused: Theme.State       = ":focused"
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
