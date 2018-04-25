//
//  XZTheme.h
//  XZTheme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XZThemeStyles;


NS_ASSUME_NONNULL_BEGIN


/// 当主题发生改变时，所发送通知的名称。
UIKIT_EXTERN NSNotificationName const _Nonnull XZThemeDidChangeNotification NS_SWIFT_NAME(ThemeDidChange);
/// 保存默认主题使用的 NSUserDefault 键名。
UIKIT_EXTERN NSString         * const _Nonnull XZThemeUserDefaultsKey       NS_SWIFT_NAME(ThemeUserDefaultsKey);


/// @b 主题。
/// @todo 主题样式的资源管理以及静态缓存策略（通过主题标识符，将配置缓存到磁盘上）待研究。
/// @todo 通过主题标识符自动读取配置。
/// @todo 通过字典、JSON串来配置样式。
NS_SWIFT_NAME(Theme) @interface XZTheme: NSObject <NSCopying, NSCoding>

/// 默认主题。
@property (class, nonatomic, nonnull, readonly) XZTheme *defaultTheme;
/// 设置当前主题。
///
/// @param currentTheme 待设置的主题。
/// @param animated 是否展示渐变的动画效果。
+ (void)setCurrentTheme:(XZTheme *)currentTheme animated:(BOOL)animated;
/// 当前主题，默认 XZTheme.defaultTheme 。
/// @note 在 Swift 中，可以使用 Theme.current 来设置当前主题。
@property (class, nonatomic, nonnull) XZTheme *currentTheme;
/// 主题名称。
@property (nonatomic, readonly, nonnull) NSString *name;
/// 构造一个主题对象。
///
/// @param name 主题名字。
/// @return 主题对象。
- (nonnull instancetype)initWithName:(nonnull NSString *)name;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder;
- (BOOL)isEqual:(nullable id)object;
- (NSUInteger)hash;

@end




/// XZThemes 是管理对象所有主题 XZTheme 的集合。
NS_SWIFT_NAME(Themes) @interface XZThemes : NSObject

/// 当前 XZThemes 所属的对象。
@property (nonatomic, weak, readonly, nullable) NSObject *object;
/// 所有主题。
@property (nonatomic, copy, readonly, nonnull) NSArray<XZTheme *> *themes;

- (instancetype)init NS_UNAVAILABLE;

/// XZThemes 初始化时，需指定其所属的对象。
/// @note 主题样式发生改变时，将会触发主题相关方法。
///
/// @param object 主题所属的对象。
/// @return XZThemes 对象。
- (instancetype)initWithObject:(NSObject *)object NS_DESIGNATED_INITIALIZER NS_SWIFT_NAME(init(_:));

/// 获取已设置的主题样式。
/// @note 懒加载，如果主题对应的样式不存在，则会自动创建一个空的主题样式对象。
///
/// @param theme 主题。
/// @return 主题样式。
- (nonnull XZThemeStyles *)themeStylesForTheme:(nonnull XZTheme *)theme;

/// 设置主题样式。
///
/// @param themeStyles 主题样式。
/// @param theme 主题。
- (void)setThemeStyles:(nonnull XZThemeStyles *)themeStyles forTheme:(nonnull XZTheme *)theme;

/// 获取已设置的主题样式（如果有）。
///
/// @param theme 主题。
/// @return 主题样式。
- (nullable XZThemeStyles *)themeStylesIfLoadedForTheme:(nonnull XZTheme *)theme;

/// 获取默认主题的样式的快捷方法。
/// @note 该方法等同于调用 -themeStyleForTheme: 方法。
@property (nonatomic, nonnull, readonly) XZThemeStyles *defaultThemeStyles NS_SWIFT_NAME(default);

@end






@interface NSObject (XZThemeSupporting)

/// 当前对象的所有主题集合，懒加载。
@property (nonatomic, strong, readonly, nonnull) XZThemes *xz_themes NS_SWIFT_NAME(themes);

/// 当前对象的所有主题，如果已加载。
@property (nonatomic, strong, readonly, nullable) XZThemes *xz_themesIfLoaded NS_SWIFT_NAME(themesIfLoaded);

/// 当前已应用的主题。
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
- (void)xz_setNeedsThemeAppearanceUpdate NS_SWIFT_NAME(setNeedsThemeAppearanceUpdate());

/// @b 一般情况下，请勿重写此方法。
/// 如果已被标记为需要更新主题，则执行以下操作，否则不执行任何操作。
/// @note 1. 取消标记。
/// @note 2. 取出当前主题并应用（调用 `xz_updateAppearanceWithThemeStyles:` 方法）。
/// @note 3. 记录 2 中应用的主题。
- (void)xz_updateThemeAppearanceIfNeeded NS_SWIFT_NAME(updateThemeAppearanceIfNeeded());

/// 当需要应用主题时，此方法会被调用。
/// @note 当此方法执行时，属性 `xz_appliedTheme` 的值为旧的主题。
/// @note 默认此方法不执行任何操作。
///
/// @param themeStyles 待应用的主题样式。
- (void)xz_updateAppearanceWithThemeStyles:(nonnull XZThemeStyles *)themeStyles NS_SWIFT_NAME(updateAppearance(with:));

@end

NS_ASSUME_NONNULL_END
