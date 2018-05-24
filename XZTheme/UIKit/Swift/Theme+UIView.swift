//
//  Theme+UIView.swift
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

import UIKit

extension Theme.Attribute {
    
    /// UIView.tintColor
    public static let tintColor         = Theme.Attribute.init("tintColor");
    /// UIView.isHidden
    public static let isHidden          = Theme.Attribute.init("isHidden");
    /// UIView.backgroundColor
    public static let backgroundColor   = Theme.Attribute.init("backgroundColor");
    /// UIView.alpha
    public static let alpha             = Theme.Attribute.init("alpha");
    /// UIView.isOpaque
    public static let isOpaque          = Theme.Attribute.init("isOpaque");
    /// UIView.brightness
    public static let brightness        = Theme.Attribute.init("brightness");
}

extension Theme.Style {
    
    public var backgroundColor: UIColor? {
        get { return color(forThemeAttribute: .backgroundColor)        }
        set { setValue(newValue, forThemeAttribute: .backgroundColor)  }
    }
    
    public var tintColor: UIColor? {
        get { return color(forThemeAttribute: .tintColor)       }
        set { setValue(newValue, forThemeAttribute: .tintColor) }
    }
    
    public var isHidden: Bool {
        get { return boolValue(forThemeAttribute: .isHidden)       }
        set { setValue(newValue, forThemeAttribute: .isHidden) }
    }
    
    public var isOpaque: Bool {
        get { return boolValue(forThemeAttribute: .isOpaque)   }
        set { setValue(newValue, forThemeAttribute: .isOpaque) }
    }
    
    public var alpha: CGFloat {
        get { return CGFloat(doubleValue(forThemeAttribute: .alpha)) }
        set { setValue(newValue, forThemeAttribute: .alpha)          }
    }
    
    public var brightness: CGFloat {
        get { return CGFloat(doubleValue(forThemeAttribute: .brightness)) }
        set { setValue(newValue, forThemeAttribute: .brightness)          }
    }
    
}

extension UIView {
    
    /// 作为 UIView 控件，当主题改变时，其会自动应用如下属性：
    ///
    /// **UIView:** *backgroundColor, tintColor, isHidden, alpha, isOpaque, brightness.*
    ///
    /// **UIImageView:** *image, highlightedImage, animationImages, highlightedAnimationImages, isHighlighted, isAnimating, placeholder.*
    ///
    /// **UIButton:** *title, titleColor, titleShadowColor, image, backgroundImage, attributedTitle.*
    ///
    /// **UILabel:** *text, textColor, font, shadowColor, highlightedTextColor, attributedText.*
    ///
    /// **UINavigationBar:** *prefersLargeTitles, barTintColor, shadowImage, barStyle, isTranslucent, titleTextAttributes, backIndicatorImage, backIndicatorTransitionMaskImage.*
    ///
    /// **UINavigationItem:** *title, hidesBackButton, prompt, leftItemsSupplementBackButton, largeTitleDisplayMode, hidesSearchBarWhenScrolling.*
    ///
    /// **UIRefreshControl:** *attributedTitle.*
    ///
    /// **UIScrollView:** *indicatorStyle.*
    ///
    /// **UITabBar:** *barTintColor, shadowImage, backgroundImage, selectionIndicatorImage, barStyle, isTranslucent, unselectedItemTintColor.*
    ///
    /// **UITabBarItem:** *selectedImage, image, title, landscapeImagePhone, largeContentSizeImage, titleTextAttributes.*
    ///
    /// **UITableView:** *sectionIndexColor, sectionIndexBackgroundColor, sectionIndexTrackingBackgroundColor, separatorStyle, separatorColor.*
    ///
    /// **<#View#>:** *<#Properties#>.*
    ///
    /// **<#View#>:** *<#Properties#>.*
    ///
    /// **<#View#>:** *<#Properties#>.*
    ///
    /// **<#View#>:** *<#Properties#>.*
    ///
    /// - Parameter themeStyles: 主题样式。
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        // 遍历配置，就会导致子类父类多次遍历。
        // 但是检测是否存在（判断字典是否存在键）属性再赋值，能否效率更高，有待验证。
        
        if themeStyles.containsThemeAttribute(.backgroundColor) {
            self.backgroundColor = themeStyles.backgroundColor
        }
        
        if themeStyles.containsThemeAttribute(.tintColor) {
            self.tintColor = themeStyles.tintColor
        }
        
        if themeStyles.containsThemeAttribute(.isHidden) {
            self.isHidden = themeStyles.isHidden
        }
        
        if themeStyles.containsThemeAttribute(.alpha) {
            self.alpha = themeStyles.alpha
        }
        
        if themeStyles.containsThemeAttribute(.isOpaque) {
            self.isOpaque = themeStyles.isOpaque
        }
        
        if themeStyles.containsThemeAttribute(.brightness) {
            self.brightness = themeStyles.brightness
        }
    }
    
}
