//
//  Theme+UIRefreshControl.swift
//  Pods-Example
//
//  Created by mlibai on 2018/5/3.
//

import Foundation

extension Theme.Attribute {
    /// UIRefreshControl
    public static let isRefreshing = Theme.Attribute.init(rawValue: "isRefreshing")
}

extension Theme.Style {
    
    public var isRefreshing: Bool {
        get { return boolValue(forThemeAttribute: .isRefreshing) }
        set { setValue(newValue, forThemeAttribute: .isRefreshing) }
    }
}


extension UIRefreshControl {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.attributedTitle) {
            self.attributedTitle = themeStyles.attributedTitle
        }
        
        if themeStyles.containsThemeAttribute(.isRefreshing) {
            if themeStyles.isRefreshing {
                self.beginRefreshing()
            } else {
                self.endRefreshing()
            }
        }
    }
    
}
