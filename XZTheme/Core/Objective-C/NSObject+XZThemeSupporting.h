//
//  NSObject+XZThemeSupporting.h
//  XZTheme
//
//  Created by mlibai on 2018/5/21.
//

#import <Foundation/Foundation.h>

@interface NSObject (XZThemeSupporting)

/// 启用 NSObject 自动应用主题。
/// @note 视图控件 UIView 及子类有独立的主题控制方式，不受此设置影响。
/// @note 默认情况下是不需要开启此设置的，除非你有大量非视图控件需要适配主题。
+ (void)xz_setAutomaticallyUpdateThemeAppearanceEnabled NS_SWIFT_NAME(setAutomaticallyUpdateThemeAppearanceEnabled());

/// 是否已启用 NSObject 自动应用主题。
@property (class, nonatomic, readonly) BOOL xz_isAutomaticallyUpdateThemeAppearanceEnabled NS_SWIFT_NAME(isAutomaticallyUpdateThemeAppearanceEnabled);

/// 在主题发生改变时，是否自动应用主题。默认 false 。
/// @note 对于所有 NSObject 子类，都可以通过重写此方法来启用由 XZTheme 框架默认实现的主题管理机制。
/// @note 被管理的对象通过监听通知，在主题变更时，调用对象的 `setNeedsThemeAppearanceUpdate` 方法来切换主题。
/// @note 如果对象的主题有其自己的管理机制（比如 `UIView`），重写此属性并返回 false ，以停用 XZTheme 的自动管理。
@property (nonatomic, readonly) BOOL xz_shouldAutomaticallyUpdateThemeAppearance NS_SWIFT_NAME(shouldAutomaticallyUpdateThemeAppearance);

@end
