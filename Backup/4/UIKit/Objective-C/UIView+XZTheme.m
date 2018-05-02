//
//  UIView+XZTheme.m
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "UIView+XZTheme.h"

@import ObjectiveC;

@implementation UIView (XZTheme)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [UIView class];
        Method m1 = class_getInstanceMethod(cls, @selector(willMoveToSuperview:));
        Method m2 = class_getInstanceMethod(cls, @selector(XZTheme_willMoveToSuperview:));
        method_exchangeImplementations(m1, m2);
    });
}

- (void)XZTheme_willMoveToSuperview:(nullable UIView *)newSuperview {
    [self XZTheme_willMoveToSuperview:newSuperview];
    
    // 不在父视图上的控件没有显示，不需要操作。
    if (newSuperview == nil) { return; }
    // 如果视图没有配置过主题，不需要操作。
    if (self.xz_themesIfLoaded == nil) { return; }
    // 如果已应用的主题与当前主题一致，不需要操作。
    if ([self.xz_appliedTheme isEqual:[XZTheme currentTheme]]) {
        return;
    }
    // TODO: 仅标记是否在显示效果上会延迟，待验证。
    [self xz_setNeedsThemeAppearanceUpdate];
}

- (void)xz_setNeedsThemeAppearanceUpdate {
    if ([self xz_needsThemeAppearanceUpdate]) {
        // 如果当前 runloop 内已标记过，就不需要再标记了。
        return;
    }
    [super xz_setNeedsThemeAppearanceUpdate];
    
    if (![self xz_forwardsThemeAppearanceUpdate]) {
        return;
    }
    
    for (UIView *subview in self.subviews) {
        [subview xz_setNeedsThemeAppearanceUpdate];
    }
}

@end



