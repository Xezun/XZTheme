//
//  XZTheme.m
//  Example
//
//  Created by 徐臻 on 2018/12/21.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import "XZTheme.h"
#import <objc/runtime.h>
#import "XZThemeStyle.h"
#import "XZThemeStyleSheet.h"

XZThemeState const XZThemeStateNone = @"";

static const void * const _themeIdentifier = &_themeIdentifier;
static const void * const _appliedTheme = &_appliedTheme;
static const void * const _needsUpdateThemeAppearance = &_needsUpdateThemeAppearance;
static const void * const _computedThemeStyle = &_computedThemeStyle;
static const void * const _themedStyles = &_themedStyles;

@implementation XZTheme {
    NSMutableDictionary<NSString *, id> *_keyedStyleSheets;
}

+ (XZTheme *)defaultTheme {
    static XZTheme *_defaultTheme = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultTheme = [XZTheme themeNamed:@"default"];
    });
    return _defaultTheme;
}

+ (XZTheme *)currentTheme {
    return nil;
}

+ (NSMutableDictionary<NSString *, XZTheme *> *)namedThemes {
    static NSMutableDictionary<NSString *, XZTheme *> *_namedThemes = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _namedThemes = [NSMutableDictionary dictionary];
    });
    return _namedThemes;
}

+ (XZTheme *)themeNamed:(NSString *)name {
    XZTheme *newTheme = [[XZTheme namedThemes] objectForKeyedSubscript:name];
    if (newTheme != nil) {
        return newTheme;
    }
    newTheme = [[XZTheme alloc] initWithName:name];
    [[XZTheme namedThemes] setObject:newTheme forKey:name];
    return newTheme;
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self != nil) {
        _name = name.copy;
        _keyedStyleSheets = [NSMutableDictionary dictionary];
    }
    return self;
}

- (BOOL)isEqualToTheme:(XZTheme *)otherTheme {
    if (self == otherTheme) {
        return YES;
    }
    return [_name isEqualToString:otherTheme.name];
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:XZTheme.class]) {
        return [self isEqualToTheme:(XZTheme *)object];
    }
    return NO;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (XZThemeStyleSheet *)themeStyleSheetForObject:(NSObject *)object {
    NSString *sheetName = object.xz_themeStyleSheetName;
    if (sheetName == nil) {
        return nil;
    }
    NSBundle *currentBundle = [NSBundle bundleForClass:object.class];
    NSURL *sheetURL1 = [currentBundle URLForResource:sheetName withExtension:@"xzss"]; // xzss in class bundle
    NSURL *sheetURL2 = nil; // xzss in main bundle
    if ([NSBundle.mainBundle isEqual:currentBundle]) {
        sheetURL2 = sheetURL1;
        sheetURL1 = nil;
    } else {
       sheetURL2 = [NSBundle.mainBundle URLForResource:sheetName withExtension:@"xzss"];
    }
    NSString *sheetKey = [NSString stringWithFormat:@"%@|%@", sheetURL1.absoluteString, sheetURL2.absoluteString];
    XZThemeStyleSheet *styleSheet = _keyedStyleSheets[sheetKey];
    if (styleSheet == nil) {
        if (sheetURL1 != nil) {
            styleSheet = [[XZThemeStyleSheet alloc] initWithURL:sheetURL1];
        }
        if (styleSheet != nil) {
            [styleSheet addThemeStylesFromThemeStyleSheet:[[XZThemeStyleSheet alloc] initWithURL:sheetURL2]];
        } else {
            styleSheet = [[XZThemeStyleSheet alloc] initWithURL:sheetURL2];
        }
        _keyedStyleSheets[sheetKey] = (styleSheet == nil ? NSNull.null : styleSheet);
    } else if (![styleSheet isKindOfClass:[XZThemeStyleSheet class]]) {
        styleSheet = nil;
    }
    return styleSheet;
}

@end



@implementation NSObject (XZTheme)

- (XZThemeIdentifier)xz_themeIdentifier {
    return objc_getAssociatedObject(self, _themeIdentifier);
}

- (void)xz_setThemeIdentifier:(XZThemeIdentifier)xz_themeIdentifier {
    objc_setAssociatedObject(self, _themeIdentifier, xz_themeIdentifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (XZTheme *)xz_appliedTheme {
    return objc_getAssociatedObject(self, _appliedTheme);
}

- (BOOL)xz_needsUpdateThemeAppearance {
    return objc_getAssociatedObject(self, _needsUpdateThemeAppearance);
}

- (void)xz_setNeedsThemeAppearanceUpdate {
    if ([self xz_needsUpdateThemeAppearance]) {
        return;
    }
    objc_setAssociatedObject(self, _needsUpdateThemeAppearance, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self xz_forwardThemeAppearanceUpdate];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self xz_updateThemeAppearanceIfNeeded];
    });
}

- (void)xz_forwardThemeAppearanceUpdate {
    
}

