//
//  ThemeSupporting.swift
//  Hello
//
//  Created by mlibai on 2018/4/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

public protocol ThemeSupporting: class {
    
    associatedtype Owner: AnyObject
    
    func value(for attribute: Theme.Attribute) -> Any?
    func update(_ value: Any?, for attribute: Theme.Attribute)
}

extension ThemeSupporting where Self.Owner: UIView {
    
    public var backgroundColor: UIColor? {
        get { return nil }
        set { update(newValue, for: .backgroundColor) }
    }
    
}

extension ThemeSupporting where Self.Owner: UIButton {
    
    public var title: String? {
        get { return nil }
        set { update(newValue, for: .title)}
    }
}
