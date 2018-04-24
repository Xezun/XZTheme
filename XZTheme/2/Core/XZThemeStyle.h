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

/// 主题样式，存储了对象主题属性相关配置。
NS_SWIFT_NAME(Theme.Attributes) @interface XZThemeStyle : NSObject

/// 主题样式中的所有已设置值的主题属性。
@property (nonatomic, copy, readonly, nonnull) NSArray<XZThemeAttribute> *themeAttributes;

/// 设置主题属性值。
/// @note 使用 [NSNull null] 表示需要设置 nil 的主题属性。
///
/// @param value 主题属性值。
/// @param themeAttribute 主题属性。
- (void)setValue:(nullable id)value forThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;
- (nullable id)valueForThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;

@end

NS_SWIFT_NAME(Theme.Style) @interface XZThemeStyles : XZThemeStyle

/// 所有状态，至少有一个状态 Normal 。
@property (nonatomic, copy, readonly, nonnull) NSArray<XZThemeState> *themeStates;

/// 获取指定状态下的样式属性配置。
///
/// @param themeState 主题状态。
/// @return 主题样式。
- (nullable XZThemeStyle *)themeStyleForThemeState:(nonnull XZThemeState)themeState;

/// 添加多状态样式，状态 XZThemeStateNormal 的样式无需添加。
///
/// @param themeStyle 待添加的样式。
/// @param themeState 待添加的样式状态。
- (void)setThemeStyle:(nullable XZThemeStyle *)themeStyle forThemeState:(nonnull XZThemeState)themeState;

@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *normal NS_SWIFT_NAME(normal);

@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *highlighted NS_SWIFT_NAME(highlighted);
@property (nonatomic, strong, readonly, nullable) XZThemeStyle *highlightedIfLoaded NS_SWIFT_NAME(highlightedIfLoaded);
@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *selected NS_SWIFT_NAME(selected);
@property (nonatomic, strong, readonly, nullable) XZThemeStyle *selectedIfLoaded NS_SWIFT_NAME(selectedIfLoaded);
@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *disabled NS_SWIFT_NAME(disabled);
@property (nonatomic, strong, readonly, nullable) XZThemeStyle *disabledIfLoaded NS_SWIFT_NAME(disabledIfLoaded);
@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *focused NS_SWIFT_NAME(focused);
@property (nonatomic, strong, readonly, nullable) XZThemeStyle *focusedIfLoaded NS_SWIFT_NAME(focusedIfLoaded);

@end


@interface XZThemeStyle (XZExtendedThemeStyle)

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
