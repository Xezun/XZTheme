//
//  UIViewController+XZTheme.m
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "UIViewController+XZThemeSupporting.h"
#import "XZTheme.h"

@import ObjectiveC;
@import XZKit;

@implementation UIViewController (XZThemeSupporting)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class aClass = [UIViewController class];
        Method imp1 = class_getInstanceMethod(aClass, @selector(viewWillAppear:));
        Method imp2 = class_getInstanceMethod(aClass, @selector(XZTheme_viewWillAppear:));
        method_exchangeImplementations(imp1, imp2);
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
    if ([self xz_needsThemeAppearanceUpdate]) {
        return;
    }
    [super xz_setNeedsThemeAppearanceUpdate];
    
    if (self.navigationController != nil) {
        [self.navigationItem xz_setNeedsThemeAppearanceUpdate];
    }
    
    if (self.tabBarController != nil) {
        [self.tabBarItem xz_setNeedsThemeAppearanceUpdate];
    }
    
    for (UIBarButtonItem *toolBarItem in self.toolbarItems) {
        [toolBarItem xz_setNeedsThemeAppearanceUpdate];
    }
    
    for (UIViewController *childVC in self.childViewControllers) {
        [childVC xz_setNeedsThemeAppearanceUpdate];
    }
    
    [self.presentedViewController xz_setNeedsThemeAppearanceUpdate];
}



@end
