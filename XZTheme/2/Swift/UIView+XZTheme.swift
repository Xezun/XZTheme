//
//  UIView+XZTheme.swift
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

import UIKit

extension UIView {
    
    /// 当主题改变时，是否应该更新子控件样式。
    /// @note 例如：UIView 默认 YES；UIButton 默认 NO 等。
    @objc(xz_updatesAppearanceForSubviews) open func updatesAppearanceForSubviews() -> Bool {
        return true
    }
    
    /// 作为视图控件，当其自身被标为需要更新主题时，其子视图会同时标记为需要更新主题。
    /// - Note: 子类通过 updatesAppearanceForSubviews() 方法来控制是否传递主题。
    open override func setNeedsThemeAppearanceUpdate() {
        super.setNeedsThemeAppearanceUpdate()
        
        guard updatesAppearanceForSubviews() else {
            return
        }
        
        for subview in subviews {
            subview.setNeedsThemeAppearanceUpdate()
        }
    }
    
    open override func updateAppearance(with themeStyles: Theme.Styles) {
        super.updateAppearance(with: themeStyles)
        
        for themeAttribute in themeStyles.themeAttributes {
            switch themeAttribute {
            case .backgroundColor: self.backgroundColor = themeStyles.backgroundColor;
            case .tintColor:       self.tintColor       = themeStyles.tintColor;
            case .isHidden:        self.isHidden        = themeStyles.isHidden;
            case .alpha:           self.alpha           = themeStyles.alpha;
            case .isOpaque:        self.isOpaque        = themeStyles.isOpaque;
            default:               break;
            }
        }
        
        
    }
    
    
    
}


