//
//  Theme+UIView.swift
//  Example
//
//  Created by mlibai on 2018/4/28.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import Foundation

extension Theme.Style where ObjectType == UIView {
    
    public var backgroundColor: UIColor? {
        get { return color(forThemeAttribute: .backgroundColor)         }
        set { setValue(newValue, forThemeAttribute: .backgroundColor)   }
    }
    
}

extension UIView {
    
    /// 作为 UIView 控件，当主题改变时，其会自动应用 .backgroundColor、.tintColor、.isHidden、.alpha、.isOpaque 等属性。
    /// - Note: 使用 Swift 重写此方法，方便使用 switch 遍历主题属性。
    ///
    /// - Parameter themeStyles: 主题样式。
    public func updateAppearance(with themeStyles: Theme.StyleCollection<UIView>) {
        // 遍历配置，就会导致子类父类多次遍历。
        // 但是检测是否存在（判断字典是否存在键）属性再赋值，能否效率更高，有待验证。
        
        if themeStyles.containsThemeAttribute(.backgroundColor) {
            self.backgroundColor = themeStyles.backgroundColor
        }
        
//        if themeStyles.containsThemeAttribute(.tintColor) {
//            self.tintColor = themeStyles.tintColor
//        }
//
//        if themeStyles.containsThemeAttribute(.isHidden) {
//            self.isHidden = themeStyles.isHidden
//        }
//
//        if themeStyles.containsThemeAttribute(.alpha) {
//            self.alpha = themeStyles.alpha
//        }
//
//        if themeStyles.containsThemeAttribute(.isOpaque) {
//            self.isOpaque = themeStyles.isOpaque
//        }
    }
    
    
}
