//
//  XZThemeStyle.h
//  XZKit
//
//  Created by mlibai on 2017/10/14.
//

#import <UIKit/UIKit.h>
#import "XZThemeDefines.h"


//配置是一个字典，其结构类似于：
//```json
//{
//    // 1. 不区分状态的样式属性，key 值将直接作为属性名。
//    "image": "icon_submit",
//    // 2 区分状态的样式属性，有两种写法。
//    "titleColor": {
//        // 2.1 key 为属性名，值为『状态-值』字典。
//        ":normal": "#000000",
//        ":selected": "#FF0000"
//    },
//    ":normal": {
//        // 2.2 key 为状态名，值为『属性名-值』字典。
//        "tintColor": "#FF0000",
//        "borderColor": "#CCCCCC"
//    },
//    // 3. 子控件样式，以 『.』 开头被视为子控件样式配置。
//    ".titleLabel": {
//        "textColor": "#000000"
//    }
//}
//```


/// 使用字符串 “nil” 表示 nil 值；使用 “\\nil” 表示字符串 "nil"；使用 “\\\\nil” 表示字符串 "\\nil"，以此类推。
/// @note 上段文本请以 MarkDown 实际显示效果为准。
/// @note 反斜杠规则只在判断 nil 值时生效。
UIKIT_EXTERN NSString * const _Nonnull XZThemeStyleConfigurationValueNone NS_SWIFT_NAME(ThemeStyleConfigurationValueNone);

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Theme.Style) @interface XZThemeStyle : NSObject <NSCopying>

/// 多样式合并时的优先级，默认 0。多样式内部合并时，数值越小越先合并。
@property (nonatomic, readonly) NSInteger priority;

/// 如果样式是由多个样式合并而来，则此数组表明了其属性的样式来源。
@property (nonatomic, readonly) NSArray<XZThemeIdentifier> *identifiers;

/// 当前样式的标识符。
@property (nonatomic, readonly, copy, nonnull) XZThemeIdentifier identifier;

@property (nonatomic, readonly, copy, nonnull) NSArray<XZThemeAttribute> *attributes;

/// 子样式用 key 加以标识。
@property (nonatomic, readonly, copy, nonnull) NSDictionary<NSString *, XZThemeStyle *> *substyles;



+ (instancetype)themeStyleWithConfiguration:(nonnull NSDictionary *)configuration NS_SWIFT_NAME(init(configuration:));
- (void)addAttributesAndSubstylesFromConfiguration:(NSDictionary * _Nonnull)configuration;


- (nullable XZThemeStyle *)substyleForKey:(NSString *)aKey;
- (void)setSubstyle:(nullable XZThemeStyle *)substyle forKey:(NSString *)aKey;


/**
 将另一个样式中的属性和子样式合并到当前样式中，相同的属性会覆盖，相同的子样式合并。

 @param style 待合并的样式。
 */
- (void)addAttributesAndSubstylesFromStyle:(XZThemeStyle *)style;

/**
 设置值时，使用 [NSNull null] 来代表需要设置为 nil 的样式，如果使用 nil 表示删除这个样式属性。
 
 @param value 待设置的值。
 @param attribute 待设置的属性。
 @param state 样式的状态。
 */
- (void)setValue:(nullable id)value forAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state;
- (void)setValue:(nullable id)value forAttribute:(XZThemeAttribute)attribute;

- (nullable id)valueForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state;
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
