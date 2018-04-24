//
//  XZThemeStyle.h
//  XZTheme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZThemeAttribute.h"
#import "XZThemeState.h"

NS_SWIFT_NAME(Theme.Attributes) @interface XZThemeStyle : NSObject

@property (nonatomic, copy, readonly, nonnull) NSArray<XZThemeAttribute> *themeAttributes;

- (void)setValue:(nullable id)value forThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;
- (nullable id)valueForThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;

@end

NS_SWIFT_NAME(Theme.Style) @interface XZThemeStyles : XZThemeStyle

/// 所有状态，至少有一个状态 Normal 。
@property (nonatomic, copy, readonly, nonnull) NSArray<XZThemeState> *themeStates;

/// 获取指定状态下的样式属性配置。
- (nullable XZThemeStyle *)themeAttributesForState:(nonnull XZThemeState)state;

/// 添加多状态样式，状态 XZThemeStateNormal 的样式无需添加。
///
/// @param themeAttributes 待添加的样式。
/// @param state 待添加的样式状态。
- (void)setThemeAttributes:(nullable XZThemeStyle *)themeAttributes forState:(nonnull XZThemeState)state;

@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *normal;

@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *highlighted;
@property (nonatomic, strong, readonly, nullable) XZThemeStyle *highlightedIfLoaded;
@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *selected;
@property (nonatomic, strong, readonly, nullable) XZThemeStyle *selectedIfLoaded;
@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *disabled;
@property (nonatomic, strong, readonly, nullable) XZThemeStyle *disabledIfLoaded;
@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *focused;
@property (nonatomic, strong, readonly, nullable) XZThemeStyle *focusedIfLoaded;

@end


@interface XZThemeStyle (XZExtendedThemeAttributes)

// MARK: - UIView

@property (nonatomic, strong) UIColor * _Nullable backgroundColor;
@property (nonatomic, strong) UIColor * _Nullable tintColor;
@property (nonatomic) BOOL isHidden;
@property (nonatomic) CGFloat alpha;
@property (nonatomic) BOOL isOpaque;

// MARK: - UILabel

@property (nonatomic, copy) NSString * _Nullable text;
@property (nonatomic, strong) UIColor * _Nullable textColor;
@property (nonatomic, strong) UIFont * _Nullable font;
@property (nonatomic, strong) UIColor * _Nullable shadowColor;
@property (nonatomic, strong) UIColor * _Nullable highlightedTextColor;

// MARK: - UIButton

@property (nonatomic, copy) NSString * _Nullable title;
@property (nonatomic, strong) UIColor * _Nullable titleColor;
@property (nonatomic, strong) UIImage * _Nullable backgroundImage;
@property (nonatomic, strong) UIColor * _Nullable titleShadowColor;
@property (nonatomic, strong) NSAttributedString * _Nullable attributedTitle;

// MARK: - UIImageView

@property (nonatomic, strong) UIImage * _Nullable image;
@property (nonatomic, strong) UIImage * _Nullable highlightedImage;
@property (nonatomic, copy) NSArray<UIImage *> * _Nullable animationImages;
@property (nonatomic, copy) NSArray<UIImage *> * _Nullable highlightedAnimationImages;
@property (nonatomic) BOOL isAnimating;
@property (nonatomic) BOOL isHighlighted;

// MARK: - UITabBar

@property (nonatomic, strong) UIColor * _Nullable barTintColor;
@property (nonatomic, strong) UIImage * _Nullable shadowImage;
@property (nonatomic, strong) UIColor * _Nullable unselectedItemTintColor;
@property (nonatomic, strong) UIImage * _Nullable selectionIndicatorImage;

// MARK: - UITabBarItem

@property (nonatomic, strong) UIImage * _Nullable selectedImage;
@property (nonatomic, copy) NSDictionary<NSAttributedStringKey, id> * _Nullable titleTextAttributes;
@property (nonatomic, strong) UIImage * _Nullable landscapeImagePhone;
@property (nonatomic, strong) UIImage * _Nullable largeContentSizeImage;

@end
