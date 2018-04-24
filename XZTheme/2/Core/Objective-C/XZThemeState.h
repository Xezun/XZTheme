//
//  XZThemeState.h
//  XZTheme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 主题样式属性状态。
/// @note 自定义属性状态，请以 : 开头。
typedef NSString * XZThemeState NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(Theme.State);

UIKIT_EXTERN XZThemeState const _Nonnull XZThemeStateNormal;
UIKIT_EXTERN XZThemeState const _Nonnull XZThemeStateSelected;
UIKIT_EXTERN XZThemeState const _Nonnull XZThemeStateHighlighted;
UIKIT_EXTERN XZThemeState const _Nonnull XZThemeStateDisabled;
UIKIT_EXTERN XZThemeState const _Nonnull XZThemeStateFocused;
