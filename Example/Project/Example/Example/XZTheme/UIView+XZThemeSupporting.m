//
//  UIView+XZThemeSupporting.m
//  Example
//
//  Created by 徐臻 on 2018/12/24.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import "UIView+XZThemeSupporting.h"

@implementation UIView (XZThemeSupporting)

- (NSString *)xz_themeStyleSheetName {
    return self.nextResponder.xz_themeStyleSheetName;
}

- (void)xz_forwardThemeAppearanceUpdate {
    for (UIView *subview in self.subviews) {
        [subview xz_setNeedsThemeAppearanceUpdate];
    }
}

@end
