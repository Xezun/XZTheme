//
//  Theme.swift
//  Example
//
//  Created by mlibai on 2018/6/3.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation
import XZTheme

extension Theme {
    static var day: Theme {
        return Theme.default
    }
    static let night = Theme(name: "night")
}

extension Theme.Collection {
    
    var day: Theme.Style.Collection {
        return self.themeStyles(forTheme: .day)
    }
    
    var night: Theme.Style.Collection {
        return self.themeStyles(forTheme: .night)
    }
    
}
