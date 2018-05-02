//
//  NSObject+XZThemeSupporting.m
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "NSObject+XZThemeSupporting.h"
#import <objc/runtime.h>
#import "XZThemeDefines.h"
#import "XZTheme.h"
#import "XZThemeCollection.h"
#import "Example-Swift.h"

static const void * const _themes                      = &_themes;
static const void * const _appliedTheme                = &_appliedTheme;
static const void * const _needsThemeAppearanceUpdate  = &_needsThemeAppearanceUpdate;


@implementation NSObject (XZThemeSupporting)

- (XZThemeCollection *)xz_themes {
    XZThemeCollection *theme = objc_getAssociatedObject(self, _themes);
    if (theme != nil) {
        return theme;
    }
    theme = [[XZThemeCollection alloc] initWithObject:self];
    objc_setAssociatedObject(self, _themes, theme, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 标记需要更新外观，凡是调用了此方法，主题都会更新一次。
    [self xz_setNeedsThemeAppearanceUpdate];
    return theme;
}

- (XZThemeCollection *)xz_themesIfLoaded {
    return objc_getAssociatedObject(self, _themes);
}

- (XZTheme *)xz_appliedTheme {
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
    XZTheme *currentTheme = [XZTheme currentTheme];
    [self xz_updateAppearanceWithTheme:currentTheme];
    objc_setAssociatedObject(self, _appliedTheme, currentTheme, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)xz_updateAppearanceWithTheme:(XZTheme *)newTheme {
    XZThemeCollection *themes = [self xz_themesIfLoaded];
    // 如果没有配置主题，不执行操作。
    if (themes == nil) {
        return;
    }
    XZThemeStyleCollection *themeStyles = [themes themeStylesIfLoadedForTheme:newTheme];
    // 配置了主题，但是无当前主题配置，应用默认主题。
    if (themeStyles == nil && ![newTheme isEqual:XZTheme.defaultTheme]) {
        themeStyles = [themes themeStylesIfLoadedForTheme:XZTheme.defaultTheme];
    }
    // 默认主题也没有配置。
    if (themeStyles == nil) {
        return;
    }
    // 应用主题样式。
    [self xz_updateAppearanceWithThemeStyles:themeStyles];
}

- (void)xz_updateAppearanceWithThemeStyles:(XZThemeStyleCollection *)themeStyles {
    
}

@end
