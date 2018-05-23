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

- (void *)initWithXZTheme {
    // 使用 void * 来避免 ARC 自动添加 retain ，导致部分不需要 retain 的对象的异常 LOG 输出。
    void * object = (void *)[self initWithXZTheme];
    // OC 访问 Swift 定义的方法，当前对象会被 retain 一次，所以该方法由 OC 来定义。
    if ([self xz_shouldAutomaticallyUpdateThemeAppearance]) {
        [self xz_themes];
    }
    return object;
}

- (BOOL)xz_shouldAutomaticallyUpdateThemeAppearance {
    return NO;
}


@end
