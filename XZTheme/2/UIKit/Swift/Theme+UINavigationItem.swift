//
//  Theme+UINavigationItem.swift
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

extension UINavigationItem {
    
    /// 当被标记为需要更新主题时，其 backBarButtonItem、leftBarButtonItems、rightBarButtonItems 会被标记为需要更新。
    open override func setNeedsThemeAppearanceUpdate() {
        if needsUpdateThemeAppearance {
            return
        }
        super.setNeedsThemeAppearanceUpdate()
        
        // self.titleView Will be called by it's superview.
        
        self.backBarButtonItem?.setNeedsThemeAppearanceUpdate()
        
        if let leftBarButtonItems = self.leftBarButtonItems {
            for barButtonItem in leftBarButtonItems {
                barButtonItem.setNeedsThemeAppearanceUpdate()
            }
        }
        
        if let rightBarButtonItems = self.rightBarButtonItems {
            for barButtonItem in rightBarButtonItems {
                barButtonItem.setNeedsThemeAppearanceUpdate()
            }
        }
        
    }
    
}
