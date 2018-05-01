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
#import "NSObject+XZThemeSupporting.h"
#import "Example-Swift.h"
@import ObjectiveC;


NSNotificationName const XZThemeDidChangeNotification  = @"com.mlibai.XZKit.theme.changed";
NSString         * const XZThemeUserDefaultsKey        = @"com.mlibai.XZKit.theme.default";
NSTimeInterval     const XZThemeAnimationDuration      = 0.5;

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
            // 执行动画。
            if (!animated) { continue; }
            UIView *snapView = [window snapshotViewAfterScreenUpdates:NO];
            [window addSubview:snapView];
            [UIView animateWithDuration:XZThemeAnimationDuration animations:^{
                snapView.alpha = 0;
            } completion:^(BOOL finished) {
                [snapView removeFromSuperview];
            }];
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
















