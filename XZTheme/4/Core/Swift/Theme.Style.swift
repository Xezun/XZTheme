//
//  Theme.Style.swift
//  Hello
//
//  Created by mlibai on 2018/4/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit


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
    
    public func removeValue(for attribute: Theme.Attribute) -> Any?? {
        return self.attribtedValues.removeValue(forKey: attribute)
    }
 
}










