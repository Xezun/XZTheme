//
//  XZTheme.h
//  XZTheme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZThemeDefines.h"

/// 尝试使用泛型最终以失败告终，无法解决的问题：
/// - Swift 对象无法在 OC 方法中出现。
/// - Swift 类目方法，无法继承重写。
/// - Swift 泛型无法桥接到 OC 。
/// - OC 泛型在 Swift 中泛型拓展，无法访问原始定义的方法。
/// - 子类无法在方法参数继承到一个泛型是自己的参数。
/// - 其它众多阻碍，最终导致无法实现。

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
XZ_THEME_FINAL_CLASS
@interface XZTheme: NSObject <NSCopying, NSCoding>
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
/// XZTheme 反序列化支持。
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder;
/// XZTheme 序列化支持。
- (void)encodeWithCoder:(NSCoder *)aCoder;
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




NS_ASSUME_NONNULL_END
