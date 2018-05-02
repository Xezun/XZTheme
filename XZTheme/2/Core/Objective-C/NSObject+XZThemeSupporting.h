//
//  NSObject+XZThemeSupporting.h
//  Example
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Example-Swift.h"

@protocol XZThemeSupporting;
@class XZTheme, XZThemeCollection, XZThemeStyleCollection, XZThemeStyle;

/// 默认为 NSObject 提供了 XZThemeSupporting 支持。
@interface NSObject (XZThemeSupporting) <XZThemeSupporting>

/// 当前对象的所有主题集合，懒加载。
@property (nonatomic, strong, readonly, nonnull) XZThemeCollection *xz_themes NS_SWIFT_NAME(themes);

/// 当前对象的所有主题，如果已加载。
@property (nonatomic, strong, readonly, nullable) XZThemeCollection *xz_themesIfLoaded NS_SWIFT_NAME(themesIfLoaded);

/// 当前已应用的主题。
/// @note 已应用的主题不等于当前主题，特别是当控件未显示时。
/// @note 如果为对象配置当前主题的主题样式，那么使用的是默认主题的主题样式。
@property (nonatomic, copy, readonly, nullable) XZTheme *xz_appliedTheme NS_SWIFT_NAME(appliedTheme);

- (BOOL)xz_forwardsThemeAppearanceUpdate NS_SWIFT_NAME(forwardsThemeAppearanceUpdate());
- (BOOL)xz_needsThemeAppearanceUpdate NS_SWIFT_NAME(needsThemeAppearanceUpdate());
- (void)xz_setNeedsThemeAppearanceUpdate NS_REQUIRES_SUPER NS_SWIFT_NAME(setNeedsThemeAppearanceUpdate());
- (void)xz_updateThemeAppearanceIfNeeded NS_SWIFT_NAME(updateThemeAppearanceIfNeeded());
- (void)xz_updateAppearanceWithTheme:(nonnull XZTheme *)newTheme NS_REQUIRES_SUPER NS_SWIFT_NAME(updateAppearance(with:));
- (void)xz_updateAppearanceWithThemeStyles:(nonnull XZThemeStyleCollection *)themeStyles NS_REQUIRES_SUPER NS_SWIFT_NAME(updateAppearance(with:));

@end
