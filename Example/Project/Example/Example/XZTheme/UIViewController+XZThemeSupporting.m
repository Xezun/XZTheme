//
//  UIViewController+XZThemeSupporting.m
//  Example
//
//  Created by 徐臻 on 2018/12/24.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import "UIViewController+XZThemeSupporting.h"

@implementation UIViewController (XZThemeSupporting)

- (NSString *)xz_themeStyleSheetName {
    return NSStringFromClass(self.class);
}

@end
