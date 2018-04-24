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

/// 主题样式，存储了对象主题属性相关配置。
NS_SWIFT_NAME(Theme.Style) @interface XZThemeStyle : NSObject

/// 主题样式中的所有已设置值的主题属性。
@property (nonatomic, copy, readonly, nonnull) NSArray<XZThemeAttribute> *themeAttributes;

/// 设置主题属性值。
/// @note 使用 [NSNull null] 表示需要设置 nil 的主题属性。
///
/// @param value 主题属性值。
/// @param themeAttribute 主题属性。
- (void)setValue:(nullable id)value forThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;

/// 获取已设置的主题属性值。
///
/// @param themeAttribute 主题属性。
/// @return 主题属性值。
- (nullable id)valueForThemeAttribute:(nonnull XZThemeAttribute)themeAttribute;

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







