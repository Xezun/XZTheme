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
        get { return stringValue(for: .title)  }
        set { setValue(newValue, for: .title)  }
    }
    
    public var titleColor: UIColor? {
        get { return color(for: .titleColor)       }
        set { setValue(newValue, for: .titleColor) }
    }

    public var backgroundImage: UIImage? {
        get { return image(for: .backgroundImage)  }
        set { setValue(newValue, for: .backgroundImage)  }
    }
    
    public var titleShadowColor: UIColor? {
        get { return color(for: .titleShadowColor)       }
        set { setValue(newValue, for: .titleShadowColor) }
    }
    
    public var attributedTitle: NSAttributedString? {
        get { return attributedString(for: .attributedTitle)  }
        set { setValue(newValue, for: .attributedTitle)       }
    }
    
    
}

import XZKit


extension UIButton {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)

        guard let themeStates = themeStyles.statedThemeStylesIfLoaded?.keys else { return }
        for themeState in themeStates {
            guard let controlState = UIControl.State.init(themeState) else {
                XZLog("Unapplied Theme.State %@ for UIButton.", themeState)
                continue
            }
            guard let themeStyle = themeStyles.themeStyleIfLoaded(for: themeState) else {
                continue
            }
            
            if themeStyle.contains(.title) {
                self.setTitle(themeStyle.title, for: controlState);
            }
            if themeStyle.contains(.titleColor) {
                self.setTitleColor(themeStyle.titleColor, for: controlState);
            }
            if themeStyle.contains(.titleShadowColor) {
                self.setTitleShadowColor(themeStyle.titleShadowColor, for: controlState);
            }
            if themeStyle.contains(.image) {
                self.setImage(themeStyle.image, for: controlState);
            }
            if themeStyle.contains(.backgroundImage) {
                self.setBackgroundImage(themeStyle.backgroundImage, for: controlState);
            }
            if themeStyle.contains(.attributedTitle) {
                self.setAttributedTitle(themeStyle.attributedTitle, for: controlState);
            }
        }
        
    }
}
