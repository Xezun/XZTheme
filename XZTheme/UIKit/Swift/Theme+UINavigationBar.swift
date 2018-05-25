//
//  Theme+UINavigationBar.swift
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

extension Theme.State {
    
    /// UIBarPosition.any
    /// UIBarPosition.bottom
    /// UIBarPosition.top
    /// UIBarPosition.topAttached
    
    /// UIBarMetrics.default
    public static let defaultBarMetrics       = Theme.State.init(":defaultBarMetrics")
    /// UIBarMetrics.compact
    public static let compactBarMetrics       = Theme.State.init(":compactBarMetrics")
    /// UIBarMetrics.defaultPrompt
    public static let defaultPromptBarMetrics = Theme.State.init(":defaultPromptBarMetrics")
    /// UIBarMetrics.compactPrompt
    public static let compactPromptBarMetrics = Theme.State.init(":compactPromptBarMetrics")
    
    /// 如果包含 UIBarMetrics 则返回，集合可能为空。
    public var barMetrics: [UIBarMetrics] {
        var barMetrics = [UIBarMetrics]()
        if self.contains(.defaultBarMetrics) {
            barMetrics.append(.default)
        }
        if self.contains(.compactBarMetrics) {
            barMetrics.append(.compact)
        }
        if self.contains(.defaultPromptBarMetrics) {
            barMetrics.append(.defaultPrompt)
        }
        if self.contains(.compactPromptBarMetrics) {
            barMetrics.append(.compactPrompt)
        }
        return barMetrics
    }
    
    /// UIBarPosition.any
    public static let anyBarPosition         = Theme.State.init(":anyBarPosition")
    /// UIBarPosition.bottom
    public static let bottomBarPosition      = Theme.State.init(":bottomBarPosition")
    /// UIBarPosition.top
    public static let topBarPosition         = Theme.State.init(":topBarPosition")
    /// UIBarPosition.topAttached
    public static let topAttachedBarPosition = Theme.State.init(":topAttachedBarPosition")
    
    /// 如果包含 UIBarPosition 则返回，集合可能为空。
    public var barPositions: [UIBarPosition] {
        var barPositions = [UIBarPosition]()
        if self.contains(.anyBarPosition) {
            barPositions.append(UIBarPosition.any)
        }
        if self.contains(.bottomBarPosition) {
            barPositions.append(UIBarPosition.bottom)
        }
        if self.contains(.topBarPosition) {
            barPositions.append(UIBarPosition.top)
        }
        if self.contains(.topAttachedBarPosition) {
            barPositions.append(UIBarPosition.topAttached)
        }
        return barPositions
    }
    
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
}


extension UINavigationBar {
    
    open override var forwardsThemeAppearanceUpdate: Bool {
        return false
    }
 
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
        
//        self.themes.themeStyles(forTheme: Theme.init(name: "day")).themeStyle(forThemeState: .defaultBarMetrics(forBarPosition: .any)).backgroundColor;
        
        if let statedThemeStyles = themeStyles.statedThemeStylesIfLoaded {
            for item in statedThemeStyles {
                let barMet = item.key.barMetrics
                let position = item.key.barPositions
            }
        }
        
    }
    
}
