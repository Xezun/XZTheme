//
//  XZTheme.m
//  XZTheme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZTheme.h"
#import "XZThemeStyle.h"
#import "XZThemeStyleCollection.h"
@import ObjectiveC;


NSNotificationName const XZThemeDidChangeNotification  = @"com.mlibai.XZKit.theme.changed";
NSString         * const XZThemeUserDefaultsKey        = @"com.mlibai.XZKit.theme.default";
NSTimeInterval     const XZThemeAnimationDuration               = 0.5;

static NSString * const XZThemeNameDefault = @"default";
/// 保存当前已应用的主题，+[XZTheme load] 中初始化值。
static XZTheme * _Nonnull _currentTheme = nil;

@implementation XZTheme

+ (void)load {
    NSString *savedThemeName = [NSUserDefaults.standardUserDefaults stringForKey:XZThemeUserDefaultsKey];
    
    if ([savedThemeName isKindOfClass:[NSString class]]) {
        _currentTheme = [[XZTheme alloc] initWithName:savedThemeName];
    } else {
        _currentTheme = [XZTheme defaultTheme];
    }
}

+ (XZTheme *)themeNamed:(NSString *)name {
    if ([name isEqualToString:XZThemeNameDefault]) {
        return [XZTheme defaultTheme];
    } else if ([name isEqualToString:_currentTheme.name]) {
        return _currentTheme;
    }
    return [[XZTheme alloc] initWithName:name];
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = [name copy];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSString *name = [aDecoder decodeObjectForKey:@"XZTheme.name"];
    if ([name isKindOfClass:[NSString class]]) {
        return [self initWithName:name];
    }
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"XZTheme.name"];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[XZTheme alloc] initWithName:self.name];
}

- (BOOL)isEqual:(id)object {
    if ([super isEqual:object]) {
        return YES;
    }
    if (![object isKindOfClass:[XZTheme class]]) {
        return NO;
    }
    return [[(XZTheme *)object name] isEqualToString:self.name];
}

- (NSString *)description {
    return self.name;
}

- (NSUInteger)hash {
    return self.name.hash;
}

- (void)apply:(BOOL)animated {
    if (![_currentTheme isEqual:self]) {
        _currentTheme = self;
        
        [NSUserDefaults.standardUserDefaults setObject:_currentTheme.name forKey:XZThemeUserDefaultsKey];
        // 更新当前视图。
        for (UIWindow *window in UIApplication.sharedApplication.windows) {
            // 当前正显示的视图，立即更新视图。
            [window xz_setNeedsThemeAppearanceUpdate];
            [window.rootViewController xz_setNeedsThemeAppearanceUpdate];
            if (animated) {
                UIView *snapView = [window snapshotViewAfterScreenUpdates:NO];
                [window addSubview:snapView];
                [UIView animateWithDuration:XZThemeAnimationDuration animations:^{
                    snapView.alpha = 0;
                } completion:^(BOOL finished) {
                    [snapView removeFromSuperview];
                }];
            }
        }
        // 发送通知。
        [[NSNotificationCenter defaultCenter] postNotificationName:XZThemeDidChangeNotification object:_currentTheme];
    }
    
}

@end



@implementation XZTheme (XZExtendedTheme)
+ (XZTheme *)defaultTheme {
    static XZTheme *defaultTheme = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultTheme = [[XZTheme alloc] initWithName:XZThemeNameDefault];
    });
    return defaultTheme;
}

+ (XZTheme *)currentTheme {
    return _currentTheme;
}
@end







@implementation XZThemeCollection {
    NSMutableDictionary<XZTheme *, XZThemeStyleCollection *> *_themedStyles;
}

- (instancetype)initWithObject:(NSObject *)object {
    self = [super init];
    if (self != nil) {
        _object = object;
        _themedStyles = [NSMutableDictionary dictionary];
    }
    return self;
}

- (XZThemeStyleCollection *)themeStylesForTheme:(XZTheme *)theme {
    XZThemeStyleCollection *themeStyles = _themedStyles[theme];
    if (themeStyles != nil) {
        return themeStyles;
    }
    themeStyles = [[XZThemeStyleCollection alloc] initWithObject:self->_object];
    _themedStyles[theme] = themeStyles;
    return themeStyles;
}

- (void)setThemeStyles:(XZThemeStyleCollection *)themeStyles forTheme:(XZTheme *)theme {
    _themedStyles[theme] = themeStyles;
}

- (XZThemeStyleCollection *)themeStylesIfLoadedForTheme:(XZTheme *)theme {
    return _themedStyles[theme];
}

- (XZThemeStyleCollection *)defaultThemeStyles {
    return [self themeStylesForTheme:[XZTheme defaultTheme]];
}

@end






@implementation NSObject (XZThemeSupporting)

static const void * const _themes                      = &_themes;
static const void * const _appliedTheme                = &_appliedTheme;
static const void * const _needsThemeAppearanceUpdate  = &_needsThemeAppearanceUpdate;

- (XZThemeCollection *)xz_themes {
    XZThemeCollection *theme = objc_getAssociatedObject(self, _themes);
    if (theme != nil) {
        return theme;
    }
    theme = [[XZThemeCollection alloc] initWithObject:self];
    objc_setAssociatedObject(self, _themes, theme, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 标记需要更新外观，凡是调用了此方法，主题都会更新一次。
    [self xz_setNeedsThemeAppearanceUpdate];
    return theme;
}

- (XZThemeCollection *)xz_themesIfLoaded {
    return objc_getAssociatedObject(self, _themes);
}

- (XZTheme *)xz_appliedTheme {
    return objc_getAssociatedObject(self, _appliedTheme);
}


- (BOOL)xz_forwardsThemeAppearanceUpdate {
    return YES;
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
    XZTheme *currentTheme = [XZTheme currentTheme];
    [self xz_updateAppearanceWithTheme:currentTheme];
    objc_setAssociatedObject(self, _appliedTheme, currentTheme, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)xz_updateAppearanceWithTheme:(XZTheme *)theme {
    XZThemeCollection *themes = [self xz_themesIfLoaded];
    // 如果没有配置主题，不执行操作。
    if (themes == nil) {
        return;
    }
    XZThemeStyleCollection *themeStyles = [themes themeStylesIfLoadedForTheme:theme];
    // 配置了主题，但是无当前主题配置，应用默认主题。
    if (themeStyles == nil) {
        themeStyles = [themes themeStylesIfLoadedForTheme:XZTheme.defaultTheme];
    }
    // 默认主题也没有配置。
    if (themeStyles == nil) {
        return;
    }
    // 应用主题样式。
    [self xz_updateAppearanceWithThemeStyles:themeStyles];
}

- (void)xz_updateAppearanceWithThemeStyles:(XZThemeStyleCollection *)themeStyleSet {

}

@end

