//
//  ThemeSet.swift
//  Hello
//
//  Created by mlibai on 2018/4/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

extension Theme {
    
    public final class Collection<T: AnyObject> {
        
        public unowned let object: T
        
        init(_ object: T) {
            self.object = object
        }
        
        lazy var themedStyles: [Theme: Theme.Style<T>.Collection<T>] = [:]
        
    }
}

extension Theme.Collection {
    
    func styles(for theme: Theme) -> Theme.Style<T>.Collection<T> {
        if let style = themedStyles[theme] {
            return style
        }
        let style = Theme.Style<T>.Collection.init(object)
        themedStyles[theme] = style
        return style
    }
    
}


