//
//  XZThemeManager.m
//  XZKit
//
//  Created by mlibai on 2017/12/11.
//  Copyright © 2017年 mlibai. All rights reserved.
//

#import "XZThemeManager.h"
#import "NSObject+XZTheme.h"
#import "XZTheme.h"

static NSString *const XZThemeNameDefault = @"default";

@interface XZThemeManager () {
    /// 主题缓存。以主题名字为 key 对主题进行缓存。
    NSMutableDictionary<NSString *, XZTheme *> *_cachedThemes;
}

@end

@implementation XZThemeManager

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 自动加载主题管理服务。
        [[XZThemeManager defaultManager] startService];
    });
}

+ (XZThemeManager *)defaultManager {
    static XZThemeManager *_defaultManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultManager = [[XZThemeManager alloc] init];
    });
    return _defaultManager;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _cachedThemes = [NSMutableDictionary dictionary];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didReceiveMemoryWarning:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

/**
 当收到内存警告时，释放非当前主题资源。

 @param notification 内存警告的通知。
 */
- (void)didReceiveMemoryWarning:(NSNotification *)notification {
    for (NSString *key in _cachedThemes.allKeys) {
        if ([key isEqualToString:_currentTheme.name]) {
            continue;
        }
        [_cachedThemes removeObjectForKey:key];
    }
}

@synthesize currentTheme = _currentTheme;

- (XZTheme *)currentTheme {
    if (_currentTheme != nil) {
        return _currentTheme;
    }
    XZTheme *currentTheme = [XZTheme themeNamed:XZThemeNameDefault];
    if (currentTheme == nil) {
        currentTheme = [[XZTheme alloc] initWithName:XZThemeNameDefault];
    }
    [self setCurrentTheme:currentTheme];
    return _currentTheme;
}

- (void)setCurrentTheme:(XZTheme *)currentTheme {
    if ([_currentTheme isEqualToTheme:currentTheme]) {
        return;
    }
    // save the theme.
    _currentTheme = currentTheme;
    [NSUserDefaults.standardUserDefaults setObject:currentTheme.name forKey:XZThemeUserDefaultsKey];
    // send events.
    for (UIWindow *window in UIApplication.sharedApplication.windows) {
        [window xz_setNeedsThemeApply];
        [window.rootViewController xz_setNeedsThemeApply];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:XZThemeDidChangeNotification object:_currentTheme];
}

- (void)startService {
    NSString *themeName = [[NSUserDefaults standardUserDefaults] stringForKey:XZThemeUserDefaultsKey];
    XZTheme *defaultTheme = nil;
    if (themeName != nil) {
        defaultTheme = [XZTheme themeNamed:themeName];
    } else {
        defaultTheme = [XZTheme themeNamed:XZThemeNameDefault];
    }
    if (defaultTheme == nil) {
        defaultTheme = [[XZTheme alloc] initWithName:XZThemeNameDefault];
    }
    [self setCurrentTheme:defaultTheme];
}

- (XZTheme *)themeForName:(NSString *)themeName {
    XZTheme *namedTheme = _cachedThemes[themeName];
    if (namedTheme != nil) {
        return namedTheme;
    }
    NSString *resourceName = [[NSBundle mainBundle].infoDictionary objectForKey:XZThemeBundleKey];
    if (![resourceName isKindOfClass:[NSString class]]) {
        NSLog(@"XZTheme 未找到主题配置，请使用 `%@` 键在 info.plist 中设置主题配置文件名。", XZThemeBundleKey);
        return nil;
    }
    NSString *resourcePath = [NSBundle.mainBundle pathForResource:resourceName ofType:nil];
    if (![resourcePath isKindOfClass:[NSString class]]) {
        NSLog(@"XZTheme 设定的主题配置文件 `%@` 没有找到，请检查  info.plist 中的设置。", resourceName);
        return nil;
    }
    NSDictionary *themeResource = nil;
    if ([resourceName.lowercaseString hasSuffix:@".plist"]) {
        themeResource = [NSDictionary dictionaryWithContentsOfFile:resourcePath];
    } else {
        NSData *data = [NSData dataWithContentsOfFile:resourcePath];
        if (data == nil) {
            NSLog(@"XZTheme 无法读取主题配置文件 `%@`（JSON 格式），目前支持 .json/.plist 格式文件。", resourcePath);
            return nil;
        }
        themeResource = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:NULL];
        if (![themeResource isKindOfClass:[NSDictionary class]]) {
            NSLog(@"XZTheme 无法解析主题配置文件 `%@` （JSON 格式），目前支持 .json/.plist 格式文件。", resourcePath);
            return nil;
        }
    }
    NSDictionary *configuration = themeResource[themeName];
    if (![configuration isKindOfClass:[NSDictionary class]]) {
        NSLog(@"XZTheme 在主题配置文件 `%@` 中没有找到名称为 `%@` 的主题配置信息，目前支持 .json/.plist 格式文件。", resourcePath, themeName);
        return nil;
    }
    namedTheme = [XZTheme themeWithName:themeName configuration:configuration];
    _cachedThemes[themeName] = namedTheme;
    return namedTheme;
}

- (void)setTheme:(XZTheme *)theme forName:(NSString *)themeName {
    _cachedThemes[themeName] = theme;
}

@end




