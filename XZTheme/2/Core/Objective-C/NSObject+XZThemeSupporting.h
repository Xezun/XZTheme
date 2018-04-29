//
//  NSObject+XZThemeSupporting.h
//  Example
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZThemeSupporting.h"

@class XZTheme, XZThemeCollection, XZThemeStyleCollection, XZThemeStyle;

/// 默认为 NSObject 提供了 XZThemeSupporting 支持。
@interface NSObject (XZThemeSupporting) <XZThemeSupporting>

/// 当前对象的所有主题集合，懒加载。
@property (nonatomic, strong, readonly, nonnull) XZThemeCollection *xz_themes NS_SWIFT_NAME(themes);

/// 当前对象的所有主题，如果已加载。
@property (nonatomic, strong, readonly, nullable) XZThemeCollection *xz_themesIfLoaded NS_SWIFT_NAME(themesIfLoaded);

/// 当前已应用的主题。
/// @note 已应用的主题不等于当前主题，特别是当控件未显示时。
@property (nonatomic, copy, readonly, nullable) XZTheme *xz_appliedTheme NS_SWIFT_NAME(appliedTheme);

/// 是否传递主题变更事件。默认 YES 。
/// @note 当 UIView 控件收到主题变更事件时，可以通过此方法来控制子视图是否更新主题。
- (BOOL)xz_forwardsThemeAppearanceUpdate NS_SWIFT_NAME(forwardsThemeAppearanceUpdate());

/// 是否已标记需要更新主题。
- (BOOL)xz_needsThemeAppearanceUpdate NS_SWIFT_NAME(needsThemeAppearanceUpdate());

/// 将主题标记为需要更新。
/// @note 此方法主要目的是降低在更改主题样式时更新主题的频率，从而提高性能；尽可能的只在视图显示时更新主题则不在此方法考虑的范围。
/// @note 所以此方法一旦调用，更新主题的方法一定会发生，只是频率会大大减少。
/// @note 默认情况下，该方法将在下一 runloop 中调用 `-applyThemeIfNeeded` 方法，且在同一 runloop 中，多次调用，只会触发一次。
/// @note 对于 UIKit 控件，当主题发生改变时，此方法会自动调用；如果控件没有显示，则在其显示时会自动调用。
/// @note 对于非 UIKit 控件对象，需要手动添加监听主题变更通知，并在合适的时机调用此方法（一般可以直接将通知绑定到此方法上）。
- (void)xz_setNeedsThemeAppearanceUpdate NS_REQUIRES_SUPER NS_SWIFT_NAME(setNeedsThemeAppearanceUpdate());

/// @b 一般情况下，请勿重写此方法。
/// 如果已被标记为需要更新主题，则执行以下操作，否则不执行任何操作。
/// @note 1. 取消标记。
/// @note 2. 取出当前主题并应用（调用 `xz_updateAppearanceWithThemeStyles:` 方法）。
/// @note 3. 记录 2 中应用的主题。
- (void)xz_updateThemeAppearanceIfNeeded NS_SWIFT_NAME(updateThemeAppearanceIfNeeded());

/// 当需要应用主题时，此方法会被调用。
/// @note 当此方法执行时，属性 `xz_appliedTheme` 的值为旧的主题。
/// @note 如果当前没有配置任何主题，则不会执行任何操作。
/// @note 默认情况下此方法将检查是否已配置主题样式，并调用 `-xz_updateAppearanceWithThemeStyles:` 方法。
/// @note 如果当前已配置主题，但是没有当前主题的样式，则尝试从默认主题配置中读取样式并应用。
///
/// @param newTheme 待应用的主题。
- (void)xz_updateAppearanceWithTheme:(nonnull XZTheme *)newTheme NS_REQUIRES_SUPER NS_SWIFT_NAME(updateAppearance(with:));

/// 当需要应用主题时，且当前对象已被配置主题样式时，此方法会被调用。
/// @note 当此方法执行时，属性 `xz_appliedTheme` 的值为旧的主题。
/// @note 默认此方法不执行任何操作。
///
/// @param themeStyles 待应用的主题样式。
- (void)xz_updateAppearanceWithThemeStyles:(nonnull XZThemeStyleCollection *)themeStyles NS_REQUIRES_SUPER NS_SWIFT_NAME(updateAppearance(with:));

@end
