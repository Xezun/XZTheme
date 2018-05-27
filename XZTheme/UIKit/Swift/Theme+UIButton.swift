//
//  Theme+UIButton.swift
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

extension Theme.State {
    
    /// Theme.State 对 UIControlState 的对应关系。
    public static let UIControlStateItems: [(themeState: Theme.State, controlState: UIControlState)] = {
        if #available(iOS 9.0, *) {
            return [(.normal, .normal), (.selected, .selected), (.highlighted, .highlighted), (.disabled, .disabled), (.focused, .focused)]
        } else {
            return [(.normal, .normal), (.selected, .selected), (.highlighted, .highlighted), (.disabled, .disabled)]
        }
    }()
    
}

extension Theme.Attribute {
    
    /// UIButton.setTitle
    public static let title             = Theme.Attribute.init("title");
    /// UIButton.setTitleColor
    public static let titleColor        = Theme.Attribute.init("titleColor");
    /// UIButton, UITabBar, UISearchBar, UINavigationBar
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
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)

        for item in Theme.State.UIControlStateItems {
            guard let themeStyle = themeStyles.effectiveThemeStyle(forThemeState: item.themeState) else { continue }

            if themeStyle.containsThemeAttribute(.title) {
                self.setTitle(themeStyle.title, for: item.controlState);
            }
            if themeStyle.containsThemeAttribute(.titleColor) {
                self.setTitleColor(themeStyle.titleColor, for: item.controlState);
            }
            if themeStyle.containsThemeAttribute(.titleShadowColor) {
                self.setTitleShadowColor(themeStyle.titleShadowColor, for: item.controlState);
            }
            if themeStyle.containsThemeAttribute(.image) {
                self.setImage(themeStyle.image, for: item.controlState);
            }
            if themeStyle.containsThemeAttribute(.backgroundImage) {
                self.setBackgroundImage(themeStyle.backgroundImage, for: item.controlState);
            }
            if themeStyle.containsThemeAttribute(.attributedTitle) {
                self.setAttributedTitle(themeStyle.attributedTitle, for: item.controlState);
            }
        }
        
        
        
    }
}
