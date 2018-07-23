//
//  Theme+UIButton.swift
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

extension Theme.Attribute {
    
    /// UIButton.setTitle
    public static let title             = Theme.Attribute.init(rawValue: "title");
    /// UIButton.setTitleColor
    public static let titleColor        = Theme.Attribute.init(rawValue: "titleColor");
    /// UIButton, UITabBar, UISearchBar, UINavigationBar
    public static let backgroundImage   = Theme.Attribute.init(rawValue: "backgroundImage");
    /// UIButton.setTitleShadowColor
    public static let titleShadowColor  = Theme.Attribute.init(rawValue: "titleShadowColor");
    /// UIButton.setAttributedTitle
    public static let attributedTitle   = Theme.Attribute.init(rawValue: "attributedTitle");
    
}

extension Theme.Style {
    
    public var title: String? {
        get { return stringValue(forThemeAttribute: .title)  }
        set { setValue(newValue, forThemeAttribute: .title)  }
    }
    
    public var titleColor: UIColor? {
        get { return color(forThemeAttribute: .titleColor)       }
        set { setValue(newValue, forThemeAttribute: .titleColor) }
    }

    public var backgroundImage: UIImage? {
        get { return image(forThemeAttribute: .backgroundImage)  }
        set { setValue(newValue, forThemeAttribute: .backgroundImage)  }
    }
    
    public var titleShadowColor: UIColor? {
        get { return color(forThemeAttribute: .titleShadowColor)       }
        set { setValue(newValue, forThemeAttribute: .titleShadowColor) }
    }
    
    public var attributedTitle: NSAttributedString? {
        get { return attributedString(forThemeAttribute: .attributedTitle)  }
        set { setValue(newValue, forThemeAttribute: .attributedTitle)       }
    }
    
    
}

import XZKit

extension UIButton {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)

        for themeState in themeStyles.effectiveThemeStates + [.normal] {
            guard let controlState = UIControlState.init(themeState) else {
                XZLog("Unapplied Theme.State %@ for UIButton.", themeState)
                continue
            }
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: themeState) else { continue }
            
            if themeStyle.containsThemeAttribute(.title) {
                self.setTitle(themeStyle.title, for: controlState);
            }
            if themeStyle.containsThemeAttribute(.titleColor) {
                self.setTitleColor(themeStyle.titleColor, for: controlState);
            }
            if themeStyle.containsThemeAttribute(.titleShadowColor) {
                self.setTitleShadowColor(themeStyle.titleShadowColor, for: controlState);
            }
            if themeStyle.containsThemeAttribute(.image) {
                self.setImage(themeStyle.image, for: controlState);
            }
            if themeStyle.containsThemeAttribute(.backgroundImage) {
                self.setBackgroundImage(themeStyle.backgroundImage, for: controlState);
            }
            if themeStyle.containsThemeAttribute(.attributedTitle) {
                self.setAttributedTitle(themeStyle.attributedTitle, for: controlState);
            }
        }
        
    }
}
