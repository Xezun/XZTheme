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


/// 当前控件的缺点：
/// 1. XZThemeStyle 属性过多。
/// 2. 通过 extension 拓展的外观样式属性，可能无法的拓展。
/// 对于缺点1，一般情况下，开发对于要设置外观样式，应该使用哪个属性都很清楚，应该不存在混淆的问题，即使存在也是少数。
/// 这种情况类似于 CSS 样式，没有具体的约束某个类型的控件能用什么样式属性，但是不影响它的正常使用。
/// 对于缺点2，在框架设计之初，考虑过使用运行时动态捕捉方法和参数的方案，但是最终弃用。
/// 运行时的方式，类似于 UIAppearance 机制，可以解决1的问题，同时也不存在2问题，但是这一套机制只能用于 OC ，而且对内存也不是很友好。
/// 所以本框架的设计目的就很明确了，通过一次劳动，将已知的外观属性，通过一套规则，使其能自动应用已配置的值，而且可以控制这其中的内存和性能消耗。
/// 如果框架对所有 UIKit 视图都默认提供了一套主题规则，而且开发者不需要太多学习成本，只需设置属性值，就可以轻松实现主题支持，那么本框架的设计目的就实现了。
/// 一般情况下，对系统控件进行拓展并提供额外的属性来控制外观，这在目前除了使用运行时，似乎没有办法解决。不过好在，一般情况下，拓展系统组件不会对
/// 改变外观样式，或者对外观样式的改变，也是通过添加额外的子视图来实现，而子视图是在主题传播链上的，似乎也不是不能解决的问题。因此，当我们想通过拓展给系统
/// 组件添加额外的功能时，有必要提供公开的接口，便于其它开发者直接控制管理，比如 MJRefresh ，你可以通过 mj_header 来访问它额外增加的视图。


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
/// @note 应用主题会向所有 UIApplication.sharedApplication.windows 和根控制器发送主题事件。
/// @note 视图控件或视图控制器，默认会向其子视图或自控制器以及相关联的对象发送事件。
/// @note 没有正在显示的视图，会在显示（添加到父视图）时，根据自身主题和当前主题判断是否需要更新主题外观。
/// @note 控制器也会在其将要显示时，判断主题从而决定是否更新主题外观。
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
