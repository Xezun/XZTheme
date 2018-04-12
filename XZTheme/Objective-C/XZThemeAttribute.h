//
//  XZThemeAttribute.h
//  XZKit
//
//  Created by mlibai on 2017/10/14.
//

#import <UIKit/UIKit.h>

#ifdef XZKIT_FRAMEWORK
#import <XZKit/XZThemeDefines.h>
#else
#import "XZThemeDefines.h"
#endif



// MARK: UIView
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeTintColor;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeIsHidden;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeBackgroundColor;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeAlpha;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeIsOpaque;


// MARK: UIImageView
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeImage;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeHighlightedImage;

UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeImages;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeAnimationImages;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeHighlightedAnimationImages;

UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeIsAnimating;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeIsHighlighted;


// MARK: UIButton
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeTitle;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeTitleColor;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeBackgroundImage;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeTitleShadowColor;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeAttributedTitle;



// MARK: UILabel
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeText;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeTextColor;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeFont;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeShadowColor;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeHighlightedTextColor;



// MARK: UITabBar
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeBarTintColor;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeShadowImage;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeUnselectedItemTintColor;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeSelectionIndicatorImage;



// MARK: UITabBarItem
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeSelectedImage;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeTitleTextAttributes;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeLandscapeImagePhone;
UIKIT_EXTERN XZThemeAttribute const _Nonnull XZThemeAttributeLargeContentSizeImage;






