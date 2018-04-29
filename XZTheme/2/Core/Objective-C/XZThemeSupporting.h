//
//  NSObject.h
//  Example
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZThemeDefines.h"

@class XZTheme, XZThemeCollection, XZThemeStyleCollection, XZThemeStyle;

/// 本协议描述了支持主题功能的对象具有的属性和方法。
@protocol XZThemeSupporting <NSObject>
/// 是否传递主题变更事件。
- (BOOL)xz_forwardsThemeAppearanceUpdate NS_SWIFT_NAME(forwardsThemeAppearanceUpdate());
/// 将主题标记为需要更新。
- (void)xz_setNeedsThemeAppearanceUpdate NS_SWIFT_NAME(setNeedsThemeAppearanceUpdate());
/// 如果已被标记为需要更新主题，调用此方法立即更新主题。
- (void)xz_updateThemeAppearanceIfNeeded NS_SWIFT_NAME(updateThemeAppearanceIfNeeded());
/// 当需要应用主题时，此方法会被调用。
///
/// @param newTheme 待应用的主题。
- (void)xz_updateAppearanceWithTheme:(nonnull XZTheme *)newTheme NS_SWIFT_NAME(updateAppearance(with:));
/// 应用主题时，如果主题已配置了主题样式，则此方法会被调用。
///
/// @param themeStyles 主题样式。
- (void)xz_updateAppearanceWithThemeStyles:(nonnull XZThemeStyleCollection *)themeStyles NS_SWIFT_NAME(updateAppearance(with:));
@end





