//
//  Theme+UITabBarItem.swift
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit
import XZKit

extension Theme.Attribute {
    
    /// UITabBarItem.selectedImage
    public static let selectedImage = Theme.Attribute.init("selectedImage")
    /// UITabBarItem.titleTextAttributes
    public static let titleTextAttributes = Theme.Attribute.init("titleTextAttributes")
    /// UITabBarItem.landscapeImagePhone
    public static let landscapeImagePhone = Theme.Attribute.init("landscapeImagePhone")
    /// UITabBarItem.largeContentSizeImage
    public static let largeContentSizeImage = Theme.Attribute.init("largeContentSizeImage")
    /// UITabBarItem
    public static let badgeTextAttributes = Theme.Attribute.init("badgeTextAttributes")
}

extension Theme.Style {
    
    public var selectedImage: UIImage? {
        get { return image(forThemeAttribute: .selectedImage) }
        set { setValue(newValue, forThemeAttribute: .selectedImage)}
    }
    
    public var titleTextAttributes: [NSAttributedStringKey : Any]? {
        get { return stringAttributes(forThemeAttribute: .titleTextAttributes) }
        set { setValue(newValue, forThemeAttribute: .titleTextAttributes) }
    }
    
    public var landscapeImagePhone: UIImage? {
        get { return image(forThemeAttribute: .landscapeImagePhone) }
        set { setValue(newValue, forThemeAttribute: .landscapeImagePhone)}
    }
    
    
    public var largeContentSizeImage: UIImage? {
        get { return image(forThemeAttribute: .largeContentSizeImage) }
        set { setValue(newValue, forThemeAttribute: .largeContentSizeImage)}
    }
    
    public var badgeTextAttributes: [String: Any]? {
        get { return stringAttributes(forThemeAttribute: .badgeTextAttributes) }
        set { setValue(newValue, forThemeAttribute: .badgeTextAttributes) }
    }
}

extension UITabBarItem {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.containsThemeAttribute(.selectedImage) {
            self.selectedImage = themeStyles.selectedImage
        }
        
        if themeStyles.containsThemeAttribute(.image) {
            self.image = themeStyles.image
        }
        
        if themeStyles.containsThemeAttribute(.title) {
            self.title = themeStyles.title
        }
        
        if themeStyles.containsThemeAttribute(.landscapeImagePhone) {
            self.landscapeImagePhone = themeStyles.landscapeImagePhone
        }
        
        if #available(iOS 11.0, *) {
            if themeStyles.containsThemeAttribute(.largeContentSizeImage) {
                self.largeContentSizeImage = themeStyles.largeContentSizeImage
            }
        }
        
        for themeState in themeStyles.effectiveThemeStates {
            guard let controlState = UIControlState.init(themeState) else {
                XZLog("Unapplied Theme.State %@ for UISegmentedControl.", themeState)
                continue
            }
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: themeState) else { continue }
            if themeStyles.containsThemeAttribute(.titleTextAttributes) {
                self.setTitleTextAttributes(themeStyles.titleTextAttributes, for: controlState)
            }
            
            if #available(iOS 10.0, *) {
                if themeStyle.containsThemeAttribute(.badgeTextAttributes) {
                    setBadgeTextAttributes(themeStyle.badgeTextAttributes, for: controlState)
                }
            }
        }
        
    }
    
}
