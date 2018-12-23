//
//  NSObject+XZThemeSupporting.m
//  Example
//
//  Created by 徐臻 on 2018/12/21.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import "NSObject+XZThemeSupporting.h"
#import <objc/runtime.h>
#import "XZTheme.h"
#import "XZThemeStyle.h"
#import "XZThemeStyleSheet.h"

static const void * const _themeIdentifier = &_themeIdentifier;
static const void * const _appliedTheme = &_appliedTheme;
static const void * const _needsUpdateThemeAppearance = &_needsUpdateThemeAppearance;
static const void * const _computedThemeStyle = &_computedThemeStyle;
static const void * const _themedStyles = &_themedStyles;

@implementation NSObject (XZThemeSupporting)

- (XZThemeIdentifier)xz_themeIdentifier {
    return objc_getAssociatedObject(self, _themeIdentifier);
}

- (void)xz_setThemeIdentifier:(XZThemeIdentifier)xz_themeIdentifier {
    objc_setAssociatedObject(self, _themeIdentifier, xz_themeIdentifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (XZTheme *)xz_appliedTheme {
    return objc_getAssociatedObject(self, _appliedTheme);
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

- (void)xz_forwardThemeAppearanceUpdate {
    
}

- (void)xz_updateThemeAppearanceIfNeeded {
    if ([self xz_needsUpdateThemeAppearance]) {
        objc_setAssociatedObject(self, _needsUpdateThemeAppearance, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        XZTheme *newTheme = [XZTheme currentTheme];
        if (![[self xz_appliedTheme] isEqualToTheme:newTheme]) {
            // 主题发生改变，重置计算样式。
            // TODO: 当主题样式发生改变时，也需要改变计算样式。
            objc_setAssociatedObject(self, _computedThemeStyle, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [self xz_updateAppearanceWithTheme:newTheme];
        objc_setAssociatedObject(self, _appliedTheme, newTheme, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)xz_updateAppearanceWithTheme:(XZTheme *)newTheme {
    // TODO: - 计算样式根据对象类型与标识符进行缓存，以避免重复生成计算样式。
    XZThemeStyle *computedThemeStyle = objc_getAssociatedObject(self, _computedThemeStyle);
    if (computedThemeStyle == nil) {
        // 1. XZSS样式
        XZThemeStyle *themeStyle1 = [[newTheme themeStyleSheetForObject:self] themeStyleForObject:self];
        // 2. 全局样式
        XZThemeStyle *themeStyle2 = [self.class xz_themeStyleIfLoadedForTheme:newTheme];
        // 3. 私有样式
        XZThemeStyle *themeStyle3 = [self xz_themeStyleIfLoadedForTheme:newTheme];
        // 4. 默认主题样式，xzss 样式在读取时，已包含默认主题样式。
        XZThemeStyle *themeStyle4 = nil;
        if (![newTheme isEqualToTheme:[XZTheme defaultTheme]]) {
            XZThemeStyle *themeStyle1 = [self.class xz_themeStyleIfLoadedForTheme:[XZTheme defaultTheme]];
            XZThemeStyle *themeStyle2 = [self xz_themeStyleIfLoadedForTheme:[XZTheme defaultTheme]];
            if (themeStyle1 != nil || themeStyle2 != nil) {
                themeStyle4 = [XZThemeStyle themeStyleForObject:self];
                [themeStyle4 addValuesFromThemeStyle:themeStyle1];
                [themeStyle4 addValuesFromThemeStyle:themeStyle2];
            }
        }
        // 5. 计算样式
        if (themeStyle1 != nil || themeStyle2 != nil || themeStyle3 != nil) {
            if (themeStyle4 != nil) {
                computedThemeStyle = themeStyle4;
            } else {
                computedThemeStyle = [XZThemeStyle themeStyleForObject:self];
            }
            [computedThemeStyle addValuesFromThemeStyle:themeStyle1];
            [computedThemeStyle addValuesFromThemeStyle:themeStyle2];
            [computedThemeStyle addValuesFromThemeStyle:themeStyle3];
            objc_setAssociatedObject(self, _computedThemeStyle, computedThemeStyle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [self xz_updateAppearanceWithThemeStyle:computedThemeStyle];
        } else if (themeStyle4 != nil) {
            objc_setAssociatedObject(self, _computedThemeStyle, themeStyle4, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [self xz_updateAppearanceWithThemeStyle:themeStyle4];
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


- (XZThemeStyle *)xz_themeStyleForTheme:(XZTheme *)theme {
    NSMutableDictionary<XZTheme *, XZThemeStyle *> *themedStyles = objc_getAssociatedObject(self, _themedStyles);
    if (themedStyles == nil) {
        themedStyles = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _themedStyles, themedStyles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    XZThemeStyle *themeStyle = themedStyles[theme];
    themedStyles[theme] = themeStyle;
    return themeStyle;
}

- (XZThemeStyle *)xz_themeStyleIfLoadedForTheme:(XZTheme *)theme {
    NSDictionary<XZTheme *, XZThemeStyle *> *themedStyles = objc_getAssociatedObject(self, _themedStyles);
    return themedStyles[theme];
}

+ (XZThemeStyle *)xz_themeStyleForTheme:(XZTheme *)theme {
    NSMutableDictionary<XZTheme *, XZThemeStyle *> *themedStyles = objc_getAssociatedObject(self, _themedStyles);
    if (themedStyles == nil) {
        themedStyles = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _themedStyles, themedStyles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    XZThemeStyle *themeStyle = themedStyles[theme];
    themedStyles[theme] = themeStyle;
    return themeStyle;
}

+ (XZThemeStyle *)xz_themeStyleIfLoadedForTheme:(XZTheme *)theme {
    NSDictionary<XZTheme *, XZThemeStyle *> *themedStyles = objc_getAssociatedObject(self, _themedStyles);
    return themedStyles[theme];
}

- (NSString *)xz_styleSheetName {
    return nil;
}

@end
