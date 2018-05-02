//
//  XZThemeDefines.h
//  Example
//
//  Created by mlibai on 2018/4/26.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 不允许继承类声明。
#define XZ_THEME_FINAL_CLASS __attribute__((objc_subclassing_restricted))

/// 主题样式属性。
/// @note 主题样式属性一般情况下与对象的外观属性相对应。
/// @note 主题样式属性名应该符合正则 /^[A-Za-z_][A-Za-z0-9_]+$/ 。
//typedef NSString * XZThemeAttribute NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(Theme.Attribute);


///// 主题样式属性状态。
///// @note 主题状态一般情况下与触控状态相对应。
///// @note 主题状态名应该符合正则 /^\:[A-Za-z]+$/ 。
//typedef NSString * XZThemeState NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(Theme.State);
//
//
///// 普通主题状态，主题的默认状态，与 UIControlStateNormal 对应。
//UIKIT_EXTERN XZThemeState const _Nonnull XZThemeStateNormal;
///// 一般表示被选中时的主题状态，与 UIControlStateSelected 对应。
//UIKIT_EXTERN XZThemeState const _Nonnull XZThemeStateSelected;
///// 一般表示高亮时的主题状态，与 UIControlStateHighlighted 对应。
//UIKIT_EXTERN XZThemeState const _Nonnull XZThemeStateHighlighted;
///// 一般表示高被禁用的主题状态，与 UIControlStateDisabled 对应。
//UIKIT_EXTERN XZThemeState const _Nonnull XZThemeStateDisabled;
///// 一般表示处于焦点时的主题状态，与 UIControlStateFocused 对应，iOS 9.0 之前与 UIControlStateReserved 对应。
//UIKIT_EXTERN XZThemeState const _Nonnull XZThemeStateFocused;

/// 除 normal、highlighted、selected、disabled、focused 的状态将返回 UIControlStateReserved 。
/// @note 自定义状态。
///
/// @param themeState 主题状态。
/// @return 触控状态。
//UIKIT_EXTERN UIControlState UIControlStateFromXZThemeState(XZThemeState _Nonnull themeState) NS_SWIFT_UNAVAILABLE("User UIControlState.init(_:) method instead.");
