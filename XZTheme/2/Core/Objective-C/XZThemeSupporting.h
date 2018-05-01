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
NS_SWIFT_NAME(ThemeSupporting) @protocol XZThemeSupporting <NSObject>
/// 是否传递主题变更事件。
/// @note 在 NSObject 实现中，该方法返回 YES 。
/// @note 在 UI 控件中，此属性会影响主题事件是否传递给其子视图。
/// @note 在某些 UI 控件中，一般是独立的基础组件，该方法返回 NO 。
- (BOOL)xz_forwardsThemeAppearanceUpdate NS_SWIFT_NAME(forwardsThemeAppearanceUpdate());
/// 标记当前对象需要更新主题。
/// @note 此方法主要目的是降低在更改主题样式时更新主题的频率，从而提高性能。
/// @note 默认情况下，该方法将在下一 runloop 中调用 `-applyThemeIfNeeded` 方法，且在同一 runloop 中，多次调用，只会触发一次。
/// @note 当 UI 控件初次配置主题时（调用 xz_themes 属性)，将自动地标记为需要更新主题。
/// @note 当 UI 控件不显示时，更新其主题一般没有太大意义，所以在主题变更时，默认只向正在显示的视图发送了事件。
/// @note 当 UI 控件添加到父视图时，其会自动检查自身主题与当前主题是否一致，并决定是否更新主题。
/// @note 对于非 UIKit 控件对象，需要手动添加监听主题变更通知，并在合适的时机调用此方法。
- (void)xz_setNeedsThemeAppearanceUpdate NS_SWIFT_NAME(setNeedsThemeAppearanceUpdate());
/// 如果已被标记为需要更新主题，调用此方法立即更新主题。
/// @note 在 NSObject 默认实现中，此方法会调用 `-xz_updateAppearanceWithTheme:` 方法，并记录当前主题。
/// @note @b 一般情况下，不需要重写此方法。
- (void)xz_updateThemeAppearanceIfNeeded NS_SWIFT_NAME(updateThemeAppearanceIfNeeded());
/// 当需要应用主题时，此方法会被调用。
/// @note 在 NSObject 默认实现中，当此方法执行时，属性 `xz_appliedTheme` 的值为旧的主题。
/// @note 如果当前没有配置任何主题，则不会执行任何操作。
/// @note 默认情况下此方法将检查是否已配置主题样式，并调用 `-xz_updateAppearanceWithThemeStyles:` 方法。
/// @note 如果当前已配置主题，但是没有当前主题的样式，则尝试从默认主题配置中读取样式并应用。
///
/// @param newTheme 待应用的主题。
- (void)xz_updateAppearanceWithTheme:(nonnull XZTheme *)newTheme NS_SWIFT_NAME(updateAppearance(with:));
/// 当应用主题时，如果当前对象已配置了主题样式，则此方法会被调用。
/// @note 当此方法执行时，属性 `xz_appliedTheme` 的值为旧的主题。
/// @note 默认此方法不执行任何操作。
/// @note 如果对象当前主题没有配置主题样式，则此处应用的样式为默认主题下配置的主题样式。
///
/// @param themeStyles 主题样式。
- (void)xz_updateAppearanceWithThemeStyles:(nonnull XZThemeStyleCollection *)themeStyles NS_SWIFT_NAME(updateAppearance(with:));
@end





