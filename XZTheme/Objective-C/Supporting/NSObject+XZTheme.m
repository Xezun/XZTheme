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
static const void * const _needsThemeApply  = &_needsThemeApply;
static const void * const _themeIdentifier  = &_themeIdentifier;


@implementation NSObject (XZTheme)

// .themeIdentifier

- (void)xz_setThemeIdentifier:(XZThemeIdentifier)themeIdentifier {
    if (![[self xz_themeIdentifier] isEqualToString:themeIdentifier]) {
        objc_setAssociatedObject(self, _themeIdentifier, themeIdentifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
        [self xz_setNeedsThemeApply];
    }
}

- (XZThemeIdentifier)xz_themeIdentifier {
    return objc_getAssociatedObject(self, _themeIdentifier);
}

// .appliedTheme

- (XZTheme *)xz_nameOfAppliedTheme {
    return objc_getAssociatedObject(self, _nameOfAppliedTheme);
}

- (void)xz_setNeedsThemeApply {
    if ([objc_getAssociatedObject(self, _needsThemeApply) boolValue]) {
        return;
    }
    objc_setAssociatedObject(self, _needsThemeApply, [NSNumber numberWithBool:YES], OBJC_ASSOCIATION_RETAIN);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self xz_applyThemeIfNeeded];
    });
}

- (void)xz_applyThemeIfNeeded {
    if (![objc_getAssociatedObject(self, _needsThemeApply) boolValue]) {
        return;
    }
    objc_setAssociatedObject(self, _needsThemeApply, [NSNumber numberWithBool:NO], OBJC_ASSOCIATION_RETAIN);
    XZTheme *currentTheme = [XZTheme currentTheme];
    [self xz_updateAppearanceWithTheme:currentTheme];
    objc_setAssociatedObject(self, _nameOfAppliedTheme, currentTheme.name, OBJC_ASSOCIATION_RETAIN);
}

- (void)xz_updateAppearanceWithTheme:(XZTheme *)theme {
    NSString *themeIdentifier = [self xz_themeIdentifier];
    if (themeIdentifier == nil) { return; }
    XZThemeStyle *style = [theme styleForIdentifier:themeIdentifier];
    if (style == nil) { return; }
    [self xz_updateAppearanceWithThemeStyle:style];
}

@end
