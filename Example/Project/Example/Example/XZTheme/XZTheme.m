//
//  XZTheme.m
//  Example
//
//  Created by 徐臻 on 2018/12/21.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import "XZTheme.h"
#import "XZThemeStyleSheet.h"

@implementation XZTheme {
    NSMutableDictionary<NSString *, id> *_keyedThemeStyleSheets;
}

+ (XZTheme *)defaultTheme {
    return nil;
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
        _keyedThemeStyleSheets = [NSMutableDictionary dictionary];
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

- (XZThemeStyleSheet *)themeStyleSheetForObject:(id<XZThemeSupporting>)object {
    NSString *sheetName = object.xz_styleSheetName;
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
    XZThemeStyleSheet *styleSheet = _keyedThemeStyleSheets[sheetKey];
    if (styleSheet == nil) {
        if (sheetURL1 != nil) {
            styleSheet = [[XZThemeStyleSheet alloc] initWithURL:sheetURL1];
        }
        if (styleSheet != nil) {
            [styleSheet addThemeStylesFromThemeStyleSheet:[[XZThemeStyleSheet alloc] initWithURL:sheetURL2]];
        } else {
            styleSheet = [[XZThemeStyleSheet alloc] initWithURL:sheetURL2];
        }
        _keyedThemeStyleSheets[sheetKey] = (styleSheet == nil ? NSNull.null : styleSheet);
    } else if (![styleSheet isKindOfClass:[XZThemeStyleSheet class]]) {
        styleSheet = nil;
    }
    return styleSheet;
}

@end
