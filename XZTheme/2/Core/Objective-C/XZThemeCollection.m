//
//  XZThemeCollection.m
//  Example
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeCollection.h"
#import "XZTheme.h"
#import "XZThemeStyleCollection.h"

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
    themeStyles = [[XZThemeStyleCollection alloc] initWithObject:self.object];
    _themedStyles[theme] = themeStyles;
    return themeStyles;
}

- (void)setThemeStyles:(XZThemeStyleCollection *)themeStyles forTheme:(XZTheme *)theme {
    _themedStyles[theme] = themeStyles;
}

- (XZThemeStyleCollection *)themeStylesIfLoadedForTheme:(XZTheme *)theme {
    return _themedStyles[theme];
}

@end



@implementation XZThemeCollection (XZExtendedThemeCollection)

- (XZThemeStyleCollection *)defaultThemeStyles {
    return [self themeStylesForTheme:[XZTheme defaultTheme]];
}

@end
