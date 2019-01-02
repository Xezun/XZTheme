//
//  XZThemeStyle.h
//  Example
//
//  Created by 徐臻 on 2019/1/2.
//  Copyright © 2019 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZTheme.h"

NS_ASSUME_NONNULL_BEGIN

/// 主题样式。
NS_SWIFT_NAME(XZTheme.Style)
@interface XZThemeStyle : NSObject

/// 构造指定状态下的主题样式。
///
/// @param themeState 主题状态。
/// @return 主题样式 XZThemeStyle 对象。
+ (XZThemeStyle *)themeStyleForState:(XZThemeState)themeState NS_SWIFT_NAME(init(for:));
/// 给指定对象构造私有样式。
///
/// @param object 主题样式所属的对象。
/// @return 主题样式 XZThemeStyle 对象。
+ (XZThemeStyle *)themeStyleForObject:(NSObject *)object NS_SWIFT_NAME(init(for:));
/// 为对象构造指定状态下的主题样式。
///
/// @param themeState 主题状态。
/// @param object 主题样式所属的对象。
/// @return 主题样式 XZThemeStyle 对象。
+ (XZThemeStyle *)themeStyleForObject:(NSObject *)object forState:(XZThemeState)themeState NS_SWIFT_NAME(init(for:for:));

/// 主题状态。
@property (nonatomic, copy, readonly) XZThemeState state;
/// 主题属性与值。
@property (nonatomic, readonly) NSDictionary<XZThemeAttribute, id> *attributedStyleValues;

- (instancetype)init NS_UNAVAILABLE;

/// 获取主题属性对应的样式值。
///
/// @param themeAttribute 主题属性。
/// @return 主题样式值。
- (nullable id)valueForAttribute:(XZThemeAttribute)themeAttribute NS_SWIFT_NAME(value(for:));
/// 设置主题属性样式值。
///
/// @param value 主题样式值。
/// @param themeAttribute 主题属性。
- (void)setValue:(nullable id)value forAttribute:(XZThemeAttribute)themeAttribute NS_SWIFT_NAME(setValue(_:for:));

/// 获取主题属性对应的样式值。
///
/// @param themeAttribute 主题属性。
/// @return 主题样式值。
- (nullable id)objectForKeyedSubscript:(XZThemeAttribute)themeAttribute;
/// 设置主题属性样式值。
///
/// @param value 主题样式值。
/// @param themeAttribute 主题属性。
- (void)setObject:(nullable id)value forKeyedSubscript:(XZThemeAttribute)themeAttribute;

/// 主题样式中是否包含指定主题属性。
///
/// @param themeAttribute 主题属性。
/// @return 是否包含主题属性。
- (BOOL)containsAttribute:(XZThemeAttribute)themeAttribute NS_SWIFT_NAME(contains(_:));

/// 将另一个主题样式中的所有值复制到当前主题样式中。
///
/// @param themeStyle 被复制到主题样式。
- (void)addValuesFromThemeStyle:(nullable XZThemeStyle *)themeStyle NS_SWIFT_NAME(addValues(from:));

/// 获取指定主题状态下的主题样式。
///
/// @param themeState 主题状态。
/// @return 主题样式。
- (nullable XZThemeStyle *)themeStyleIfLoadedForState:(XZThemeState)themeState NS_SWIFT_NAME(themeStyleIfLoaded(for:));
/// 获取指定主题状态下的主题样式，懒加载。
///
/// @param themeState 主题状态。
/// @return 主题样式。
- (XZThemeStyle *)themeStyleForState:(XZThemeState)themeState NS_SWIFT_NAME(themeStyle(for:));

- (nullable id)valueForAttribute:(XZThemeAttribute)themeAttribute forState:(XZThemeState)themeState NS_SWIFT_NAME(value(for:for:));
- (void)setValue:(nullable id)value forAttribute:(XZThemeAttribute)themeAttribute forState:(XZThemeState)themeState NS_SWIFT_NAME(setValue(_:for:for:));

@end

NS_ASSUME_NONNULL_END
