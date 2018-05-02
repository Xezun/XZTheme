//
//  NSObject+XZTheme.h
//  XZKit
//
//  Created by mlibai on 2017/10/14.
//

#import <Foundation/Foundation.h>
#import "XZThemeDefines.h"
@class XZTheme;


@interface NSObject (XZTheme)

/** 主题标识符。 */
@property (nonatomic, copy, nullable, setter=xz_setThemeIdentifier:) XZThemeIdentifier xz_themeIdentifier NS_SWIFT_NAME(themeIdentifier);

/**
 * 已应用的主题名称。
 * @note 对于 UIView 控件，如果当前已经更换了主题，但是控件并显示在 window 上，此属性不会立即更改，而是要等到其添加到 window 上时，才会决定是否需要更新。
 * @note 该属性只表示当前控件已应用的主题，不表示 App 当前已设定的主题。
 * @note 如要获取 App 当前已设定的主题，请用 Theme.current 代替。
 */
@property (nonatomic, readonly, nonnull) NSString *xz_nameOfAppliedTheme NS_SWIFT_NAME(nameOfAppliedTheme);

/**
 将主题标记为需要更新。
 @note 默认情况下，该方法将在下一 runloop 中调用 `-applyThemeIfNeeded` 方法，且在同一 runloop 中，多次调用，只会触发一次。
 @note 主题标识符为空，视图也会被标记为主题需要更新。
 @note 对于 UIKit 控件，当主题发生改变时，此方法会自动调用；如果控件没有显示，则在其显示时会自动调用。
 @note 对于非 UIKit 控件对象，需要手动添加监听主题变更通知，并在合适的时机调用此方法（一般可以直接将通知绑定到此方法上）。
 */
- (void)xz_setNeedsThemeApply NS_SWIFT_NAME(setNeedsThemeApply());

/// @b 一般情况下，请勿重写此方法。
/// 如果已被标记为需要更新主题，则执行以下操作，否则不执行任何操作。
/// @note 1. 取消标记。
/// @note 2. 取出当前主题并应用（调用 `xz_updateAppearanceWithTheme:` 方法）。
/// @note 3. 记录 2 中应用的主题。
- (void)xz_applyThemeIfNeeded NS_SWIFT_NAME(applyThemeIfNeeded());

/**
 * 当需要应用主题时，此方法会被调用。
 * @note 如果待应用的主题中存在当前对象的主题样式，则方法 `xz_updateAppearanceWithThemeWithThemeStyle:` 会被调用。
 * @note 在该方法中，`xz_nameOfAppliedTheme` 属性是已应用的旧的主题。
 * @note 直接调用该方法，不能更新 `xz_nameOfAppliedTheme` 的值。
 * @note 除 UIKit 控件外，主题发生改变后，所有控件此方法都将会被调用。
 * @note 当主题发生改变时，请保证此方法在重写后一定会被调用。
 *
 * @param theme 待应用的主题
 */
- (void)xz_updateAppearanceWithTheme:(nonnull XZTheme *)theme NS_SWIFT_NAME(updateAppearance(with:));

@end
