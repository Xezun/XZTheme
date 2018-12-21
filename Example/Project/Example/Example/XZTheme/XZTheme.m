//
//  XZTheme.m
//  Example
//
//  Created by 徐臻 on 2018/12/21.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import "XZTheme.h"

@implementation XZTheme {
    NSMutableDictionary<NSString *, XZThemeStyleSheet *> *_namedStyleSheets;
}

+ (XZTheme *)defaultTheme {
    return nil;
}

+ (XZTheme *)currentTheme {
    return nil;
}

+ (NSMutableDictionary<NSString *, XZTheme *> *)namedThemes {
    static NSMutableDictionary<NSString *, XZTheme *> *_namedThemes = nil;
    if (_namedThemes != nil) {
        return _namedThemes;
    }
    _namedThemes = [NSMutableDictionary dictionary];
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
        _namedStyleSheets = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSDictionary<NSString *,XZThemeStyleSheet *> *)namedStyleSheets {
    return _namedStyleSheets;
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

@end
