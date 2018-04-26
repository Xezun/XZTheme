//
//  UIViewController+XZTheme.m
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "UIViewController+XZTheme.h"
#import "XZTheme.h"
@import ObjectiveC;
@import XZKit;

@implementation UIViewController (XZTheme)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method imp1 = class_getInstanceMethod(self, @selector(viewWillAppear:));
        Method imp2 = class_getInstanceMethod(self, @selector(XZTheme_viewWillAppear:));
        method_exchangeImplementations(imp1, imp2);
        
        Method imp3 = class_getInstanceMethod(self, @selector(preferredStatusBarStyle));
        Method imp4 = class_getInstanceMethod(self, @selector(XZTheme_preferredStatusBarStyle));
        method_exchangeImplementations(imp3, imp4);
    });
}



- (void)XZTheme_viewWillAppear:(BOOL)animated {
    [self XZTheme_viewWillAppear:animated];
    // 在控制器将要显示的时候，更新已应用的主题。
    // 这个时候，控制器还没有显示，如果这个时候，更改了主题，会触发一个异步再次更新主题。
    
    if ([self.xz_appliedTheme isEqual:[XZTheme currentTheme]]) {
        return;
    }
    [self xz_setNeedsThemeAppearanceUpdate];
}


- (void)xz_setNeedsThemeAppearanceUpdate {
    [super xz_setNeedsThemeAppearanceUpdate];
    
    for (UIViewController *childVC in self.childViewControllers) {
        [childVC xz_setNeedsThemeAppearanceUpdate];
    }
    
    [self.presentedViewController xz_setNeedsThemeAppearanceUpdate];
    
    [self.navigationItem xz_setNeedsThemeAppearanceUpdate];
    
    NSArray<UIBarButtonItem *> *toolbarItems = self.toolbarItems;
    if (toolbarItems.count > 0) {
        for (UIBarButtonItem *item in toolbarItems) {
            [item xz_setNeedsThemeAppearanceUpdate];
        }
    }
    
    [self.tabBarItem xz_setNeedsThemeAppearanceUpdate];
}

static const void * const _statusBarStyle = &_statusBarStyle;

- (UIStatusBarStyle)xz_statusBarStyle {
    NSNumber *number = objc_getAssociatedObject(self, _statusBarStyle);
    if (number != nil) {
        return [number integerValue];
    }
    // 如果没有保存值的话，返回的是原始的。
    return [self XZTheme_preferredStatusBarStyle];
}

- (void)xz_setStatusBarStyle:(UIStatusBarStyle)xz_statusBarStyle {
    objc_setAssociatedObject(self, _statusBarStyle, [NSNumber numberWithInteger:xz_statusBarStyle], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIStatusBarStyle)XZTheme_preferredStatusBarStyle {
    return [self xz_statusBarStyle];
}

@end
