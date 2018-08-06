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
    public static let tintColor         = Theme.Attribute.init(rawValue: "tintColor");
    /// UIView.isHidden
    public static let isHidden          = Theme.Attribute.init(rawValue: "isHidden");
    /// UIView.backgroundColor, UITableViewCell.backgroundView.backgroundColor
    public static let backgroundColor   = Theme.Attribute.init(rawValue: "backgroundColor");
    /// UIView.alpha
    public static let alpha             = Theme.Attribute.init(rawValue: "alpha");
    /// UIView.isOpaque
    public static let isOpaque          = Theme.Attribute.init(rawValue: "isOpaque");
    /// UIView.brightness
    public static let brightness        = Theme.Attribute.init(rawValue: "brightness");
}

extension Theme.Style {
    
    public var backgroundColor: UIColor? {
        get { return color(for: .backgroundColor)        }
        set { setValue(newValue, for: .backgroundColor)  }
    }
    
    public var tintColor: UIColor? {
        get { return color(for: .tintColor)       }
        set { setValue(newValue, for: .tintColor) }
    }
    
    public var isHidden: Bool {
        get { return boolValue(for: .isHidden)       }
        set { setValue(newValue, for: .isHidden) }
    }
    
    public var isOpaque: Bool {
        get { return boolValue(for: .isOpaque)   }
        set { setValue(newValue, for: .isOpaque) }
    }
    
    public var alpha: CGFloat {
        get { return CGFloat(doubleValue(for: .alpha)) }
        set { setValue(newValue, for: .alpha)          }
    }
    
    public var brightness: CGFloat {
        get { return CGFloat(doubleValue(for: .brightness)) }
        set { setValue(newValue, for: .brightness)          }
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
    /// **UIRefreshControl:** *attributedTitle, isRefreshing.*
    ///
    /// **UIScrollView:** *indicatorStyle.*
    ///
    /// **UITabBar:** *barTintColor, shadowImage, backgroundImage, selectionIndicatorImage, barStyle, isTranslucent, unselectedItemTintColor.*
    ///
    /// **UITabBarItem:** *selectedImage, image, title, landscapeImagePhone, largeContentSizeImage, titleTextAttributes.*
    ///
    /// **UITableView:** *sectionIndexColor, sectionIndexBackgroundColor, sectionIndexTrackingBackgroundColor, separatorStyle, separatorColor.*
    ///
    /// **UIActivityIndicatorView:** *activityIndicatorViewStyle, color, hidesWhenStopped, isAnimating.*
    ///
    /// **UIPageControl:** *numberOfPages, currentPage, hidesForSinglePage, defersCurrentPageDisplay, pageIndicatorTintColor, currentPageIndicatorTintColor.*
    ///
    /// **UIProgressView:** *progressViewStyle, progress, progressTintColor, trackTintColor, progressImage, trackImage.*
    ///
    /// **UISlider:** *isContinuous, minimumTrackTintColor, maximumTrackTintColor, thumbImage, minimumTrackImage, maximumTrackImage.*
    ///
    /// **UISearchBar:** *barStyle, text, prompt, placeholder, showsBookmarkButton, showsCancelButton, showsSearchResultsButton, isSearchResultsButtonSelected, barTintColor, searchBarStyle, isTranslucent, scopeButtonTitles, showsScopeBar, backgroundImage, scopeBarBackgroundImage, backgroundImage(for:barMetrics:), searchFieldBackgroundImage, scopeBarButtonBackgroundImage, scopeBarButtonTitleTextAttributes, image, scopeBarButtonDividerImage, searchFieldBackgroundPositionAdjustment, searchTextPositionAdjustment, positionAdjustment.*
    ///
    /// **UISwitch:** *onTintColor, thumbTintColor, onImage, offImage, isOn.*
    ///
    /// **UITextField:** *text, attributedText, textColor, font, textAlignment, borderStyle, defaultTextAttributes, placeholder, attributedPlaceholder, clearsOnBeginEditing, adjustsFontSizeToFitWidth, minimumFontSize, background, disabledBackground, allowsEditingTextAttributes, typingAttributes, clearButtonMode, leftViewMode, rightViewMode, clearsOnInsertion, keyboardAppearance, keyboardType, returnKeyType, enablesReturnKeyAutomatically, isSecureTextEntry.*
    ///
    /// **UITextView:** *text, font, textColor, textAlignment, isEditable, isSelectable, allowsEditingTextAttributes, attributedText, typingAttributes, clearsOnInsertion, linkTextAttributes, keyboardAppearance, keyboardType, returnKeyType, enablesReturnKeyAutomatically, isSecureTextEntry.*
    ///
    /// **UIToolbar:** *barStyle, isTranslucent, barTintColor, backgroundImage, shadowImage.*
    ///
    /// **UISegmentedControl:** *isMomentary, apportionsSegmentWidthsByContent, backgroundImage, dividerImage, titleTextAttributes, contentPositionAdjustment.*
    ///
    /// **UITableViewCell:** *selectionStyle, backgroundColor, contentBackgroundColor, selectedBackgroundColor, multipleSelectionBackgroundColor.*
    ///
    /// - Parameter themeStyles: 主题样式。
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
        // 遍历配置，就会导致子类父类多次遍历。
        // 但是检测是否存在（判断字典是否存在键）属性再赋值，能否效率更高，有待验证。
        
        if themeStyles.contains(.backgroundColor) {
            self.backgroundColor = themeStyles.backgroundColor
        }
        
        if themeStyles.contains(.tintColor) {
            self.tintColor = themeStyles.tintColor
        }
        
        if themeStyles.contains(.isHidden) {
            self.isHidden = themeStyles.isHidden
        }
        
        if themeStyles.contains(.alpha) {
            self.alpha = themeStyles.alpha
        }
        
        if themeStyles.contains(.isOpaque) {
            self.isOpaque = themeStyles.isOpaque
        }
        
        if themeStyles.contains(.brightness) {
            self.brightness = themeStyles.brightness
        }
    }
    
}
