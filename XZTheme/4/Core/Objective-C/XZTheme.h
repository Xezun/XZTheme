//
//  XZTheme.h
//  XZTheme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZThemeDefines.h"
#import "XZThemeStyleCollection.h"


NS_ASSUME_NONNULL_BEGIN

/// 当主题发生改变时，所发送通知的名称。
UIKIT_EXTERN NSNotificationName const XZThemeDidChangeNotification NS_SWIFT_NAME(ThemeDidChange);
/// 保存默认主题使用的 NSUserDefault 键名。
/// @note 保存的内容为主题名称。
UIKIT_EXTERN NSString         * const XZThemeUserDefaultsKey       NS_SWIFT_NAME(ThemeUserDefaultsKey);
/// 应用主题动画时长。
UIKIT_EXTERN NSTimeInterval     const XZThemeAnimationDuration     NS_SWIFT_NAME(Theme.AnimationDuration);

/// @b 主题。
/// 主题的机制依赖与运行时，所以主要代码以 Objective-C 呈现。
/// @todo 主题样式的资源管理以及静态缓存策略（通过主题标识符，将配置缓存到磁盘上）待研究。
/// @todo 通过主题标识符自动读取配置。
/// @todo 通过字典、JSON串来配置样式。
NS_SWIFT_NAME(Theme)
XZ_THEME_SUBCLASSING_RESTRICTED
@interface XZTheme: NSObject <NSCopying>
/// 主题名称。
@property (nonatomic, readonly, nonnull) NSString *name;
/// 请使用 [XZTheme themeNamed] 方法。
- (instancetype)init NS_UNAVAILABLE;
/// 构造一个主题对象。
/// @note 如果主题名字与当前主题或默认主题名称相同，则返回已存在的主题。
///
/// @param name 主题名字。
/// @return 主题对象。
+ (nonnull XZTheme *)themeNamed:(nonnull NSString *)name NS_SWIFT_NAME(init(named:));

- (id)copyWithZone:(nullable NSZone *)zone;
/// 比较 XZTheme 请使用此方法，仅比较名称。
- (BOOL)isEqual:(nullable id)object;
/// 返回 name 属性的哈希值。
- (NSUInteger)hash;
/// 应用主题。
///
/// @param animated 是否渐变主题应用的过程。
- (void)apply:(BOOL)animated;
@end

@interface XZTheme (XZExtendedTheme)
/// 默认主题。
/// @note 如果对象没有设置任何主题样式，那么该主题为默认生效的主题。
/// @note 如果应用主题时，某对象的主题配置不存在，会默认查找一次默认主题。
/// @note 建议使用默认主题 + 自定义主题组合。
@property (class, nonatomic, nonnull, readonly) XZTheme *defaultTheme;
/// 当前主题，默认 XZTheme.defaultTheme 。
@property (class, nonatomic, nonnull, readonly) XZTheme *currentTheme;
@end



/// XZThemeSet 是 XZTheme 的集合，它管理了对象所支持的主题和样式配置。
NS_SWIFT_NAME(Theme.Collection)
XZ_THEME_SUBCLASSING_RESTRICTED
@interface XZThemeCollection<ObjectType> : NSObject

/// 当前 XZThemeSet 所属的对象。
/// @note 因为运行时的值绑定机制，被绑定的值生命周期可能比对象的生命周期长，所以使用 weak 属性。
@property (nonatomic, unsafe_unretained, readonly, nonnull) ObjectType object;
/// 所有主题。
@property (nonatomic, copy, readonly, nonnull) NSArray<XZTheme *> *themes;

- (instancetype)init NS_UNAVAILABLE;

/// XZThemeSet 初始化时，需指定其所属的对象。
/// @note 主题样式发生改变时，将会触发主题相关方法。
///
/// @param object 主题所属的对象。
/// @return XZThemeSet 对象。
- (instancetype)initWithObject:(ObjectType)object NS_DESIGNATED_INITIALIZER NS_SWIFT_NAME(init(_:));

/// 获取已设置的主题样式。
/// @note 懒加载，如果主题对应的样式不存在，则会自动创建一个空的主题样式对象。
///
/// @param theme 主题。
/// @return 主题样式。
- (nonnull XZThemeStyleCollection<ObjectType> *)themeStylesForTheme:(nonnull XZTheme *)theme;

/// 设置主题样式。
///
/// @param themeStyles 主题样式。
/// @param theme 主题。
- (void)setThemeStyles:(nonnull XZThemeStyleCollection<ObjectType> *)themeStyles forTheme:(nonnull XZTheme *)theme;

/// 获取已设置的主题样式（如果有）。
///
/// @param theme 主题。
/// @return 主题样式。
- (nullable XZThemeStyleCollection<ObjectType> *)themeStylesIfLoadedForTheme:(nonnull XZTheme *)theme;

/// 获取默认主题的样式的快捷方法。
/// @note 该方法等同于调用 -themeStyleForTheme: 方法。
@property (nonatomic, nonnull, readonly) XZThemeStyleCollection<ObjectType> *defaultThemeStyles NS_SWIFT_NAME(default);

@end





NS_ASSUME_NONNULL_END
