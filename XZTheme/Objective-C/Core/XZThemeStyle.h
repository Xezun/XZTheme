//
//  XZThemeStyle.h
//  XZKit
//
//  Created by mlibai on 2017/10/14.
//

#import <UIKit/UIKit.h>
#import "XZThemeDefines.h"


/// ".body": {
///     "backgroundColor": "#fff";
///     "textColor": "#000";
///     ".header": {  //  ".header .footer"
///         "backgroundColor": "#F00";
///         "titleColor": "#00F";
///     };
/// }


/// 使用字符串 “nil” 表示 nil 值；使用 “\\nil” 表示字符串 "nil"；使用 “\\\\nil” 表示字符串 "\\nil"，以此类推。
/// @note 上段文本请以 MarkDown 实际显示效果为准。
/// @note 反斜杠规则只在判断 nil 值时生效。
UIKIT_EXTERN NSString * const _Nonnull XZThemeStyleConfigurationValueNone NS_SWIFT_NAME(ThemeStyleConfigurationValueNone);

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Theme.Style) @interface XZThemeStyle : NSObject <NSCopying>

/// 当前样式的标识符。
@property (nonatomic, readonly, copy, nonnull) XZThemeIdentifier identifier;

/// 样式所有属性。
@property (nonatomic, readonly, copy, nonnull) NSArray<XZThemeAttribute> *attributes;

/// 子样式用 key 加以标识。
@property (nonatomic, readonly, copy, nonnull) NSDictionary<NSString *, XZThemeStyle *> *substyles;

- (instancetype)init NS_DESIGNATED_INITIALIZER;

+ (instancetype)themeStyleWithConfiguration:(nonnull NSDictionary *)configuration NS_SWIFT_NAME(init(configuration:));

- (nullable XZThemeStyle *)substyleForKey:(NSString *)aKey;
- (void)setSubstyle:(nullable XZThemeStyle *)substyle forKey:(NSString *)aKey;

/// 将另一个样式中的属性和子样式合并到当前样式中，相同的属性会覆盖，相同的子样式合并。
///
/// @param style 待合并的样式。
- (void)addAttributesAndSubstylesFromStyle:(XZThemeStyle *)style;

/// 设置样式属性在指定状态下的值。
/// - Note: 使用 [NSNull null] 来代表需要设置为 nil 的样式，如果使用 nil 表示删除这个样式属性。
///
/// @param value 待设置的值。
/// @param attribute 待设置的属性。
/// @param state 样式的状态。
- (void)setValue:(nullable id)value forAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state;

/// 设置样式属性在 Normal 状态下的值。
///
/// @param value 待设定的值。
/// @param attribute 待设置的属性。
- (void)setValue:(nullable id)value forAttribute:(XZThemeAttribute)attribute;

/// 获取样式属性在指定状态的值。
///
/// @param attribute 样式属性。
/// @param state 状态。
- (nullable id)valueForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state;

/// 获取样式属性在 Normal 状态的值。
///
/// @param attribute 样式属性。
- (nullable id)valueForAttribute:(XZThemeAttribute)attribute;

@end


#pragma mark - 数据取值

@interface XZThemeStyle (XZExtendedThemeStyle)

- (NSInteger)integerValueForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state;
- (NSInteger)integerValueForAttribute:(XZThemeAttribute)attribute;

- (float)floatValueForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state;
- (float)floatValueForAttribute:(XZThemeAttribute)attribute;

- (double)doubleValueForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state;
- (double)doubleValueForAttribute:(XZThemeAttribute)attribute;

- (BOOL)boolValueForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state;
- (BOOL)boolValueForAttribute:(XZThemeAttribute)attribute;

- (nullable NSString *)stringValueForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state;
- (nullable NSString *)stringValueForAttribute:(XZThemeAttribute)attribute;

- (nullable UIImage *)imageForAttribute:(XZThemeAttribute)attribute;
- (nullable UIImage *)imageForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state;

- (nullable UIColor *)colorForAttribute:(XZThemeAttribute)attribute;
- (nullable UIColor *)colorForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state;

- (nullable UIFont *)fontForAttribute:(XZThemeAttribute)attribute;
- (nullable UIFont *)fontForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state;

// 富文本。

- (nullable NSAttributedString *)attributedStringForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state;
- (nullable NSAttributedString *)attributedStringForAttribute:(XZThemeAttribute)attribute;

// 富文本属性。

- (nullable NSDictionary<NSAttributedStringKey, id> *)stringAttributesForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state;
- (nullable NSDictionary<NSAttributedStringKey, id> *)stringAttributesForAttribute:(XZThemeAttribute)attribute;

@end

NS_ASSUME_NONNULL_END
