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
    public static let selectedImage = Theme.Attribute.init(rawValue: "selectedImage")
    /// UITabBarItem.titleTextAttributes
    public static let titleTextAttributes = Theme.Attribute.init(rawValue: "titleTextAttributes")
    /// UITabBarItem.landscapeImagePhone
    public static let landscapeImagePhone = Theme.Attribute.init(rawValue: "landscapeImagePhone")
    /// UITabBarItem.largeContentSizeImage
    public static let largeContentSizeImage = Theme.Attribute.init(rawValue: "largeContentSizeImage")
    /// UITabBarItem
    public static let badgeTextAttributes = Theme.Attribute.init(rawValue: "badgeTextAttributes")
}

extension Theme.Style {
    
    public var selectedImage: UIImage? {
        get { return image(for: .selectedImage) }
        set { setValue(newValue, for: .selectedImage)}
    }
    
    public var titleTextAttributes: [NSAttributedString.Key : Any]? {
        get { return stringAttributes(for: .titleTextAttributes) }
        set { setValue(newValue, for: .titleTextAttributes) }
    }
    
    public var landscapeImagePhone: UIImage? {
        get { return image(for: .landscapeImagePhone) }
        set { setValue(newValue, for: .landscapeImagePhone)}
    }
    
    
    public var largeContentSizeImage: UIImage? {
        get { return image(for: .largeContentSizeImage) }
        set { setValue(newValue, for: .largeContentSizeImage)}
    }
    
    public var badgeTextAttributes: [NSAttributedString.Key: Any]? {
        get { return stringAttributes(for: .badgeTextAttributes) }
        set { setValue(newValue, for: .badgeTextAttributes) }
    }
}

extension UITabBarItem {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        if themeStyles.contains(.selectedImage) {
            self.selectedImage = themeStyles.selectedImage
        }
        
        if themeStyles.contains(.image) {
            self.image = themeStyles.image
        }
        
        if themeStyles.contains(.title) {
            self.title = themeStyles.title
        }
        
        if themeStyles.contains(.landscapeImagePhone) {
            self.landscapeImagePhone = themeStyles.landscapeImagePhone
        }
        
        if #available(iOS 11.0, *) {
            if themeStyles.contains(.largeContentSizeImage) {
                self.largeContentSizeImage = themeStyles.largeContentSizeImage
            }
        }
        
        guard let themeStates = themeStyles.statedThemeStylesIfLoaded?.keys else { return }
        for themeState in themeStates {
            guard let controlState = UIControl.State.init(themeState) else {
                XZLog("Unapplied Theme.State %@ for UISegmentedControl.", themeState)
                continue
            }
            guard let themeStyle = themeStyles.themeStyleIfLoaded(for: themeState) else { continue }
            if themeStyles.contains(.titleTextAttributes) {
                self.setTitleTextAttributes(themeStyles.titleTextAttributes, for: controlState)
            }
            
            if #available(iOS 10.0, *) {
                if themeStyle.contains(.badgeTextAttributes) {
                    setBadgeTextAttributes(themeStyle.badgeTextAttributes, for: controlState)
                }
            }
        }
        
    }
    
}

