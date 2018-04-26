//
//  XZTheme.m
//  XZTheme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZTheme.h"
#import "XZThemeStyle.h"
#import "XZThemeStyles.h"
@import ObjectiveC;



NSNotificationName const _Nonnull XZThemeDidChangeNotification  = @"com.mlibai.XZKit.theme.changed";
NSString         * const _Nonnull XZThemeUserDefaultsKey        = @"com.mlibai.XZKit.theme.default";
NSString         * const _Nonnull XZThemeNameDefault            = @"default";

/// 保存当前已应用的主题。
static XZTheme * _Nonnull _currentTheme = nil;

@implementation XZTheme

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *savedThemeName = [NSUserDefaults.standardUserDefaults stringForKey:XZThemeUserDefaultsKey];
        
        if ([savedThemeName isKindOfClass:[NSString class]]) {
            _currentTheme = [[XZTheme alloc] initWithName:savedThemeName];
        } else {
            _currentTheme = [XZTheme defaultTheme];
        }
    });
}

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

+ (void)setCurrentTheme:(XZTheme *)currentTheme {
    [self setCurrentTheme:currentTheme animated:NO];
}

+ (void)setCurrentTheme:(XZTheme *)currentTheme animated:(BOOL)animated {
    if (![_currentTheme isEqual:currentTheme]) {
        _currentTheme = currentTheme;
        
        
        [NSUserDefaults.standardUserDefaults setObject:_currentTheme.name
                                                forKey:XZThemeUserDefaultsKey];
        // send events.
        for (UIWindow *window in UIApplication.sharedApplication.windows) {
            // 当前正显示的视图，立即更新视图。
            [window xz_setNeedsThemeAppearanceUpdate];
            [window.rootViewController xz_setNeedsThemeAppearanceUpdate];
            if (animated) {
                UIView *snapView = [window snapshotViewAfterScreenUpdates:NO];
                [window addSubview:snapView];
                [UIView animateWithDuration:0.5 animations:^{
                    snapView.alpha = 0;
                } completion:^(BOOL finished) {
                    [snapView removeFromSuperview];
                }];
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:XZThemeDidChangeNotification object:_currentTheme];
    }
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
    if (![super isEqual:object]) {
        if ([object isKindOfClass:[XZTheme class]]) {
            return [[(XZTheme *)object name] isEqualToString:self.name];
        }
        return NO;
    }
    return YES;
}

- (NSString *)description {
    return self.name;
}

- (NSUInteger)hash {
    return self.name.hash;
}

@end

@implementation XZThemes {
    NSMutableDictionary<XZTheme *, XZThemeStyles *> *_themedStyles;
}



- (instancetype)initWithObject:(NSObject *)object {
    self = [super init];
    if (self != nil) {
        _object = object;
        _themedStyles = [NSMutableDictionary dictionary];
    }
    return self;
}

- (XZThemeStyles *)themeStylesForTheme:(XZTheme *)theme {
    XZThemeStyles *themeStyles = _themedStyles[theme];
    if (themeStyles != nil) {
        return themeStyles;
    }
    themeStyles = [[XZThemeStyles alloc] initWithObject:self->_object];
    _themedStyles[theme] = themeStyles;
    return themeStyles;
}

- (void)setThemeStyles:(XZThemeStyles *)themeStyles forTheme:(XZTheme *)theme {
    _themedStyles[theme] = themeStyles;
}

- (XZThemeStyles *)themeStylesIfLoadedForTheme:(XZTheme *)theme {
    return _themedStyles[theme];
}

- (XZThemeStyles *)defaultThemeStyles {
    return [self themeStylesForTheme:[XZTheme defaultTheme]];
}

@end






@implementation NSObject (XZThemeSupporting)

static const void * const _theme                       = &_theme;
static const void * const _appliedTheme                = &_appliedTheme;
static const void * const _needsThemeAppearanceUpdate  = &_needsThemeAppearanceUpdate;

- (XZThemes *)xz_themes {
    XZThemes *theme = objc_getAssociatedObject(self, _theme);
    if (theme != nil) {
        return theme;
    }
    theme = [[XZThemes alloc] initWithObject:self];
    objc_setAssociatedObject(self, _theme, theme, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 标记需要更新外观，凡是调用了此方法，主题都会更新一次。
    [self xz_setNeedsThemeAppearanceUpdate];
    return theme;
}

- (XZThemes *)xz_themesIfLoaded {
    return objc_getAssociatedObject(self, _theme);
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
    XZThemeStyles *themeStyles = [self.xz_themesIfLoaded themeStylesIfLoadedForTheme:currentTheme];
    if (themeStyles != nil) {
        [self xz_updateAppearanceWithThemeStyles:themeStyles];
    }
    objc_setAssociatedObject(self, _appliedTheme, currentTheme, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)xz_updateAppearanceWithThemeStyles:(XZThemeStyles *)themeStyles {
    
}

@end

