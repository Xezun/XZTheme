//
//  UIViewController+XZTheme.m
//  XZKit
//
//  Created by mlibai on 2017/10/14.
//

#import "UIViewController+XZTheme.h"
#import <objc/runtime.h>
#import "XZTheme.h"


@implementation UIViewController (XZTheme)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method imp1 = class_getInstanceMethod(self, @selector(viewWillAppear:));
        Method imp2 = class_getInstanceMethod(self, @selector(XZTheme_viewWillAppear:));
        method_exchangeImplementations(imp1, imp2);
    });
}


- (void)XZTheme_viewWillAppear:(BOOL)animated {
    [self XZTheme_viewWillAppear:animated];
    // 在控制器将要显示的时候，更新已应用的主题。
    // 这个时候，控制器还没有显示，如果这个时候，更改了主题，会触发一个异步再次更新主题。
    if ([self.xz_appliedTheme isEqualToString:[XZThemes currentTheme]]) {
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

@end




