//
//  XZTheme+UIScrollView.swift
//  Example
//
//  Created by mlibai on 2018/5/1.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

extension Theme.Attribute {
    
    /// UIScrollView.indicatorStyle
    public static let indicatorStyle = Theme.Attribute.init("indicatorStyle")
    
}

extension Theme.Style {
    
    public var indicatorStyle: UIScrollViewIndicatorStyle {
        get { return indicatorStyle(forThemeAttribute: .indicatorStyle) }
        set { setValue(newValue, forThemeAttribute: .indicatorStyle) }
    }
    
}

extension UIScrollView {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.indicatorStyle) {
            self.indicatorStyle = themeStyles.indicatorStyle
        }
    }
    
}
