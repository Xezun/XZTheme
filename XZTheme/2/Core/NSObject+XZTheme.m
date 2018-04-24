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

@end




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
