//
//  XZThemeCollection.h
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZThemeDefines.h"
#import "XZThemeSupporting.h"
#import "Example-Swift.h"

@class XZTheme, XZThemeStyleCollection;

NS_ASSUME_NONNULL_BEGIN

/// XZThemeSet 是 XZTheme 的集合，它管理了对象所支持的主题和样式配置。
NS_SWIFT_NAME(Theme.Collection)
XZ_THEME_FINAL_CLASS
@interface XZThemeCollection : NSObject

/// 当前 XZThemeCollection 所属的对象。
/// @note 因为运行时的值绑定机制，被绑定的值生命周期可能比对象的生命周期长，所以使用 weak 属性。
@property (nonatomic, unsafe_unretained, readonly, nonnull) id<XZThemeSupporting> object;
/// 所有已配置样式的主题。
@property (nonatomic, copy, readonly, nonnull) NSArray<XZTheme *> *themes;

- (instancetype)init NS_UNAVAILABLE;

/// XZThemeSet 初始化时，需指定其所属的对象。
/// @note 主题样式发生改变时，将会触发主题相关方法。
///
/// @param object 主题所属的对象。
/// @return XZThemeSet 对象。
- (instancetype)initWithObject:(id<XZThemeSupporting>)object NS_DESIGNATED_INITIALIZER NS_SWIFT_NAME(init(_:));

/// 获取已设置的主题样式。
/// @note 懒加载，如果主题对应的样式不存在，则会自动创建一个空的主题样式对象。
///
/// @param theme 主题。
/// @return 主题样式。
- (XZThemeStyleCollection *)themeStylesForTheme:(XZTheme *)theme;

/// 设置主题样式。
///
/// @param themeStyles 主题样式。
/// @param theme 主题。
- (void)setThemeStyles:(XZThemeStyleCollection *)themeStyles forTheme:(XZTheme *)theme;

/// 获取已设置的主题样式（如果有）。
///
/// @param theme 主题。
/// @return 主题样式。
- (nullable XZThemeStyleCollection *)themeStylesIfLoadedForTheme:(XZTheme *)theme;

@end


@interface XZThemeCollection (XZExtendedThemeCollection)

/// 获取默认主题的样式的快捷方法。
/// @note 该方法等同于调用 -themeStyleForTheme: 方法。
@property (nonatomic, nonnull, readonly) XZThemeStyleCollection *defaultThemeStyles NS_SWIFT_NAME(default);

@end

NS_ASSUME_NONNULL_END
