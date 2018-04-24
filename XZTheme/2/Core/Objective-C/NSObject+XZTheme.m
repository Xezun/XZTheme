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

static const void * const _nameOfAppliedTheme          = &_nameOfAppliedTheme;
static const void * const _needsThemeAppearanceUpdate  = &_needsThemeAppearanceUpdate;


@implementation NSObject (XZTheme)

- (XZTheme)xz_appliedTheme {
    return objc_getAssociatedObject(self, _nameOfAppliedTheme);
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
    objc_setAssociatedObject(self, _nameOfAppliedTheme, currentTheme, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)xz_updateAppearanceWithThemeStyles:(XZThemeStyles *)themeStyles {
    
}

@end








