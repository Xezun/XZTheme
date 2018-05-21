//
//  NSObject+XZThemeSupporting.m
//  XZTheme
//
//  Created by mlibai on 2018/5/21.
//

#import "NSObject+XZThemeSupporting.h"
#import "XZTheme/XZTheme-Swift.h"
@import ObjectiveC;

@implementation NSObject (XZThemeSupporting)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [NSObject class];
        Method m1 = class_getInstanceMethod(cls, @selector(init));
        Method m2 = class_getInstanceMethod(cls, @selector(initForXZTheme));
        method_exchangeImplementations(m1, m2);
    });
}

- (instancetype)initForXZTheme {
    __unsafe_unretained NSObject *object = [self initForXZTheme];
    if ([self xz_shouldAutomaticallyUpdateThemeAppearance]) {
        [self xz_themes];
    }
    return object;
}

@end
