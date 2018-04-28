//
//  ThemeSupporting.swift
//  Hello
//
//  Created by mlibai on 2018/4/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

/// ThemeSupporting 定义了支持主题功能的对象拥有的方法。
/// - Note: 对象 Theme.Style、 Theme.Style.Collection 的基础协议。
/// - Note: 通过拓展 ThemeSupporting 协议来增加主题支持的范围。
public protocol ThemeSupporting: class {
    
    /// 主题的拥有者。
    associatedtype Owner: AnyObject
    
    /// 获取主题中存储的属性值。
    ///
    /// - Parameter attribute: 主题属性。
    /// - Returns: 主题属性值。
    func value(for attribute: Theme.Attribute) -> Any?
    
    /// 更新主题属性值。
    /// - Note: 值 nil 也会更新到主题配置中。
    ///
    /// - Parameters:
    ///   - value: 待更新的值。
    ///   - attribute: 待更新的属性。
    func update(_ value: Any?, for attribute: Theme.Attribute)
    
    /// 删除主题属性（包括属性和值）。
    ///
    /// - Parameter attribute: 主题属性。
    @discardableResult func removeValue(for attribute: Theme.Attribute) -> Any??
    
    
}

extension ThemeSupporting {
    
    /// 主题属性值的角标访问方式。
    /// - Note: 与 Dictionary 类似，设置 nil 值会删除主题属性。
    ///
    /// - Parameter attribute: 主题属性。
    public subscript(attribute: Theme.Attribute) -> Any? {
        get {
            return value(for: attribute)
        }
        set {
            if let value = newValue {
                update(value, for: attribute)
            } else {
                removeValue(for: attribute)
            }
        }
    }
    
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
