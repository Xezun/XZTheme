//
//  NSObject+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/10.
//  Copyright © 2017年 mlibai. All rights reserved.
//

import UIKit


extension NSObject {
    
    /// 更新主题外观：应用主题样式。当应用主题时，如果主题中有当前对象的主题样式，则此方法会被调用。
    /// - 遍历样式的所有属性并调用“应用指定属性的主题样式”方法。
    /// - 遍历子样式并调用“应用指定 Key 的子样式”的方法。
    ///
    /// - Note: 一般情况下，NSObject 子类不需要重写本方法。
    /// - Parameter themeStyle: 待应用的主题样式。
    @objc(xz_updateAppearanceWithThemeStyle:) open func updateAppearance(with themeStyle: Theme.Style) {
        // 应用属性。
        for themeAttribute in themeStyle.attributes {
            self.updateAppearance(with: themeStyle, for: themeAttribute);
        }
        // 应用子样式。
        for keyedSubstyle in themeStyle.substyles {
            self.updateAppearance(with: keyedSubstyle.value, for: keyedSubstyle.key)
        }
    }
    
    /// 更新主题外观：应用指定属性的主题样式。当前对象被应用的样式所有属性会逐一调用此方法。
    /// - 当应用主题样式时，会通过调用此方法为主题样式中的所有属性应用新的外观。
    /// - 请在此方法中，将指定样式属性的值，赋给对象相应的属性。
    /// - 默认情况下，此方法不执行任何操作。
    ///
    /// - Parameters:
    ///   - themeStyle: 主题样式。
    ///   - themeAttribute: 需要更新外观的属性。
    @objc(xz_updateAppearanceWithThemeStyle:forThemeAttribute:) open func updateAppearance(with themeStyle: Theme.Style, for themeAttribute: Theme.Attribute) {
        
    }
    
    /// 更新主题外观：应用指定 Key 的子样式。当前对象主题样式中的子样式会逐一调用此方法。
    /// - 首先尝试通过 KVC 查找待应用样式的属性对象，如果没有找到则尝试使用 Swift 反射。
    /// - 如果主题配置中的子样式 Key 与属性名称不一致，可重写此方法。
    ///
    /// - Parameters:
    ///   - themeStyle: 待应用的子样式。
    ///   - themeStyleKey: 子样式的 key 。
    @objc(xz_updateAppearanceWithThemeStyle:forThemeStyleKey:) open func updateAppearance(with themeStyle: Theme.Style, for themeStyleKey: String) {
        if self.responds(to: NSSelectorFromString(themeStyleKey)), let subobject = self.value(forKeyPath: themeStyleKey) as? NSObject {
            subobject.updateAppearance(with: themeStyle)
        } else {
            // TODO: 此处性能可以优化。
            (Mirror.init(reflecting: self).children.first(where: { (item) -> Bool in
                return item.label == themeStyleKey
            })?.value as? NSObject)?.updateAppearance(with: themeStyle)
        }
    }
    
}
