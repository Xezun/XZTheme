//
//  ThemeStyle.h
//  Theme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZThemeDefines.h"
#import "XZThemeSupporting.h"

NS_ASSUME_NONNULL_BEGIN

/// 主题样式，存储了对象主题属性相关配置。
NS_SWIFT_NAME(Theme.Style)
@interface XZThemeStyle : NSObject

/// XZThemeStyle 所服务的对象。
@property (nonatomic, unsafe_unretained, readonly) id<XZThemeSupporting> object;

/// 主题样式中的所有已设置值的主题属性。
@property (nonatomic, copy, readonly) NSArray<XZThemeAttribute> *themeAttributes;

- (instancetype)init NS_UNAVAILABLE;

/// 主题样式。
///
/// @param object 主题样式所属的对象。
/// @return 主题样式对象。
- (instancetype)initWithObject:(id<XZThemeSupporting>)object NS_DESIGNATED_INITIALIZER NS_SWIFT_NAME(init(_:));

/// 主题样式是否包含主题属性。
/// @note 判断是否包含属性，不能使用 -valueForThemeAttribute: 方法。
///
/// @param themeAttribute 主题属性。
/// @return 是否包含。
- (BOOL)containsThemeAttribute:(XZThemeAttribute)themeAttribute;

/// 添加/更新/删除主题属性值。
/// @note 使用 [NSNull null] 表示需要设置 nil 的主题属性。
///
/// @param value 主题属性值。
/// @param themeAttribute 主题属性。
- (void)setValue:(nullable id)value forThemeAttribute:(XZThemeAttribute)themeAttribute;

/// 获取已设置的主题属性值。
/// @note 设置为 NSNull 的值，会返回 nil 。
///
/// @param themeAttribute 主题属性。
/// @return 主题属性值。
- (nullable id)valueForThemeAttribute:(XZThemeAttribute)themeAttribute;

/// 获取已设置的主题属性值。
/// @note 角标获取值方式支持。
///
/// @param themeAttribute 主题属性。
/// @return 主题属性值。
- (nullable id)objectForKeyedSubscript:(XZThemeAttribute)themeAttribute;

/// 添加/更新/删除主题属性值。
/// @note 角标设置值方式支持。
/// @note 使用 [NSNull null] 表示需要设置 nil 的主题属性。
///
/// @param object 主题属性值。
/// @param themeAttribute 主题属性。
- (void)setObject:(nullable id)object forKeyedSubscript:(XZThemeAttribute)themeAttribute;

@end

NS_ASSUME_NONNULL_END


