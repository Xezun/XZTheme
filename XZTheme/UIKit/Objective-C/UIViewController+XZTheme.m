//
//  UIViewController+XZTheme.m
//  XZKit
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "UIViewController+XZTheme.h"
#import <objc/runtime.h>

@implementation UIViewController (XZTheme)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class aClass = [UIViewController class];
        
        Method method3 = class_getInstanceMethod(aClass, @selector(preferredStatusBarStyle));
        Method method4 = class_getInstanceMethod(aClass, @selector(XZTheme_preferredStatusBarStyle));
        if (!class_addMethod(aClass, @selector(preferredStatusBarStyle), method_getImplementation(method4), method_getTypeEncoding(method3))) {
            method_exchangeImplementations(method3, method4);
        }
    });
}

static const void * const _statusBarStyle = &_statusBarStyle;

- (UIStatusBarStyle)xz_statusBarStyle {
    NSNumber *number = objc_getAssociatedObject(self, _statusBarStyle);
    if (number != nil) {
        return [number integerValue];
    }
    // 如果没有保存值的话，返回的是原始的。
    return [self XZTheme_preferredStatusBarStyle];
}

- (void)xz_setStatusBarStyle:(UIStatusBarStyle)xz_statusBarStyle {
    objc_setAssociatedObject(self, _statusBarStyle, [NSNumber numberWithInteger:xz_statusBarStyle], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)XZTheme_preferredStatusBarStyle {
    return [self xz_statusBarStyle];
}

@end
