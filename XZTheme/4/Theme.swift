//
//  Theme.swift
//  Hello
//
//  Created by mlibai on 2018/4/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

extension Theme {
    
    public private(set) static var current: Theme = Theme.init(name: "default")
    public static let `default`: Theme = Theme.init(name: "default")
    
    public static func setCurrent(_ current: Theme, animated: Bool) {
        
    }
    
}

public struct Theme {
    
    let name: String
    
    public init(name: String) {
        self.name = name
    }
    
    
    public struct Attribute: RawRepresentable {
        public typealias RawValue = String
        
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
    
    public struct State: RawRepresentable {
        public typealias RawValue = String
        
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
    
    public final class Style<T: AnyObject> {
        
        public unowned let object: T
        
        init(_ object: T) {
            self.object = object
        }
        
        lazy var attribtedValues: [Theme.Attribute: Any?] = [:]
        
    }
    
}

extension Theme: ExpressibleByStringLiteral, Equatable, Hashable {
    
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: String) {
        self.init(name: value)
    }
    
    public static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.name == rhs.name
    }
    
    public var hashValue: Int {
        return name.hashValue
    }
    
}




