//
//  XZTheme+UINavigationBar.swift
//  Example
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

extension Theme.Attribute {
    
}

extension Theme.Style {
    
}


extension UINavigationBar {
    
    open override func forwardsThemeAppearanceUpdate() -> Bool {
        return false
    }
 
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.barTintColor) {
            self.barTintColor = themeStyles.barTintColor
        }
        
        if themeStyles.containsThemeAttribute(.shadowImage) {
            self.shadowImage = themeStyles.shadowImage
        }
        
        if themeStyles.containsThemeAttribute(.barStyle) {
            self.barStyle = themeStyles.barStyle
        }
        
        
    }
    
}
