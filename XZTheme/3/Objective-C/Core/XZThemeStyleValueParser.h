//
//  XZThemeStyleValueParser.h
//  XZKit
//
//  Created by mlibai on 2017/12/21.
//  Copyright © 2017年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZThemeStyle.h"

/// 主题属性值解析。
/// - 该类用于派生子类，不可直接实例化使用。
NS_SWIFT_NAME(XZThemeStyle.ValueParser) @interface XZThemeStyleValueParser<T: id>: NSObject

/**
 解析主题属性值。
 @note 子类应该继承并重写此方法。
 
 @param value 待解析的主题属性值。
 @return 解析后的值。
 */
- (nullable T)parse:(nullable id)value;

@end


@interface XZThemeStyle (Parser)


/**
 将样式配置值转解析成字体。
 支持的配置格式：
 @code
 {font: "Arail"};                           // 自定义字体，字体名。
 {font: 14.0}                               // 系统字体，字体大小。
 {font: {"size": 14.0, "name": "Arail"}}    // 自定义字体，名称、大小。
 {font: {"size": 14.0, "weight": 0 }}       // 系统字体，大小、字重。
 @endcode
 @note 该属性可写，更改其值即可自定义解析方式。
 */
@property (class, nonnull, strong, nonatomic) XZThemeStyleValueParser<UIFont *> *fontParser NS_SWIFT_NAME(fontParser);

/**
 将样式配置值转解析成颜色。
 支持的配置格式：
 @code
 {color: "#A1B2C3"};    // 字符串 RGB/RGBA
 {color: 0xA2A2A3FF}    // 数值 RGBA
 @endcode
 @note 该属性可写，更改其值即可自定义解析方式。
 @see UIColor+XZKit.h
 */
@property (class, nonnull, strong, nonatomic) XZThemeStyleValueParser<UIColor *> *colorParser NS_SWIFT_NAME(colorParser);

/**
 将样式配置值转解析成图像。
 支持的配置格式：
 @code
 {image: "imageName"}; // 单图
 {image: {name: "imageName", duration: 2.5}}; // 动画
 @endcode
 @note 该属性可写，更改其值即可自定义解析方式。
 */
@property (class, nonnull, strong, nonatomic) XZThemeStyleValueParser<UIImage *> *imageParser NS_SWIFT_NAME(imageParser);

/**
 如果是字符串直接返回，否则返回其 description 。
 @note 该属性可写，更改其值即可自定义解析方式。
 */
@property (class, nonnull, strong, nonatomic) XZThemeStyleValueParser<NSString *> *stringParser NS_SWIFT_NAME(stringParser);

/**
 将样式配置值转解析成富文本。
 @note 支持 HTML 格式。
 @note 该属性可写，更改其值即可自定义解析方式。
 */
@property (class, nonnull, strong, nonatomic) XZThemeStyleValueParser<NSAttributedString *> *attributedStringParser NS_SWIFT_NAME(attributedStringParser);

/**
 * 将样式配置值转解析成富文本属性字典。
 * 支持的格式：
 * @code
 * {
 *     font: 14.0,                  // 更多格式参见 `XZThemeStyleParser.fontParser` 函数。
 *     color: "#F1F2F3",            // 更多格式参见 `XZThemeStyleParser.colorParser` 函数。
 *     backgroundColor: 0x12a13dff  // 更多格式参见 `XZThemeStyleParser.colorParser` 函数。
 * }
 * @endcode
 * @note 该属性可写，更改其值即可自定义解析方式。
 * @see XZThemeStyleParser.colorParser
 * @see XZThemeStyleParser.fontParser
 */
@property (class, nonnull, strong, nonatomic) XZThemeStyleValueParser<NSDictionary<NSAttributedStringKey, id> *> *stringAttributesParser NS_SWIFT_NAME(stringAttributesParser);

@end

