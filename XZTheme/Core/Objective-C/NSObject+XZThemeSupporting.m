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
        Method m2 = class_getInstanceMethod(cls, @selector(initWithXZTheme));
        method_exchangeImplementations(m1, m2);
    });
}

- (instancetype)initWithXZTheme {
#if NS_AUTOMATED_REFCOUNT_UNAVAILABLE
    self = [self initWithXZTheme];
    // OC 访问 Swift 定义的方法，当前对象会被 retain 一次。
    if ([self xz_shouldAutomaticallyUpdateThemeAppearance]) {
        [self xz_themes];
    }
    return self;
#else
    NSLog(@"%@ 需要使用 MRC 模式", [[NSString stringWithUTF8String:__FILE__] lastPathComponent])
#endif
}

- (BOOL)xz_shouldAutomaticallyUpdateThemeAppearance {
    return NO;
}


@end
