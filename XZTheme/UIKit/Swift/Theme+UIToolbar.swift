//
//  Theme+UIToolbar.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/24.
//

import Foundation

extension Theme.State {
    /// 所有 Theme.State 中 UIBarPosition 的对应关系。
    public static let UIBarPositionItems: [(themeState: Theme.State, barPosition: UIBarPosition)] = [
        (.topBarPosition, .top), (.bottomBarPosition, .bottom),
        (.topAttachedBarPosition, .topAttached), (.anyBarPosition, .any)
    ]
}

extension UIToolbar {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.barStyle) {
            self.barStyle = themeStyles.barStyle
        }
        
        if themeStyles.containsThemeAttribute(.isTranslucent) {
            self.isTranslucent = themeStyles.isTranslucent
        }
        
        if themeStyles.containsThemeAttribute(.barTintColor) {
            self.barTintColor = themeStyles.barTintColor
        }

        for item in Theme.State.UIBarPositionUIBarMetricsItems {
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: item.themeState) else { continue }
            if themeStyle.containsThemeAttribute(.backgroundImage) {
                setBackgroundImage(themeStyle.backgroundImage, forToolbarPosition: item.barPosition, barMetrics: item.barMetrics)
            }
        }
        
        for item in Theme.State.UIBarPositionItems {
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: item.themeState) else { continue }
            if themeStyle.containsThemeAttribute(.shadowImage) {
                setShadowImage(themeStyle.shadowImage, forToolbarPosition: item.barPosition)
            }
        }
        
    }
}
