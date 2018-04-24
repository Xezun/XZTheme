//
//  NSObject+XZTheme.h
//  XZKit
//
//  Created by mlibai on 2017/10/14.
//

#import <UIKit/UIKit.h>
#import "XZTheme.h"


@interface NSObject (XZTheme)

/// 已应用的主题。
@property (nonatomic, copy, readonly, nullable) XZTheme xz_appliedTheme NS_SWIFT_NAME(appliedTheme);

/// 是否已标记需要更新主题。
@property (nonatomic, readonly) BOOL xz_needsThemeAppearanceUpdate NS_SWIFT_NAME(needsThemeAppearanceUpdate);

/// 将主题标记为需要更新。
/// @note 默认情况下，该方法将在下一 runloop 中调用 `-applyThemeIfNeeded` 方法，且在同一 runloop 中，多次调用，只会触发一次。
/// @note 主题标识符为空，视图也会被标记为主题需要更新。
/// @note 对于 UIKit 控件，当主题发生改变时，此方法会自动调用；如果控件没有显示，则在其显示时会自动调用。
/// @note 对于非 UIKit 控件对象，需要手动添加监听主题变更通知，并在合适的时机调用此方法（一般可以直接将通知绑定到此方法上）。
- (void)xz_setNeedsThemeAppearanceUpdate NS_SWIFT_NAME(setNeedsThemeAppearanceUpdate());

/// @b 一般情况下，请勿重写此方法。
/// 如果已被标记为需要更新主题，则执行以下操作，否则不执行任何操作。
/// @note 1. 取消标记。
/// @note 2. 取出当前主题并应用（调用 `xz_updateAppearanceWithTheme:` 方法）。
/// @note 3. 记录 2 中应用的主题。
- (void)xz_updateThemeAppearanceIfNeeded NS_SWIFT_NAME(updateThemeAppearanceIfNeeded());

/// 当需要应用主题时，此方法会被调用。
/// @note 当此方法执行时，appliedTheme 为旧的主题。
///
/// @param themeStyles 待应用的主题样式。
- (void)xz_updateAppearanceWithThemeStyles:(nonnull XZThemeStyles *)themeStyles NS_SWIFT_NAME(updateAppearance(with:));

@end


@interface UIView (XZTheme)

/// 作为视图控件，其每次被添加到父视图上时，都会检查当前已应用的主题与 App 当前主题是否一致，从而判断是否需要调用应用主题的方法。
+ (void)load;

@end


@interface UIViewController (XZTheme)

/// 在 UIViewController 中：
/// @note 控制器每次显示时都会检查当前已应用的主题是否与 App 当前主题是否一致，从而决定是否执行应用主题的方法。
+ (void)load;

/// 作为控制器，当其自身被标记为需要应用主题时，会同时标记其 childViewControllers、presentedViewController、navigationItem、toolbarItems、tabBarItem 。
- (void)xz_setNeedsThemeAppearanceUpdate;

@end
