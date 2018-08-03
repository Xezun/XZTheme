//
//  Theme+UINavigationBar.swift
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZKit

extension Theme.State {

    /// UIBarMetrics.default
    public static let defaultBarMetrics       = Theme.State.init(name:":defaultBarMetrics", rawValue: UIBarMetrics.default)
    /// UIBarMetrics.compact
    public static let compactBarMetrics       = Theme.State.init(name: ":compactBarMetrics", rawValue: UIBarMetrics.compact)
    /// UIBarMetrics.defaultPrompt
    public static let defaultPromptBarMetrics = Theme.State.init(name: ":defaultPromptBarMetrics", rawValue: UIBarMetrics.defaultPrompt)
    /// UIBarMetrics.compactPrompt
    public static let compactPromptBarMetrics = Theme.State.init(name: ":compactPromptBarMetrics", rawValue: UIBarMetrics.compactPrompt)
    
    
    /// UIBarPosition.any
    public static let anyBarPosition         = Theme.State.init(name: ":anyBarPosition", rawValue: UIBarPosition.any)
    /// UIBarPosition.bottom
    public static let bottomBarPosition      = Theme.State.init(name: ":bottomBarPosition", rawValue: UIBarPosition.bottom)
    /// UIBarPosition.top
    public static let topBarPosition         = Theme.State.init(name: ":topBarPosition", rawValue: UIBarPosition.top)
    /// UIBarPosition.topAttached
    public static let topAttachedBarPosition = Theme.State.init(name: ":topAttachedBarPosition", rawValue: UIBarPosition.topAttached)
 
}

extension UIBarMetrics {
    
    public init?(_ themeState: Theme.State) {
        guard themeState.rawType == UIBarMetrics.self else {
            return nil
        }
        self = themeState.rawValue as! UIBarMetrics
    }
}

extension UIBarPosition {
    
    public init?(_ themeState: Theme.State) {
        guard themeState.rawType == UIBarPosition.self else {
            return nil
        }
        self = themeState.rawValue as! UIBarPosition
    }
}


extension Theme.Attribute {
    
    /// UINavigationBar.largeTitleTextAttributes
    public static let largeTitleTextAttributes          = Theme.Attribute.init(rawValue: "largeTitleTextAttributes")
    /// UINavigationBar.backIndicatorImage
    public static let backIndicatorImage                = Theme.Attribute.init(rawValue: "backIndicatorImage")
    /// UINavigationBar.backIndicatorTransitionMaskImage
    public static let backIndicatorTransitionMaskImage  = Theme.Attribute.init(rawValue: "backIndicatorTransitionMaskImage")
    /// UINavigationBar.prefersLargeTitles
    public static let prefersLargeTitles                = Theme.Attribute.init(rawValue: "prefersLargeTitles")
    /// UINavigationBar
    public static let titleVerticalPositionAdjustment   = Theme.Attribute.init(rawValue: "titleVerticalPositionAdjustment")
}

extension Theme.Style {
    
    public var largeTitleTextAttributes: [NSAttributedStringKey: Any]? {
        get { return stringAttributes(forThemeAttribute: .largeTitleTextAttributes) }
        set { setValue(newValue, forThemeAttribute: .largeTitleTextAttributes)      }
    }
    
    public var backIndicatorImage: UIImage? {
        get { return image(forThemeAttribute: .backIndicatorImage) }
        set { setValue(newValue, forThemeAttribute: .backIndicatorImage) }
    }
    
    public var backIndicatorTransitionMaskImage: UIImage? {
        get { return image(forThemeAttribute: .backIndicatorTransitionMaskImage) }
        set { setValue(newValue, forThemeAttribute: .backIndicatorTransitionMaskImage) }
    }
    
    public var prefersLargeTitles: Bool {
        get { return boolValue(forThemeAttribute: .prefersLargeTitles)   }
        set { setValue(newValue, forThemeAttribute: .prefersLargeTitles) }
    }
    
    public var titleVerticalPositionAdjustment: CGFloat {
        get { return floatValue(forThemeAttribute: .titleVerticalPositionAdjustment) }
        set { setValue(newValue, forThemeAttribute: .titleVerticalPositionAdjustment) }
    }
}


extension UINavigationBar {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if #available(iOS 11.0, *) {
            if themeStyles.containsThemeAttribute(.prefersLargeTitles) {
                self.prefersLargeTitles = themeStyles.prefersLargeTitles
            }
        }
        
        if themeStyles.containsThemeAttribute(.barTintColor) {
            self.barTintColor = themeStyles.barTintColor
        }
        
        if themeStyles.containsThemeAttribute(.shadowImage) {
            self.shadowImage = themeStyles.shadowImage
        }
        
        if themeStyles.containsThemeAttribute(.barStyle) {
            self.barStyle = themeStyles.barStyle
        }
        
        if themeStyles.containsThemeAttribute(.isTranslucent) {
            self.isTranslucent = themeStyles.isTranslucent
        }
        
        if themeStyles.containsThemeAttribute(.titleTextAttributes) {
            self.titleTextAttributes = themeStyles.titleTextAttributes
        }
        
        if themeStyles.containsThemeAttribute(.backIndicatorImage) {
            self.backIndicatorImage = themeStyles.backIndicatorImage
        }
        
        if themeStyles.containsThemeAttribute(.backIndicatorTransitionMaskImage) {
            self.backIndicatorTransitionMaskImage =  themeStyles.backIndicatorTransitionMaskImage
        }
        
        // 保证先应用简单状态，后应用复合状态。
        let themeStates = themeStyles.effectiveThemeStates.sorted(by: { (_, state2) -> Bool in
            return state2.isPrimary
        })
        
        for themeState in themeStates {
            if themeState.isPrimary {
                guard let barMetrics = UIBarMetrics.init(themeState) else {
                    XZLog("Unapplied Theme.State %@ for UINavigationBar.", themeState)
                    continue
                }
                guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: themeState) else { continue }
                if themeStyle.containsThemeAttribute(.titleVerticalPositionAdjustment) {
                    self.setTitleVerticalPositionAdjustment(themeStyle.titleVerticalPositionAdjustment, for: barMetrics)
                }
                if themeStyle.containsThemeAttribute(.backgroundImage) {
                    self.setBackgroundImage(themeStyle.backgroundImage, for: barMetrics)
                }
            } else if themeState.count >= 2 {
                guard let barPosition = UIBarPosition.init(themeState[0]),
                    let barMetrics = UIBarMetrics.init(themeState[1]) else {
                        XZLog("Unapplied Theme.State %@ for UINavigationBar.", themeState)
                        continue
                }
                guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: themeState) else { continue }
                if themeStyle.containsThemeAttribute(.backgroundImage) {
                    self.setBackgroundImage(themeStyle.backgroundImage, for: barPosition, barMetrics: barMetrics)
                }
            } else {
                XZLog("Unapplied Theme.State %@ for UINavigationBar.", themeState)
            }
        }
        
    }
    
}
