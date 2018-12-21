//
//  NSObject+XZTheme.m
//  Example
//
//  Created by 徐臻 on 2018/12/21.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import "NSObject+XZTheme.h"
#import <objc/runtime.h>
#import "XZTheme.h"
#import "XZThemeStyle.h"

static const void * const _themeIdentifier = &_themeIdentifier;
static const void * const _appliedTheme = &_appliedTheme;
static const void * const _needsUpdateThemeAppearance = &_needsUpdateThemeAppearance;
static const void * const _computedThemeStyle = &_computedThemeStyle;

@implementation NSObject (XZTheme)

- (XZThemeIdentifier)xz_themeIdentifier {
    return objc_getAssociatedObject(self, _themeIdentifier);
}

- (void)xz_setThemeIdentifier:(XZThemeIdentifier)xz_themeIdentifier {
    objc_setAssociatedObject(self, _themeIdentifier, xz_themeIdentifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (XZTheme *)xz_appliedTheme {
    return objc_getAssociatedObject(self, _appliedTheme);
}

- (BOOL)xz_forwardsThemeAppearanceUpdate {
    return true;
}

- (BOOL)xz_needsUpdateThemeAppearance {
    return objc_getAssociatedObject(self, _needsUpdateThemeAppearance);
}

- (void)xz_setNeedsThemeAppearanceUpdate {
    if ([self xz_needsUpdateThemeAppearance]) {
        return;
    }
    objc_setAssociatedObject(self, _needsUpdateThemeAppearance, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self xz_updateThemeAppearanceIfNeeded];
    });
}

- (void)xz_updateThemeAppearanceIfNeeded {
    if ([self xz_needsUpdateThemeAppearance]) {
        objc_setAssociatedObject(self, _needsUpdateThemeAppearance, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        XZTheme *newTheme = [XZTheme currentTheme];
        if (![[self xz_appliedTheme] isEqualToTheme:newTheme]) {
            // 主题发生改变，重置计算样式。
            objc_setAssociatedObject(self, _computedThemeStyle, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [self xz_updateAppearanceWithTheme:newTheme];
        objc_setAssociatedObject(self, _appliedTheme, newTheme, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)xz_updateAppearanceWithTheme:(XZTheme *)newTheme {
    XZThemeStyle *computedThemeStyle = objc_getAssociatedObject(self, _computedThemeStyle);
    if (computedThemeStyle == nil) {
        // 1. XZSS样式
        XZThemeStyle *themeStyle1 = nil;
        // 2. 全局样式
        XZThemeStyle *themeStyle2 = nil;
        // 3. 私有样式
        XZThemeStyle *themeStyle3 = nil;
        // 4. 默认主题样式
        XZThemeStyle *themeStyle4 = nil;
        // 5. 计算样式
        if (themeStyle1 != nil || themeStyle2 != nil || themeStyle3 != nil || themeStyle4 != nil) {
            computedThemeStyle = [XZThemeStyle themeStyleForObject:self];
            [computedThemeStyle addValuesFromThemeStyle:themeStyle1];
            [computedThemeStyle addValuesFromThemeStyle:themeStyle2];
            [computedThemeStyle addValuesFromThemeStyle:themeStyle3];
            objc_setAssociatedObject(self, _computedThemeStyle, computedThemeStyle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [self xz_updateAppearanceWithThemeStyle:computedThemeStyle];
        } else {
            objc_setAssociatedObject(self, _computedThemeStyle, [NSNull null], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    } else if ([computedThemeStyle isKindOfClass:[XZThemeStyle class]]) {
        [self xz_updateAppearanceWithThemeStyle:computedThemeStyle];
    }
}

- (void)xz_updateAppearanceWithThemeStyle:(XZThemeStyle *)themeStyle {
    
}


- (XZThemeStyle *)xz_computedThemeStyle {
    XZThemeStyle *themeStyle = objc_getAssociatedObject(self, _computedThemeStyle);
    if ([themeStyle isKindOfClass:[XZThemeStyle class]]) {
        return themeStyle;
    }
    return nil;
}

@end
