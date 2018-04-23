//
//  NSObject+XZTheme.m
//  XZKit
//
//  Created by mlibai on 2017/10/14.
//

#import "NSObject+XZTheme.h"
#import "XZTheme.h"
#import "Example-Swift.h"
@import ObjectiveC;

static const void * const _nameOfAppliedTheme     = &_nameOfAppliedTheme;
static const void * const _needsThemeAppearanceUpdate  = &_needsThemeAppearanceUpdate;


@implementation NSObject (XZTheme)

- (XZTheme)xz_appliedTheme {
    return objc_getAssociatedObject(self, _nameOfAppliedTheme);
}

- (void)xz_setNeedsThemeAppearanceUpdate {
    if ([objc_getAssociatedObject(self, _needsThemeAppearanceUpdate) boolValue]) {
        return;
    }
    objc_setAssociatedObject(self, _needsThemeAppearanceUpdate, [NSNumber numberWithBool:YES], OBJC_ASSOCIATION_RETAIN);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self xz_updateThemeAppearanceIfNeeded];
    });
}

- (void)xz_updateThemeAppearanceIfNeeded {
    if (![objc_getAssociatedObject(self, _needsThemeAppearanceUpdate) boolValue]) {
        return;
    }
    objc_setAssociatedObject(self, _needsThemeAppearanceUpdate, [NSNumber numberWithBool:NO], OBJC_ASSOCIATION_RETAIN);
    XZThemeStyle *themeStyle = [self.xz_themesIfLoaded styleForTheme:XZThemes.currentTheme];
    if (themeStyle != nil) {
        [self xz_updateAppearanceWithThemeStyle:themeStyle];
    }
    objc_setAssociatedObject(self, _nameOfAppliedTheme, XZThemes.currentTheme, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//- (void)xz_updateAppearanceWithThemeStyle:(XZThemeStyle *)themeStyle {
//    
//}

@end
