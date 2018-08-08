//
//  Theme.Attribute.swift
//  XZKit
//
//  Created by mlibai on 2018/5/2.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

extension Theme.Attribute {
    
    /// 空字符串不被视为合法的主题属性。
    public static let notAnAttribute: Theme.Attribute = Theme.Attribute.init(rawValue: "")
    
}

extension Theme.Attribute: ExpressibleByStringLiteral, Equatable, Hashable {
    
    public typealias StringLiteralType = String
    
    /// 通过字符串字面量创建主题属性。
    ///
    /// - Parameter value: 字符串字面量
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
    
    public var hashValue: Int {
        return rawValue.hashValue
    }
    
}
