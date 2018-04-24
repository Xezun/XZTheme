//
//  XZThemeAttribute.h
//  XZTheme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 主题样式属性。
/// @note 主题样式属性正则 /^[A-Za-z_][A-Za-z0-9_]+$/ 。
typedef NSString * XZThemeAttribute NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(Theme.Attribute);


// MARK: UIView

/// UIView.tintColor
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeTintColor;
/// UIView.isHidden
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeIsHidden;
/// UIView.backgroundColor
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeBackgroundColor;
/// UIView.alpha
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeAlpha;
/// UIView.isOpaque
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeIsOpaque;


// MARK: UIImageView

/// UIImageView.image
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeImage;
/// UIImageView.highlightedImage
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeHighlightedImage;
/// UIImageView.images
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeImages;
/// UIImageView.animationImages
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeAnimationImages;
/// UIImageView.highlightedAnimationImages
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeHighlightedAnimationImages;
/// UIImageView.isAnimating
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeIsAnimating;
/// UIImageView.isHighlighted
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeIsHighlighted;


// MARK: UIButton

/// UIButton.setTitle
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeTitle;
/// UIButton.setTitleColor
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeTitleColor;
/// UIButton.setBackgroundImage
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeBackgroundImage;
/// UIButton.setTitleShadowColor
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeTitleShadowColor;
/// UIButton.setAttributedTitle
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeAttributedTitle;


// MARK: UILabel

/// UILabel.text
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeText;
/// UILabel.textColor
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeTextColor;
/// UILabel.font
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeFont;
/// UILabel.shadowColor
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeShadowColor;
/// UILabel.highlightedTextColor
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeHighlightedTextColor;


// MARK: UITabBar

/// UITabBar.barTintColor
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeBarTintColor;
/// UITabBar.shadowImage
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeShadowImage;
/// UITabBar.unselectedItemTintColor
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeUnselectedItemTintColor;
/// UITabBar.selectionIndicatorImage
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeSelectionIndicatorImage;


// MARK: UITabBarItem

/// UITabBarItem.selectedImage
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeSelectedImage;
/// UITabBarItem.titleTextAttributes
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeTitleTextAttributes;
/// UITabBarItem.landscapeImagePhone
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeLandscapeImagePhone;
/// UITabBarItem.largeContentSizeImage
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeLargeContentSizeImage;











