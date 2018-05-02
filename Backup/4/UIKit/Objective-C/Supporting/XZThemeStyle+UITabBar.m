//
//  XZThemeStyle+UITabBar.m
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyle+UITabBar.h"

@implementation XZThemeStyle (UITabBar)
- (UIColor *)barTintColor {
    return [XZThemeStyle.colorParser parse:[self valueForThemeAttribute:(XZThemeAttributeBarTintColor)]];
}

- (void)setBarTintColor:(UIColor * _Nullable)barTintColor {
    [self setValue:barTintColor forThemeAttribute:(XZThemeAttributeBarTintColor)];
}

- (UIImage *)shadowImage {
    return [XZThemeStyle.imageParser parse:[self valueForThemeAttribute:(XZThemeAttributeShadowImage)]];
}

- (void)setShadowImage:(UIImage * _Nullable)shadowImage {
    [self setValue:shadowImage forThemeAttribute:(XZThemeAttributeShadowImage)];
}

- (UIColor *)unselectedItemTintColor {
    return [XZThemeStyle.colorParser parse:[self valueForThemeAttribute:(XZThemeAttributeUnselectedItemTintColor)]];
}

- (void)setUnselectedItemTintColor:(UIColor * _Nullable)unselectedItemTintColor {
    [self setValue:unselectedItemTintColor forThemeAttribute:(XZThemeAttributeUnselectedItemTintColor)];
}

- (UIImage *)selectionIndicatorImage {
    return [XZThemeStyle.imageParser parse:[self valueForThemeAttribute:(XZThemeAttributeSelectionIndicatorImage)]];
}

- (void)setSelectionIndicatorImage:(UIImage * _Nullable)selectionIndicatorImage {
    [self setValue:selectionIndicatorImage forThemeAttribute:(XZThemeAttributeSelectionIndicatorImage)];
}
@end
