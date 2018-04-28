//
//  Themable.swift
//  Hello
//
//  Created by mlibai on 2018/4/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

protocol Themable: class {
    
    associatedtype Owner: AnyObject
    
    var themes: Theme.Collection<Owner> { get }
    
}

extension Themable {
    
    var themes: Theme.Collection<Self> {
        return Theme.Collection.init(self)
    }
    
}

extension NSObject: Themable {
    
    
}
