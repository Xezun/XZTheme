//
//  Theme+UINavigationBar.swift
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

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
        
    }
    
}
