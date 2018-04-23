//
//  XZThemeManager.h
//  XZKit
//
//  Created by mlibai on 2017/12/11.
//  Copyright © 2017年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XZTheme;


/// 内部类：负责主题的加载、缓存、回收。
/// @note XZThemeManager 在 +load 时自动启动，并调用 -startService 方法。
@interface XZThemeManager : NSObject

@property (class, nonatomic, readonly, nonnull) XZThemeManager *defaultManager;

/// 初始化时为 emptyTheme ，start 之后可能发生改变。
@property (nonatomic, nonnull) XZTheme *currentTheme;

/// XZThemeManager 在加载完后自动调用 startService 方法。
+ (void)load;

/// 加载主题服务，从 NSUserDefaults 中读取已保存的主题并应用。
/// @note 如果没有保存主题，则尝试读取 Default 主题。
/// @note 如果没有配置 Default 主题，则创建一个空的 Default 主题。
/// @note 应该确保此方法只被调用一次。
- (void)startService;
/// 获取指定名称的主题对象，首先从缓存获取，然后从 配置文件 读取。
- (nullable XZTheme *)themeForName:(nonnull NSString *)themeName;
- (void)setTheme:(nullable XZTheme *)theme forName:(nonnull NSString *)themeName;

@end
