//
//  XZTheme+UIButton.swift
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit


extension Theme.Attribute {
    
    /// UIButton.setTitle
    public static let title             = Theme.Attribute.init("title");
    /// UIButton.setTitleColor
    public static let titleColor        = Theme.Attribute.init("titleColor");
    /// - UIButton.setBackgroundImage
    /// - UITabBar.backgroundImage
    public static let backgroundImage   = Theme.Attribute.init("backgroundImage");
    /// UIButton.setTitleShadowColor
    public static let titleShadowColor  = Theme.Attribute.init("titleShadowColor");
    /// UIButton.setAttributedTitle
    public static let attributedTitle   = Theme.Attribute.init("attributedTitle");
    
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

extension UIButton {
    
    open override var forwardsThemeAppearanceUpdate: Bool {
        return false
    }
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)

        for themeState in themeStyles.themeStates {
            guard let controlState = UIControlState(themeState) else { continue }
            let themeStyle = themeStyles.themeStyle(forThemeState: themeState)
            
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
