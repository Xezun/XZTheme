//
//  XZTheme+UIView.swift
//  Example
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

extension Theme.Attribute {
    
    /// UIView.tintColor
    public static let tintColor         = Theme.Attribute.init("tintColor");
    /// UIView.isHidden
    public static let isHidden          = Theme.Attribute.init("isHidden");
    /// UIView.backgroundColor
    public static let backgroundColor   = Theme.Attribute.init("backgroundColor");
    /// UIView.alpha
    public static let alpha             = Theme.Attribute.init("alpha");
    /// UIView.isOpaque
    public static let isOpaque          = Theme.Attribute.init("isOpaque");
    
}

extension Theme.Style {
    
    public var backgroundColor: UIColor? {
        get { return color(forThemeAttribute: .backgroundColor)        }
        set { setValue(newValue, forThemeAttribute: .backgroundColor)  }
    }
    
    public var tintColor: UIColor? {
        get { return color(forThemeAttribute: .tintColor)       }
        set { setValue(newValue, forThemeAttribute: .tintColor) }
    }
    
    public var isHidden: Bool {
        get { return boolValue(forThemeAttribute: .isHidden)       }
        set { setValue(newValue, forThemeAttribute: .isHidden) }
    }
    
    public var isOpaque: Bool {
        get { return boolValue(forThemeAttribute: .isOpaque)   }
        set { setValue(newValue, forThemeAttribute: .isOpaque) }
    }
    
    public var alpha: CGFloat {
        get { return CGFloat(doubleValue(forThemeAttribute: .alpha)) }
        set { setValue(newValue, forThemeAttribute: .alpha)          }
    }
    
}

extension UIView {
    
    /// 作为 UIView 控件，当主题改变时，其会自动应用 .backgroundColor、.tintColor、.isHidden、.alpha、.isOpaque 等属性。
    /// - Note: 使用 Swift 重写此方法，方便使用 switch 遍历主题属性。
    ///
    /// - Parameter themeStyles: 主题样式。
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        // 遍历配置，就会导致子类父类多次遍历。
        // 但是检测是否存在（判断字典是否存在键）属性再赋值，能否效率更高，有待验证。
        
        if themeStyles.containsThemeAttribute(.backgroundColor) {
            self.backgroundColor = themeStyles.backgroundColor
        }
        
        if themeStyles.containsThemeAttribute(.tintColor) {
            self.tintColor = themeStyles.tintColor
        }
        
        if themeStyles.containsThemeAttribute(.isHidden) {
            self.isHidden = themeStyles.isHidden
        }
        
        if themeStyles.containsThemeAttribute(.alpha) {
            self.alpha = themeStyles.alpha
        }
        
        if themeStyles.containsThemeAttribute(.isOpaque) {
            self.isOpaque = themeStyles.isOpaque
        }
    }
    
}
