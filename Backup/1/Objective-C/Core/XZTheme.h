//
//  XZTheme.h
//  XZKit
//
//  Created by mlibai on 2017/10/14.
//

#import <UIKit/UIKit.h>
#import "XZThemeDefines.h"

@class XZThemeStyle;
/*
 自定义格式 .xzss 样式（开发中）：
 @code
 #default .main {
    backgroundColor: 0xFFFFFFFF;
 }
 
 #default .main .header {
    backgroundColor: 0xFF0000FF;
 }
 
 #default .main .header .redBtn {
    titleColor: 0xFFFFFFFF;
    backgroundColor: nil;
 }
 
 #default .main .header .redBtn:selected {
    titleColor: 0xFF0000FF;
 }
 
 #default .main .header .yellowBtn {
    titleColor: 0xFFFFFFFF;
    backgroundColor: 0x00FFFFFF;
 }
 @endcode
 
 初步规则：
 1, 主题名：    #ThemeName
 2, 样式标识符： .ThemeIdentifier
 3，样式配置：  {StyleAttribute: StyleValue;}
 4，状态样式：  .ThemeIdentifier:ThemeState
 5，复合样式：  .ThemeIdentifier1.ThemeIdentifier2
 */

/// 设计目的：统一管理主体样式。
///
/// 在 XZTheme 配置文件中：
/// @note 以 : 开头的为状态名；
/// @note 以 . 开头的为属性名；
/// @note 其它字符开头的为样式名；
/// @note 常量 XZThemeStyleConfigurationValueNone 用来在配置中表示需要设置 nil 的样式。
NS_SWIFT_NAME(Theme) @interface XZTheme : NSObject

/// 主题名称。
@property (nonatomic, copy, readonly, nonnull) NSString *name;

/// 当前主题下包含的所有样式。
@property (nonatomic, copy, readonly, nonnull) NSDictionary<XZThemeIdentifier, XZThemeStyle *> *styles;

/// 请使用 -initWithName: 方法。
- (nonnull instancetype)init NS_UNAVAILABLE;

/// 指定初始化方法。
///
/// @param name 主题名称
/// @return XZTheme 对象
- (nonnull instancetype)initWithName:(nonnull NSString *)name NS_DESIGNATED_INITIALIZER;

/// 获取当前主题中指定标识符的样式。
/// @note 如果样式标识符是一个复合标识符，那么它的样式可能是有多个子样式复合而成，子样式复合顺序为字母排序。
///
/// @param identifier 样式标识符
/// @return XZThemeStyle 对象
- (nullable XZThemeStyle *)styleForIdentifier:(nonnull XZThemeIdentifier)identifier;

/// 添加/修改/删除当前主题的指定样式，修改样式不影响已经应用过的主题对象。
///
/// @param style 主题样式，如果为 nil 的话，就表示删除
/// @param identifier 主题样式标识符
- (void)setStyle:(nullable XZThemeStyle *)style forIdentifier:(nonnull XZThemeIdentifier)identifier;

/// 通过主题配置字典构造主题对象的便利方法。主题配置字典接口类似于：
///
/// ```json
/// {
///     "identifier1": { 参见 Theme.Style 样式配置 },
///     "identifier2": { 参见 Theme.Style 样式配置 }
/// }
/// ```
///
/// @param name 主题名称
/// @param configuration 包含主题信息的配置字典
/// @return XZTheme 对象
+ (nonnull XZTheme *)themeWithName:(nonnull NSString *)name configuration:(nonnull NSDictionary<NSString *, NSDictionary<NSString *, id> *> *)configuration;


/// 从配置字典中添加样式。
/// @note 配置字典中的样式会合并已有的样式，样式中属性名相同的值会被覆盖。
///
/// @param configuration 样式配置字典。
- (void)addStylesFromConfiguration:(nonnull NSDictionary<NSString *, NSDictionary<NSString *, id> *> *)configuration NS_SWIFT_NAME(addStyles(from:));


/// 判断两个主题是否相同，根据主题名字进行判断。
///
/// @param theme 待比较的主题。
/// @return 是否相同。
- (BOOL)isEqualToTheme:(nullable XZTheme *)theme;

- (BOOL)isEqual:(nullable id)object;

@end



#pragma mark - XZThemeManager

@interface XZTheme (XZExtendedTheme)


/// 当前已应用的主题。默认加载的主题的名字为 `default` 。
/// @note 设置该属性以切换当前主题。
/// @note 如果从没有设置主题，默认主题为空主题。
@property (class, nonatomic, readonly, nonnull) XZTheme *currentTheme NS_SWIFT_NAME(current);


/// 获取资源配置文件中的指定名称的主题。
/// @note 该方法会缓存已获取到的主题。
/// @note 当内存紧张时，会尝试释放已缓存但是并没使用的主题。
///
/// @param name 主题名称。
/// @return XZTheme 对象。
+ (nullable XZTheme *)themeNamed:(nonnull NSString *)name NS_SWIFT_NAME(init(named:));

/// 应用主题。
- (void)apply;

@end


@interface XZTheme (XZThemeDefines)

/// 判断字符从指定位置开始是否符合 XZTheme 命名规则。
/// @note 只能包含字母、数字、下划线、中横线等英文字符。
///
/// @param aString 待判断的字符串。
/// @param location 字符串指定字符位置开始。
/// @return YES，符合 XZTheme 命名规则；NO，不符合。
+ (BOOL)isValidName:(NSString *)aString from:(NSInteger)location;

/// 判断整个字符串是否符合 XZTheme 命名规则。
///
/// @param aString 待判定的字符串。
/// @return YES，符合 XZTheme 命名规则；NO，不符合。
+ (BOOL)isValidName:(NSString *)aString;

@end






/// 判断主题标识符是否包含另一标识符。
///
/// @note 如果 identifier1 是单标识符，那么以它为末位子标识符的复合标识符都是它的子标识符。
/// @note 如果 identifier1 是复合标识符且包含 identifier2 ，那么 identifier2 的子标识符在 identifier1 中能找到相同的顺序。
///
/// @param identifier1 主题标识符1。
/// @param identifier2 主题标识符2。
/// @return 主题标识符1是否包含主题标识符2。
UIKIT_EXTERN BOOL XZThemeIdentifierContainsThemeIdentifier(XZThemeIdentifier _Nonnull identifier1, XZThemeIdentifier _Nonnull identifier2);

/// 在项目的 info.plist 文件中指定主题的配置文件名称所用的Key。
/// @note 支持 .plist/.json 两种格式的配置文件。
UIKIT_EXTERN NSString * const _Nonnull XZThemeBundleKey;

/// 当主题发生改变时，所发送通知的名称。
UIKIT_EXTERN NSNotificationName const _Nonnull XZThemeDidChangeNotification NS_SWIFT_NAME(ThemeDidChange);

/// 保存默认主题使用的 NSUserDefault 键名。
UIKIT_EXTERN NSString * const _Nonnull XZThemeUserDefaultsKey;

/// 多属性主题标识符分隔符：单个英文空格。
UIKIT_EXTERN NSString * const _Nonnull XZThemeIdentifierSeparator;


