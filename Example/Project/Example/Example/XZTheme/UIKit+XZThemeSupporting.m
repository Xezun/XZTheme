//
//  UIKit+XZThemeSupporting.m
//  Example
//
//  Created by 徐臻 on 2018/12/24.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import "UIKit+XZThemeSupporting.h"
#import <objc/runtime.h>
#import "XZTheme.h"

static const void * const _themeStyleSheetName = &_themeStyleSheetName;

@implementation UIView (XZThemeSupporting)

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
    // 如果已应用的主题与当前主题一致，不需要操作。
    // 如果视图没有配置过主题，但是不代表子视图没有配置主题。
    if ([[self xz_appliedTheme] isEqual:[XZTheme currentTheme]]) {
        return;
    }
    // MARK: 仅标记是否在显示效果上会延迟，待验证。
    [self xz_setNeedsThemeAppearanceUpdate];
}

- (NSString *)xz_themeStyleSheetName {
    return self.nextResponder.xz_themeStyleSheetName;
}

- (void)xz_forwardThemeAppearanceUpdate {
    for (UIView *subview in self.subviews) {
        [subview xz_setNeedsThemeAppearanceUpdate];
    }
}

@end

@implementation UIWindow (XZThemeSupporting)

- (NSString *)xz_themeStyleSheetName {
    // TODO: - 样式表默认名称待确认。
    return [NSBundle.mainBundle.infoDictionary objectForKeyedSubscript:@"Theme"];
}

@end

@implementation UINavigationItem (XZThemeSupporting)

- (NSString *)xz_themeStyleSheetName {
    return objc_getAssociatedObject(self, _themeStyleSheetName);
}

- (void)xz_forwardThemeAppearanceUpdate {
    [self.backBarButtonItem xz_setNeedsThemeAppearanceUpdate];
    
    NSArray<UIBarButtonItem *> *leftBarButtonItems = self.leftBarButtonItems;
    if (leftBarButtonItems.count > 0) {
        for (UIBarButtonItem *barButtonItem in leftBarButtonItems) {
            [barButtonItem xz_setNeedsThemeAppearanceUpdate];
        }
    }
    
    NSArray<UIBarButtonItem *> *rightBarButtonItems = self.rightBarButtonItems;
    if (rightBarButtonItems.count > 0) {
        for (UIBarButtonItem *barButtonItem in rightBarButtonItems) {
            [barButtonItem xz_setNeedsThemeAppearanceUpdate];
        }
    }
}

@end

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

- (NSString *)xz_themeStyleSheetName {
    // TODO: 在 Swift 环境中，此方法的返回值需验证。
    return NSStringFromClass(self.class);
}

- (void)xz_forwardThemeAppearanceUpdate {
    NSString * const themeStyleSheetName = self.xz_themeStyleSheetName;
    
    if (self.navigationController != nil) {
        [self.navigationItem xz_setNeedsThemeAppearanceUpdate];
        objc_setAssociatedObject(self.navigationItem, _themeStyleSheetName, themeStyleSheetName, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    if (self.tabBarController != nil) {
        [self.tabBarItem xz_setNeedsThemeAppearanceUpdate];
        objc_setAssociatedObject(self.tabBarItem, _themeStyleSheetName, themeStyleSheetName, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    NSArray<__kindof UIBarButtonItem *> *toolBarItems = self.toolbarItems;
    if (toolBarItems.count > 0) {
        for (UIBarButtonItem *toolBarItem in toolBarItems) {
            [toolBarItem xz_setNeedsThemeAppearanceUpdate];
            objc_setAssociatedObject(toolBarItem, _themeStyleSheetName, themeStyleSheetName, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
    }
    for (UIViewController *childVC in self.childViewControllers) {
        [childVC xz_setNeedsThemeAppearanceUpdate];
    }
    [self.presentedViewController xz_setNeedsThemeAppearanceUpdate];
}

@end
