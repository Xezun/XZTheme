//
//  XZTheme.m
//  XZTheme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZTheme.h"
#import "XZThemeStyle.h"
#import "XZThemeStyles.h"
#import "NSObject+XZTheme.h"
@import ObjectiveC;


XZTheme            const _Nonnull XZThemeDefault                = @"default";
NSNotificationName const _Nonnull XZThemeDidChangeNotification  = @"com.mlibai.XZKit.theme.changed";
NSString         * const _Nonnull XZThemeUserDefaultsKey        = @"com.mlibai.XZKit.theme.default";


static XZTheme _Nonnull _currentTheme = XZThemeDefault;

@implementation XZThemes {
    NSMutableDictionary<XZTheme, XZThemeStyles *> *_themedStyles;
}

+ (XZTheme)currentTheme {
    return _currentTheme;
}

+ (void)setCurrentTheme:(XZTheme)currentTheme {
    if (![_currentTheme isEqualToString:currentTheme]) {
        _currentTheme = [currentTheme copy];
        
        [NSUserDefaults.standardUserDefaults setObject:_currentTheme forKey:XZThemeUserDefaultsKey];
        // send events.
        for (UIWindow *window in UIApplication.sharedApplication.windows) {
            // 当前正显示的视图，立即更新视图。方便设置动画渐变效果。
            [window xz_setNeedsThemeAppearanceUpdate];
            [window xz_updateThemeAppearanceIfNeeded];
            [window.rootViewController xz_setNeedsThemeAppearanceUpdate];
            [window.rootViewController xz_updateThemeAppearanceIfNeeded];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:XZThemeDidChangeNotification object:_currentTheme];
    }
}

- (instancetype)initWithObject:(UIView *)object {
    self = [super init];
    if (self != nil) {
        _object = object;
        _themedStyles = [NSMutableDictionary dictionary];
    }
    return self;
}

- (XZThemeStyles *)themeStylesForTheme:(XZTheme)theme {
    XZThemeStyles *themeStyles = _themedStyles[theme];
    if (themeStyles != nil) {
        return themeStyles;
    }
    themeStyles = [[XZThemeStyles alloc] init];
    _themedStyles[theme] = themeStyles;
    return themeStyles;
}

- (void)setThemeStyles:(XZThemeStyles *)themeStyles forTheme:(XZTheme)theme {
    _themedStyles[theme] = themeStyles;
}

- (XZThemeStyles *)themeStylesIfLoadedForTheme:(XZTheme)theme {
    return _themedStyles[theme];
}

- (XZThemeStyles *)defaultThemeStyles {
    return [self themeStylesForTheme:XZThemeDefault];
}

@end






@implementation NSObject (XZThemeSupporting)

static const void * const _theme = &_theme;

- (XZThemes *)xz_themes {
    XZThemes *theme = objc_getAssociatedObject(self, _theme);
    if (theme != nil) {
        return theme;
    }
    theme = [[XZThemes alloc] initWithObject:self];
    objc_setAssociatedObject(self, _theme, theme, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return theme;
}

- (XZThemes *)xz_themesIfLoaded {
    return objc_getAssociatedObject(self, _theme);
}

@end




