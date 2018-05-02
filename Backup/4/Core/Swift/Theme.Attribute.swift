//
//  Theme.Attribute.swift
//  Hello
//
//  Created by mlibai on 2018/4/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation


extension Theme.Attribute: ExpressibleByStringLiteral {
    
    public typealias StringLiteralType = String
    
    /// 通过字符串字面量创建主题属性。
    ///
    /// - Parameter value: 字符串字面量
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
    
}

