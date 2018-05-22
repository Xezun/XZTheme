//
//  NSObject+XZThemeSupporting.m
//  XZTheme
//
//  Created by mlibai on 2018/5/21.
//

#import "NSObject+XZThemeSupporting.h"
#import "XZTheme/XZTheme-Swift.h"
@import ObjectiveC;

//static const void * const _key = &_key;

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
    // 是否需要此机制
    // if ([objc_getAssociatedObject(self.class, &_key) boolValue] == NO) {
    //     objc_setAssociatedObject(self.class, &_key, @(YES), OBJC_ASSOCIATION_COPY_NONATOMIC);
    //     [self.class xz_initializeTheme];
    // }
    NSObject * __unsafe_unretained thisObject = [self initWithXZTheme];
    // 访问 Swift 定义方法会莫名其妙的 retain 一次 ？！
    if ([thisObject xz_shouldAutomaticallyUpdateThemeAppearance]) {
        [thisObject xz_themes];
    }
    return thisObject;
}

- (BOOL)xz_shouldAutomaticallyUpdateThemeAppearance {
    return NO;
}
//+ (void)xz_initializeTheme {
//
//}

@end
