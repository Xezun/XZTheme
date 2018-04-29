//
//  XZTheme+UIViewController.swift
//  Example
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

extension Theme.Attribute {
    
    public static let statusBarStyle = Theme.Attribute.init("statusBarStyle")
    
}

extension Theme.Style {
    
    
    public func statusBarStyle(forThemeAttribute themeAttribute: Theme.Attribute) -> UIStatusBarStyle {
        if let statusBarStyle = value(forThemeAttribute: themeAttribute) as? UIStatusBarStyle {
            return statusBarStyle
        } else if let statusBarStyle = UIStatusBarStyle.init(rawValue: integerValue(forThemeAttribute: themeAttribute)) {
            return statusBarStyle
        }
        return .default
    }
    
    public var statusBarStyle: UIStatusBarStyle {
        get { return statusBarStyle(forThemeAttribute: .statusBarStyle) }
        set { setValue(newValue, forThemeAttribute: .statusBarStyle)    }
    }
    
}

extension UIViewController {
    
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
