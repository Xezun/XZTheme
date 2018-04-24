//
//  XZTheme.h
//  XZTheme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>



@class XZThemeStyles;

/// 主题。
/// @TODO 如果在 window 创建之前设置主题，那么 window 的主题是否会应用需待验证。
typedef NSString * XZTheme NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(Theme);

NS_ASSUME_NONNULL_BEGIN

/// 默认主题。
UIKIT_EXTERN XZTheme            const _Nonnull XZThemeDefault               NS_SWIFT_NAME(default);
/// 当主题发生改变时，所发送通知的名称。
UIKIT_EXTERN NSNotificationName const _Nonnull XZThemeDidChangeNotification NS_SWIFT_NAME(ThemeDidChange);
/// 保存默认主题使用的 NSUserDefault 键名。
UIKIT_EXTERN NSString         * const _Nonnull XZThemeUserDefaultsKey       NS_SWIFT_NAME(ThemeUserDefaultsKey);




/// XZThemes 对象描述了对象所有已配置的主题。
NS_SWIFT_NAME(Themes) @interface XZThemes : NSObject

/// 当前主题，默认 XZThemeDefault 。
@property (class, nonatomic, nonnull) XZTheme currentTheme NS_SWIFT_NAME(current);

/// 当前 XZThemes 所属的对象。
@property (nonatomic, weak, readonly, nullable) UIView *object;
/// 所有主题。
@property (nonatomic, copy, readonly, nonnull) NSArray<XZTheme> *themes;

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
- (nonnull XZThemeStyles *)themeStylesForTheme:(nonnull XZTheme)theme;

/// 设置主题样式。
///
/// @param themeStyle 主题样式。
/// @param theme 主题。
- (void)setThemeStyles:(nonnull XZThemeStyles *)themeStyle forTheme:(nonnull XZTheme)theme;

/// 获取已设置的主题样式（如果有）。
///
/// @param theme 主题。
/// @return 主题样式。
- (nullable XZThemeStyles *)themeStylesIfLoadedForTheme:(nonnull XZTheme)theme;

/// 获取默认主题的样式的快捷方法。
/// @note 该方法等同于调用 -themeStyleForTheme: 方法。
@property (nonatomic, nonnull, readonly) XZThemeStyles *defaultThemeStyles NS_SWIFT_NAME(default);

@end






@interface NSObject (XZThemeSupporting)

/// 当前对象的所有主题，懒加载。
@property (nonatomic, strong, readonly, nonnull) XZThemes *xz_themes NS_SWIFT_NAME(themes);
/// 当前对象的所有主题，非懒加载。
@property (nonatomic, strong, readonly, nullable) XZThemes *xz_themesIfLoaded NS_SWIFT_NAME(themesIfLoaded);

@end

NS_ASSUME_NONNULL_END
