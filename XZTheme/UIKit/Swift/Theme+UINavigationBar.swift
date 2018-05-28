//
//  Theme+UINavigationBar.swift
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

extension Theme.State {

    /// UIBarMetrics.default
    public static let defaultBarMetrics       = Theme.State.init(rawValue: ":defaultBarMetrics")
    /// UIBarMetrics.compact
    public static let compactBarMetrics       = Theme.State.init(rawValue: ":compactBarMetrics")
    /// UIBarMetrics.defaultPrompt
    public static let defaultPromptBarMetrics = Theme.State.init(rawValue: ":defaultPromptBarMetrics")
    /// UIBarMetrics.compactPrompt
    public static let compactPromptBarMetrics = Theme.State.init(rawValue: ":compactPromptBarMetrics")
    
    
    /// UIBarPosition.any
    public static let anyBarPosition         = Theme.State.init(rawValue: ":anyBarPosition")
    /// UIBarPosition.bottom
    public static let bottomBarPosition      = Theme.State.init(rawValue: ":bottomBarPosition")
    /// UIBarPosition.top
    public static let topBarPosition         = Theme.State.init(rawValue: ":topBarPosition")
    /// UIBarPosition.topAttached
    public static let topAttachedBarPosition = Theme.State.init(rawValue: ":topAttachedBarPosition")
    
    
    /// 所有 Theme.State 中 UIBarMetrics 的对应关系。
    public static let UIBarMetricsItems: [(themeState: Theme.State, barMetrics: UIBarMetrics)] = [
        (.defaultBarMetrics, .default), (.compactBarMetrics, .compact),
        (.defaultPromptBarMetrics, .defaultPrompt), (.compactPromptBarMetrics, .compactPrompt)
    ]
    
    /// 所有 Theme.State 中 UIBarMetrics、UIBarPosition 的组合。
    public static let UIBarPositionUIBarMetricsItems: [(themeState: Theme.State, barMetrics: UIBarMetrics, barPosition: UIBarPosition)] = [
        ([.anyBarPosition, .defaultBarMetrics], .default, .any), ([.bottomBarPosition, .defaultBarMetrics], .default, .bottom),
        ([.topBarPosition, .defaultBarMetrics], .default, .top), ([.topAttachedBarPosition, .defaultBarMetrics], .default, .topAttached),
        
        ([.anyBarPosition, .compactBarMetrics], .compact, .any), ([.bottomBarPosition, .compactBarMetrics], .compact, .bottom),
        ([.topBarPosition, .compactBarMetrics], .compact, .top), ([.topAttachedBarPosition, .compactBarMetrics], .compact, .topAttached),
        
        ([.anyBarPosition, .defaultPromptBarMetrics], .defaultPrompt, .any), ([.bottomBarPosition, .defaultPromptBarMetrics], .defaultPrompt, .bottom),
        ([.topBarPosition, .defaultPromptBarMetrics], .defaultPrompt, .top), ([.topAttachedBarPosition, .defaultPromptBarMetrics], .defaultPrompt, .topAttached),
        
        ([.anyBarPosition, .compactPromptBarMetrics], .compactPrompt, .any), ([.bottomBarPosition, .compactPromptBarMetrics], .compactPrompt, .bottom),
        ([.topBarPosition, .compactPromptBarMetrics], .compactPrompt, .top), ([.topAttachedBarPosition, .compactPromptBarMetrics], .compactPrompt, .topAttached)
    ]
 
}





extension Theme.Attribute {
    
    /// UINavigationBar.largeTitleTextAttributes
    public static let largeTitleTextAttributes = Theme.Attribute.init(rawValue: "largeTitleTextAttributes")
    /// UINavigationBar.backIndicatorImage
    public static let backIndicatorImage = Theme.Attribute.init(rawValue: "backIndicatorImage")
    /// UINavigationBar.backIndicatorTransitionMaskImage
    public static let backIndicatorTransitionMaskImage = Theme.Attribute.init(rawValue: "backIndicatorTransitionMaskImage")
    /// UINavigationBar.prefersLargeTitles
    public static let prefersLargeTitles = Theme.Attribute.init(rawValue: "prefersLargeTitles")
    /// UINavigationBar
    public static let titleVerticalPositionAdjustment = Theme.Attribute.init("titleVerticalPositionAdjustment")
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
        
        for item in Theme.State.UIBarMetricsItems {
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: item.themeState) else { continue }
            if themeStyle.containsThemeAttribute(.titleVerticalPositionAdjustment) {
                self.setTitleVerticalPositionAdjustment(themeStyle.titleVerticalPositionAdjustment, for: item.barMetrics)
            }
            if themeStyle.containsThemeAttribute(.backgroundImage) {
                self.setBackgroundImage(themeStyle.backgroundImage, for: item.barMetrics)
            }
        }
        
        for item in Theme.State.UIBarPositionUIBarMetricsItems {
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: item.themeState) else { continue }
            if themeStyle.containsThemeAttribute(.backgroundImage) {
                self.setBackgroundImage(themeStyle.backgroundImage, for: item.barPosition, barMetrics: item.barMetrics)
            }
        }
    }
    
}
