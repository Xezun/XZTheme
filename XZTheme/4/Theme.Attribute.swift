//
//  Theme.Attribute.swift
//  Hello
//
//  Created by mlibai on 2018/4/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

extension Theme.Attribute {
    
    static let backgroundColor = Theme.Attribute.init(rawValue: "backgroundColor")
    
    static let title = Theme.Attribute.init(rawValue: "title")
}

extension Theme.Attribute: ExpressibleByStringLiteral, Equatable, Hashable {
    
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
    
    public static func == (lhs: Theme.Attribute, rhs: Theme.Attribute) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    public var hashValue: Int {
        return rawValue.hashValue
    }
}