- (void)xz_updateThemeAppearanceIfNeeded {
    if ([self xz_needsUpdateThemeAppearance]) {
        objc_setAssociatedObject(self, _needsUpdateThemeAppearance, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        XZTheme *newTheme = [XZTheme currentTheme];
        if (![[self xz_appliedTheme] isEqualToTheme:newTheme]) {
            // 主题发生改变，重置计算样式。
            // TODO: 当主题样式发生改变时，也需要改变计算样式。
            objc_setAssociatedObject(self, _computedThemeStyle, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [self xz_updateAppearanceWithTheme:newTheme];
        objc_setAssociatedObject(self, _appliedTheme, newTheme, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)xz_updateAppearanceWithTheme:(XZTheme *)newTheme {
    // TODO: - 计算样式根据对象类型与标识符进行缓存，以避免重复生成计算样式。
    XZThemeStyle *computedThemeStyle = objc_getAssociatedObject(self, _computedThemeStyle);
    if (computedThemeStyle == nil) {
        // 1. XZSS样式
        XZThemeStyle *themeStyle1 = [[newTheme themeStyleSheetForObject:self] themeStyleForObject:self];
        // 2. 全局样式
        XZThemeStyle *themeStyle2 = [self.class xz_themeStyleIfLoadedForTheme:newTheme];
        // 3. 私有样式
        XZThemeStyle *themeStyle3 = [self xz_themeStyleIfLoadedForTheme:newTheme];
        // 4. 默认主题样式，xzss 样式在读取时，已包含默认主题样式。
        XZThemeStyle *themeStyle4 = nil;
        if (![newTheme isEqualToTheme:[XZTheme defaultTheme]]) {
            XZThemeStyle *themeStyle1 = [self.class xz_themeStyleIfLoadedForTheme:[XZTheme defaultTheme]];
            XZThemeStyle *themeStyle2 = [self xz_themeStyleIfLoadedForTheme:[XZTheme defaultTheme]];
            if (themeStyle1 != nil || themeStyle2 != nil) {
                themeStyle4 = [XZThemeStyle themeStyleForObject:self];
                [themeStyle4 addValuesFromThemeStyle:themeStyle1];
                [themeStyle4 addValuesFromThemeStyle:themeStyle2];
            }
        }
        // 5. 计算样式
        if (themeStyle1 != nil || themeStyle2 != nil || themeStyle3 != nil) {
            if (themeStyle4 != nil) {
                computedThemeStyle = themeStyle4;
            } else {
                computedThemeStyle = [XZThemeStyle themeStyleForObject:self];
            }
            [computedThemeStyle addValuesFromThemeStyle:themeStyle1];
            [computedThemeStyle addValuesFromThemeStyle:themeStyle2];
            [computedThemeStyle addValuesFromThemeStyle:themeStyle3];
            objc_setAssociatedObject(self, _computedThemeStyle, computedThemeStyle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [self xz_updateAppearanceWithThemeStyle:computedThemeStyle];
        } else if (themeStyle4 != nil) {
            objc_setAssociatedObject(self, _computedThemeStyle, themeStyle4, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [self xz_updateAppearanceWithThemeStyle:themeStyle4];
        } else {
            objc_setAssociatedObject(self, _computedThemeStyle, [NSNull null], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    } else if ([computedThemeStyle isKindOfClass:[XZThemeStyle class]]) {
        [self xz_updateAppearanceWithThemeStyle:computedThemeStyle];
    }
}

- (void)xz_updateAppearanceWithThemeStyle:(XZThemeStyle *)themeStyle {
    
}


- (XZThemeStyle *)xz_computedThemeStyle {
    XZThemeStyle *themeStyle = objc_getAssociatedObject(self, _computedThemeStyle);
    if ([themeStyle isKindOfClass:[XZThemeStyle class]]) {
        return themeStyle;
    }
    return nil;
}


- (XZThemeStyle *)xz_themeStyleForTheme:(XZTheme *)theme {
    NSMutableDictionary<XZTheme *, XZThemeStyle *> *themedStyles = objc_getAssociatedObject(self, _themedStyles);
    if (themedStyles == nil) {
        themedStyles = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _themedStyles, themedStyles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    XZThemeStyle *themeStyle = themedStyles[theme];
    if (themeStyle != nil) {
        return themeStyle;
    }
    themeStyle = [XZThemeStyle themeStyleForObject:self];
    themedStyles[theme] = themeStyle;
    return themeStyle;
}

- (XZThemeStyle *)xz_themeStyleIfLoadedForTheme:(XZTheme *)theme {
    NSDictionary<XZTheme *, XZThemeStyle *> *themedStyles = objc_getAssociatedObject(self, _themedStyles);
    return themedStyles[theme];
}

- (void)xz_themeStyleDidChange {
    objc_setAssociatedObject(self, _computedThemeStyle, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self xz_setNeedsThemeAppearanceUpdate];
}

+ (XZThemeStyle *)xz_themeStyleForTheme:(XZTheme *)theme {
    NSMutableDictionary<XZTheme *, XZThemeStyle *> *themedStyles = objc_getAssociatedObject(self, _themedStyles);
    if (themedStyles == nil) {
        themedStyles = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _themedStyles, themedStyles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    XZThemeStyle *themeStyle = themedStyles[theme];
    themedStyles[theme] = themeStyle;
    return themeStyle;
}

+ (XZThemeStyle *)xz_themeStyleIfLoadedForTheme:(XZTheme *)theme {
    NSDictionary<XZTheme *, XZThemeStyle *> *themedStyles = objc_getAssociatedObject(self, _themedStyles);
    return themedStyles[theme];
}

- (NSString *)xz_themeStyleSheetName {
    return nil;
}

@end



static const void * const _themeStyleSheetName = &_themeStyleSheetName;

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

@implementation UIWindow (XZTheme)

- (NSString *)xz_themeStyleSheetName {
    // TODO: - 样式表默认名称待确认。
    return [NSBundle.mainBundle.infoDictionary objectForKeyedSubscript:@"Theme"];
}

@end

@implementation UINavigationItem (XZTheme)

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

@implementation UIViewController (XZTheme)

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
