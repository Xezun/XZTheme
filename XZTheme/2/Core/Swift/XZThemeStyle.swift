//
//  XZThemeStyle.swift
//  Example
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation
import XZKit

extension Theme {
    
    @objc(XZThemeStyle1) public class Style1: NSObject {
        @objc public unowned let object: ThemeSupporting
        @objc(initWithObject:) public init(_ object: ThemeSupporting) {
            self.object = object
            super.init()
        }
        
        internal lazy var attributedValues = [Theme.Attribute: Any?]()
        
        public var themeAttributes: [Theme.Attribute] {
            return Array(attributedValues.keys)
        }
        
        public func containsThemeAttribute(_ themeAttribute: Theme.Attribute) -> Bool {
            return attributedValues[themeAttribute] != nil
        }
        
        public func setValue(_ value: Any?, forThemeAttribute themeAttribute: Theme.Attribute) {
            attributedValues[themeAttribute] = value
            object.setNeedsThemeAppearanceUpdate()
        }
        
        public func updateValue(_ value: Any?, forThemeAttribute themeAttribute: Theme.Attribute) {
            attributedValues.updateValue(value, forKey: themeAttribute)
            object.setNeedsThemeAppearanceUpdate()
        }
        
        public func removeValue(forThemeAttribute themeAttribute: Theme.Attribute) -> Any? {
            object.setNeedsThemeAppearanceUpdate()
            if let value = attributedValues.removeValue(forKey: themeAttribute) {
                return value
            }
            return nil
        }
        
        public func value(forThemeAttribute themeAttribute: Theme.Attribute) -> Any? {
            if let value = attributedValues[themeAttribute] {
                return value
            }
            return nil
        }
        
        public subscript(themeAttribute: Theme.Attribute) -> Any? {
            get { return value(forThemeAttribute: themeAttribute)       }
            set { setValue(newValue, forThemeAttribute: themeAttribute) }
        }
        
    }
    
    
    
}

extension Theme.Style1 {
    
    @objc(XZThemeStyleCollection1) public final class Collection: Theme.Style1 {
        
        internal lazy var statedStyles = [Theme.State: Theme.Style]()
        
        public func themeStyle(forThemeState themeState: Theme.State) -> Theme.Style {
            if let themeStyle = statedStyles[themeState] {
                return themeStyle
            }
            let themeStyle = Theme.Style.init(self.object)
            setThemeStyle(themeStyle, forThemeState: themeState)
            return themeStyle
        }
        
        public func themeStyleIfLoaded(forThemeState themeState: Theme.State) -> Theme.Style? {
            return statedStyles[themeState]
        }
        
        public func setThemeStyle(_ themeStyle: Theme.Style, forThemeState themeState: Theme.State) {
            statedStyles[themeState] = themeStyle
            object.setNeedsThemeAppearanceUpdate()
        }
        
    }
    
}

extension Theme.Style1.Collection {
    
}

extension Theme.Style {
    
    /// 配置主题样式的链式编程方式支持。
    ///
    /// - Parameters:
    ///   - value: 主题属性值。
    ///   - themeAttribute: 主题属性。
    ///  当前主题样式对象。
    @discardableResult
    open func setting(_ value: Any?, for themeAttribute: Theme.Attribute) -> Theme.Style {
        setValue(value, forThemeAttribute: themeAttribute)
        return self
    }
    
}
