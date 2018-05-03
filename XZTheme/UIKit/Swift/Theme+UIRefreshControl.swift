//
//  Theme+UIRefreshControl.swift
//  Pods-Example
//
//  Created by mlibai on 2018/5/3.
//

import Foundation


extension UIRefreshControl {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.attributedTitle) {
            self.attributedTitle = themeStyles.attributedTitle
        }
        
    }
    
}
