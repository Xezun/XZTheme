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
    
    // 不在父视图上的控件没有显示，不需要配置主题。
    if (newSuperview == nil) { return; }
    
    if (![self.xz_appliedTheme isEqualToString:[XZThemes currentTheme]]) {
        // TODO: 仅标记是否在显示效果上会延迟，待验证。
        [self xz_setNeedsThemeAppearanceUpdate];
    }
    
}

- (void)xz_setNeedsThemeAppearanceUpdate {
    [super xz_setNeedsThemeAppearanceUpdate];
    
    if (![self xz_forwardsThemeAppearanceUpdate]) {
        return;
    }
    
    for (UIView *subview in self.subviews) {
        [subview xz_setNeedsThemeAppearanceUpdate];
    }
}

@end



