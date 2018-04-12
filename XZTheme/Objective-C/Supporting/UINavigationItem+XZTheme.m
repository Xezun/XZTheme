//
//  UINavigationItem+XZTheme.m
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

#import "UINavigationItem+XZTheme.h"

@implementation UINavigationItem (XZTheme)

- (void)xz_setNeedsThemeApply {
    [super xz_setNeedsThemeApply];
    
    // Will be called by it's superview.
    // [self.titleView xz_setNeedsThemeApply];
    
    [self.backBarButtonItem xz_setNeedsThemeApply];
    
    NSArray<UIBarButtonItem *> *leftBarButtonItems = self.leftBarButtonItems;
    if (leftBarButtonItems.count > 0) {
        for (UIBarButtonItem *item in leftBarButtonItems) {
            [item xz_setNeedsThemeApply];
        }
    }
    
    NSArray<UIBarButtonItem *> *rightBarButtonItems = self.rightBarButtonItems;
    if (rightBarButtonItems.count > 0) {
        for (UIBarButtonItem *item in rightBarButtonItems) {
            [item xz_setNeedsThemeApply];
        }
    }
}

@end
