//
//  XZThemeStyle.h
//  XZTheme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZThemeAttribute.h"
#import "XZThemeState.h"
#import "XZThemeStyleValueParser.h"

/// 主题样式，存储了对象主题属性相关配置。
NS_SWIFT_NAME(Theme.Style)
@interface XZThemeStyle<ObjectType> : NSObject

/// 主题样式中的所有已设置值的主题属性。
@property (nonatomic, copy, readonly, nonnull) NSArray<XZThemeAttribute> *themeAttributes;
@property (nonatomic, weak, readonly, nullable) ObjectType object;

- (nonnull instancetype)init NS_UNAVAILABLE;

/// 主题样式。
///
/// @param object 主题样式所属的对象。
/// @return 主题样式对象。
- (nonnull instancetype)initWithObject:(nonnull ObjectType)object NS_DESIGNATED_INITIALIZER NS_SWIFT_NAME(init(_:));

/// 主题样式是否包含主题属性。
/// @note 判断是否包含属性，不能使用 -valueForThemeAttribute: 方法。
///
/// @param themeAttribute 主题属性。
/// @return 是否包含。
- (BOOL)containsThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;

/// 添加/更新/删除主题属性值。
/// @note 使用 [NSNull null] 表示需要设置 nil 的主题属性。
///
/// @param value 主题属性值。
/// @param themeAttribute 主题属性。
- (void)setValue:(nullable id)value forThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;

/// 获取已设置的主题属性值。
/// @note 设置为 NSNull 的值，会返回 nil 。
///
/// @param themeAttribute 主题属性。
/// @return 主题属性值。
- (nullable id)valueForThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;

/// 获取已设置的主题属性值。
/// @note 角标获取值方式支持。
///
/// @param themeAttribute 主题属性。
/// @return 主题属性值。
- (nullable id)objectForKeyedSubscript:(nonnull XZThemeAttribute)themeAttribute;

/// 添加/更新/删除主题属性值。
/// @note 角标设置值方式支持。
/// @note 使用 [NSNull null] 表示需要设置 nil 的主题属性。
///
/// @param object 主题属性值。
/// @param themeAttribute 主题属性。
- (void)setObject:(nullable id)object forKeyedSubscript:(nonnull XZThemeAttribute)themeAttribute;

@end



@interface XZThemeStyle (XZExtendedThemeStyle)

/// 获取已设置的整数主题属性值。
/// @note 尝试调用 integerValue 方法，否则返回 0 。
/// @param themeAttribute 主题属性。
/// @return 属性值。
- (NSInteger)integerValueForThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;

/// 获取已设置的浮点数主题属性值。
/// @note 尝试调用 floatValue 方法，否则返回 0 。
/// @param themeAttribute 主题属性。
/// @return 属性值。
- (float)floatValueForThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;

/// 获取已设置的双浮点数主题属性值。
/// @note 尝试调用 doubleValue 方法，否则返回 0 。
/// @param themeAttribute 主题属性。
/// @return 属性值。
- (double)doubleValueForThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;

/// 获取已设置的主题属性布尔值。
/// @note 尝试调用 boolValue 方法，否则返回 0 。
/// @param themeAttribute 主题属性。
/// @return 属性值。
- (BOOL)boolValueForThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;

/// 获取已设置的主题属性值：字符串。
/// @note 使用 [XZThemeStyle stringParser] 来解析已存储的属性值。
/// @param themeAttribute 主题属性。
/// @return 属性值。
- (nullable NSString *)stringValueForThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;

/// 获取已设置的主题属性值：图片。
/// @note 使用 [XZThemeStyle imageParser] 来解析已存储的属性值。
/// @param themeAttribute 主题属性。
/// @return 属性值。
- (nullable UIImage *)imageForThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;

/// 获取已设置的主题属性值：颜色。
/// @note 使用 [XZThemeStyle colorParser] 来解析已存储的属性值。
/// @param themeAttribute 主题属性。
/// @return 属性值。
- (nullable UIColor *)colorForThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;

