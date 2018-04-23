//
//  UIView+XZTheme.m
//  XZKit
//
//  Created by mlibai on 2017/10/14.
//

#import "UIView+XZTheme.h"
#import <objc/runtime.h>
#import "XZTheme.h"

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
    
    // 判断主题是否发生改变
    if ([self.xz_appliedTheme isEqualToString:[XZThemes currentTheme]]) { return; }
    
    // 标记需要更新
    [self xz_setNeedsThemeAppearanceUpdate];
}

- (void)xz_setNeedsThemeAppearanceUpdate {
    [super xz_setNeedsThemeAppearanceUpdate];
    if (![self xz_shouldUpdateAppearanceForSubviews]) {
        return;
    }
    for (UIView *view in self.subviews) {
        [view xz_setNeedsThemeAppearanceUpdate];
    }
}

- (BOOL)xz_shouldUpdateAppearanceForSubviews {
    return YES;
}

@end
