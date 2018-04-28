//
//  Theme.Style.swift
//  Hello
//
//  Created by mlibai on 2018/4/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

extension Theme {
    
    public final class Style<T: AnyObject> {
        
        public unowned let object: T
        
        init(_ object: T) {
            self.object = object
        }
        
        lazy var attribtedValues: [Theme.Attribute: Any?] = [:]
        
    }
    
}

extension Theme.Style: ThemeSupporting {
    
    public typealias Owner = T
    
    public func value(for attribute: Theme.Attribute) -> Any? {
        if let value = attribtedValues[attribute] {
            return value
        }
        return nil
    }
    
    public func update(_ value: Any?, for attribute: Theme.Attribute) {
        attribtedValues.updateValue(value, forKey: attribute)
    }
    
    public func set(_ value: Any?, for attribute: Theme.Attribute) {
        attribtedValues[attribute] = value
    }
    
}



