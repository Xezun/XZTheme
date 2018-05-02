//
//  XZTheme+UIViewController.swift
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

extension Theme.Attribute {
    
    /// UIViewController.statusBarStyle
    public static let statusBarStyle = Theme.Attribute.init("statusBarStyle")
    
}

extension Theme.Style {
    
    public var statusBarStyle: UIStatusBarStyle {
        get { return statusBarStyle(forThemeAttribute: .statusBarStyle) }
        set { setValue(newValue, forThemeAttribute: .statusBarStyle)    }
    }
    
}

extension UIViewController {
    
    
    /// 自动应用样式：.title, .statusBarStyle 。
    ///
    /// - Parameter themeStyles: 主题样式。
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.title) {
            self.title = themeStyles.title
        }
        
        if themeStyles.containsThemeAttribute(.statusBarStyle) {
            self.statusBarStyle = themeStyles.statusBarStyle
        }
        
    }
    
}
