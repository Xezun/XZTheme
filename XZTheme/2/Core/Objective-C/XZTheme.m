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
            [window.rootViewController xz_setNeedsThemeAppearanceUpdate];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:XZThemeDidChangeNotification object:_currentTheme];
    }
}

- (instancetype)initWithObject:(NSObject *)object {
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
    themeStyles = [[XZThemeStyles alloc] initWithObject:self->_object];
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


//- (void)XZThemes_windowDidBecomeVisible:(NSNotification *)notification {
//    [self.object xz_setNeedsThemeAppearanceUpdate];
//}
//
//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIWindowDidBecomeVisibleNotification object:nil];
//}

@end






@implementation NSObject (XZThemeSupporting)

static const void * const _theme                       = &_theme;
static const void * const _appliedTheme                = &_appliedTheme;
static const void * const _needsThemeAppearanceUpdate  = &_needsThemeAppearanceUpdate;

- (XZThemes *)xz_themes {
    XZThemes *theme = objc_getAssociatedObject(self, _theme);
    if (theme != nil) {
        return theme;
    }
    theme = [[XZThemes alloc] initWithObject:self];
    objc_setAssociatedObject(self, _theme, theme, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 标记需要更新外观，凡是调用了此方法，主题都会更新一次。
    [self xz_setNeedsThemeAppearanceUpdate];
    return theme;
}

- (XZThemes *)xz_themesIfLoaded {
    return objc_getAssociatedObject(self, _theme);
}

- (XZTheme)xz_appliedTheme {
    return objc_getAssociatedObject(self, _appliedTheme);
}


- (BOOL)xz_forwardsThemeAppearanceUpdate {
    return YES;
}

- (BOOL)xz_needsThemeAppearanceUpdate {
    return [objc_getAssociatedObject(self, _needsThemeAppearanceUpdate) boolValue];
}


- (void)xz_setNeedsThemeAppearanceUpdate {
    if ([self xz_needsThemeAppearanceUpdate]) {
        return;
    }
    objc_setAssociatedObject(self, _needsThemeAppearanceUpdate, [NSNumber numberWithBool:YES], OBJC_ASSOCIATION_COPY_NONATOMIC);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self xz_updateThemeAppearanceIfNeeded];
    });
}

- (void)xz_updateThemeAppearanceIfNeeded {
    if (![self xz_needsThemeAppearanceUpdate]) {
        return;
    }
    objc_setAssociatedObject(self, _needsThemeAppearanceUpdate, [NSNumber numberWithBool:NO], OBJC_ASSOCIATION_COPY_NONATOMIC);
    XZTheme currentTheme = [XZThemes currentTheme];
    XZThemeStyles *themeStyles = [self.xz_themesIfLoaded themeStylesIfLoadedForTheme:currentTheme];
    if (themeStyles != nil) {
        [self xz_updateAppearanceWithThemeStyles:themeStyles];
    }
    objc_setAssociatedObject(self, _appliedTheme, currentTheme, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)xz_updateAppearanceWithThemeStyles:(XZThemeStyles *)themeStyles {
    
}

@end