/// 获取已设置的主题属性值：字体。
/// @note 使用 [XZThemeStyle fontParser] 来解析已存储的属性值。
/// @param themeAttribute 主题属性。
/// @return 属性值。
- (nullable UIFont *)fontForThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;

/// 获取已设置的主题属性值：富文本。
/// @note 使用 [XZThemeStyle attributedStringParser] 来解析已存储的属性值。
/// @param themeAttribute 主题属性。
/// @return 属性值。
- (nullable NSAttributedString *)attributedStringForThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;

/// 获取已设置的主题属性值：富文本属性。
/// @note 使用 [XZThemeStyle stringAttributesParser] 来解析已存储的属性值。
/// @param themeAttribute 主题属性。
/// @return 属性值。
- (nullable NSDictionary<NSAttributedStringKey, id> *)stringAttributesForThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;

@end




@interface XZThemeStyle (ValueParser)

/// 将样式配置值转解析成字体。
/// 支持的配置格式：
/// @code
/// {font: "Arail"};                           // 自定义字体，字体名。
/// {font: 14.0}                               // 系统字体，字体大小。
/// {font: {"size": 14.0, "name": "Arail"}}    // 自定义字体，名称、大小。
/// {font: {"size": 14.0, "weight": 0 }}       // 系统字体，大小、字重。
/// @endcode
/// @note 该属性可写，更改其值即可自定义解析方式。
@property (class, nonnull, strong, nonatomic) XZThemeStyleValueParser<UIFont *> *fontParser NS_SWIFT_NAME(fontParser);

/// 将样式配置值转解析成颜色。
/// 支持的配置格式：
/// @code
/// {color: "#A1B2C3"};    // 字符串 RGB/RGBA
/// {color: 0xA2A2A3FF}    // 数值 RGBA
/// @endcode
/// @note 该属性可写，更改其值即可自定义解析方式。
/// @see UIColor+XZKit.h
@property (class, nonnull, strong, nonatomic) XZThemeStyleValueParser<UIColor *> *colorParser NS_SWIFT_NAME(colorParser);

/// 将样式配置值转解析成图像。
/// 支持的配置格式：
/// @code
/// {image: "imageName"}; // 单图
/// {image: {name: "imageName", duration: 2.5}}; // 动画
/// @endcode
/// @note 该属性可写，更改其值即可自定义解析方式。
@property (class, nonnull, strong, nonatomic) XZThemeStyleValueParser<UIImage *> *imageParser NS_SWIFT_NAME(imageParser);

/// 如果是字符串直接返回，否则返回其 description 。
/// @note 该属性可写，更改其值即可自定义解析方式。
@property (class, nonnull, strong, nonatomic) XZThemeStyleValueParser<NSString *> *stringParser NS_SWIFT_NAME(stringParser);

/// 将样式配置值转解析成富文本。
/// @note 支持 HTML 格式。
/// @note 该属性可写，更改其值即可自定义解析方式。
@property (class, nonnull, strong, nonatomic) XZThemeStyleValueParser<NSAttributedString *> *attributedStringParser NS_SWIFT_NAME(attributedStringParser);

/// 将样式配置值转解析成富文本属性字典。
/// 支持的格式：
/// @code
/// {
///     font: 14.0,                  // 更多格式参见 `XZThemeStyleParser.fontParser` 函数。
///     color: "#F1F2F3",            // 更多格式参见 `XZThemeStyleParser.colorParser` 函数。
///     backgroundColor: 0x12a13dff  // 更多格式参见 `XZThemeStyleParser.colorParser` 函数。
/// }
/// @endcode
/// @note 该属性可写，更改其值即可自定义解析方式。
/// @see XZThemeStyleParser.colorParser
/// @see XZThemeStyleParser.fontParser
@property (class, nonnull, strong, nonatomic) XZThemeStyleValueParser<NSDictionary<NSAttributedStringKey, id> *> *stringAttributesParser NS_SWIFT_NAME(stringAttributesParser);

@end




