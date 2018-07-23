//
//  Theme+UIToolbar.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/24.
//

import Foundation
import XZKit

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
        
        for themeState in themeStyles.effectiveThemeStates {
            if themeState.isBasic {
                guard let barPosition = UIBarPosition.init(themeState) else {
                    XZLog("Unapplied Theme.State %@ for UIToolbar.", themeState)
                    continue
                }
                guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: themeState) else { continue }
                if themeStyle.containsThemeAttribute(.shadowImage) {
                    setShadowImage(themeStyle.shadowImage, forToolbarPosition: barPosition)
                }
            } else if themeState.count >= 2 {
                guard let barPosition = UIBarPosition.init(themeState[0]),
                    let barMetrics = UIBarMetrics.init(themeState[1]) else {
                        XZLog("Unapplied Theme.State %@ for UIToolbar.", themeState)
                        continue
                }
                guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: themeState) else { continue }
                if themeStyle.containsThemeAttribute(.backgroundImage) {
                    setBackgroundImage(themeStyle.backgroundImage, forToolbarPosition: barPosition, barMetrics: barMetrics)
                }
            } else {
                XZLog("Unapplied Theme.State %@ for UIToolbar.", themeState)
            }
        }
        
    }
}
