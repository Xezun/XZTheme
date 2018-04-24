//
//  NSObject+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/10.
//  Copyright © 2017年 mlibai. All rights reserved.
//

import UIKit

extension NSObject {
    
    /// 更新主题外观：应用主题样式。当应用主题时，如果主题中有当前对象的主题样式，则此方法会被调用。
    ///
    /// - Parameter themeStyle: 待应用的主题样式。
    @objc(xz_updateAppearanceWithThemeStyle:) open func updateAppearance(with themeStyle: Theme.Style) {
       // 每个控件都有自己的最优实现方法。
    }
    
}
