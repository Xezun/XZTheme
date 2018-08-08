//
//  Theme+UIToolbar.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/24.
//

import Foundation
import XZKit

extension UIToolbar {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.contains(.barStyle) {
            self.barStyle = themeStyles.barStyle
        }
        
        if themeStyles.contains(.isTranslucent) {
            self.isTranslucent = themeStyles.isTranslucent
        }
        
        if themeStyles.contains(.barTintColor) {
            self.barTintColor = themeStyles.barTintColor
        }
        
        for themeState in Array<Theme.State>.init(themeStyles) {
            if themeState.isPrimary {
                guard let barPosition = UIBarPosition.init(themeState) else {
                    XZLog("Unapplied Theme.State %@ for UIToolbar.", themeState)
                    continue
                }
                guard let themeStyle = themeStyles.themeStyleIfLoaded(for: themeState) else { continue }
                if themeStyle.contains(.shadowImage) {
                    setShadowImage(themeStyle.shadowImage, forToolbarPosition: barPosition)
                }
            } else if themeState.count >= 2 {
                guard let barPosition = UIBarPosition.init(themeState[0]),
                    let barMetrics = UIBarMetrics.init(themeState[1]) else {
                        XZLog("Unapplied Theme.State %@ for UIToolbar.", themeState)
                        continue
                }
                guard let themeStyle = themeStyles.themeStyleIfLoaded(for: themeState) else { continue }
                if themeStyle.contains(.backgroundImage) {
                    setBackgroundImage(themeStyle.backgroundImage, forToolbarPosition: barPosition, barMetrics: barMetrics)
                }
            } else {
                XZLog("Unapplied Theme.State %@ for UIToolbar.", themeState)
            }
        }
        
    }
}
