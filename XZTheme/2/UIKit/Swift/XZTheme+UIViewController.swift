//
//  XZTheme+UIViewController.swift
//  Example
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit


extension UIViewController {
    
    /// 作为控制器，当其自身被标记为需要应用主题时，会同时标记其 childViewControllers、presentedViewController、navigationItem、toolbarItems、tabBarItem 。
    open override func setNeedsThemeAppearanceUpdate() {
        if needsThemeAppearanceUpdate() {
            return
        }
        super.setNeedsThemeAppearanceUpdate()
        
        if self.navigationController != nil {
            self.navigationItem.setNeedsThemeAppearanceUpdate()
        }
        
        if self.tabBarController != nil {
            self.tabBarItem.setNeedsThemeAppearanceUpdate()
        }
        
        if let toolbarItems = self.toolbarItems {
            for toolbarItem in toolbarItems {
                toolbarItem.setNeedsThemeAppearanceUpdate()
            }
        }
        
        for childViewController in self.childViewControllers {
            childViewController.setNeedsThemeAppearanceUpdate()
        }
        
        self.presentedViewController?.setNeedsThemeAppearanceUpdate()
    
    }
}
