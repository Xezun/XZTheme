//
//  XZThemeStyle+UITabBar.m
//  XZKit
//
//  Created by mlibai on 2017/12/7.
//

#import "UITabBar+XZThemeStyle.h"
#import "XZThemeAttribute.h"
#import "XZThemeState.h"

@implementation XZThemeStyle (UITabBar)

- (UIColor *)barTintColorForState:(XZThemeState)state {
    return [self colorForAttribute:XZThemeAttributeBarTintColor forState:state];
}

- (UIColor *)barTintColor {
    return [self colorForAttribute:XZThemeAttributeBarTintColor forState:XZThemeStateNormal];
}


- (UIImage *)shadowImageForState:(XZThemeState)state {
    return [self imageForAttribute:XZThemeAttributeShadowImage forState:state];
}

- (UIImage *)shadowImage {
    return [self imageForAttribute:XZThemeAttributeShadowImage forState:XZThemeStateNormal];
}

- (UIColor *)unselectedItemTintColorForState:(XZThemeState)state {
    return [self colorForAttribute:XZThemeAttributeUnselectedItemTintColor forState:state];
}

- (UIColor *)unselectedItemTintColor {
    return [self colorForAttribute:XZThemeAttributeUnselectedItemTintColor forState:XZThemeStateNormal];
}

- (UIImage *)selectionIndicatorImageForState:(XZThemeState)state {
    return [self imageForAttribute:XZThemeAttributeSelectionIndicatorImage forState:state];
}

- (UIImage *)selectionIndicatorImage {
    return [self imageForAttribute:XZThemeAttributeSelectionIndicatorImage forState:XZThemeStateNormal];
}

@end
