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
        // 遍历所有状态。
        for themeState in themeStyle.themeStates {
            let themeAttributes = themeStyle.themeAttributes(forState: themeState)!
            // 遍历所有属性
            for themeAttribute in themeAttributes.themeAttributes {
                applyThemeAttribute(themeAttribute, for: themeState, in: themeAttributes)
            }
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
    @objc(xz_applyThemeAttribute:forThemeState:inThemeAttributes:) open func applyThemeAttribute(_ themeAttribute: Theme.Attribute, for themeState: Theme.State, in themeAttributes: Theme.Attributes) {
        
    }
    
}
