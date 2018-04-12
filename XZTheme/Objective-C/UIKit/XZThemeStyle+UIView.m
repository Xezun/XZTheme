//
//  XZThemeStyle+UIView.m
//  XZKit
//
//  Created by mlibai on 2017/12/7.
//

#import "XZThemeStyle+UIView.h"
#import "XZThemeAttribute.h"
#import "XZThemeState.h"

@implementation XZThemeStyle (UIView)

- (UIColor *)backgroundColorForState:(XZThemeState)state {
    return [self colorForAttribute:XZThemeAttributeBackgroundColor forState:state];
}

- (UIColor *)backgroundColor {
    return [self colorForAttribute:XZThemeAttributeBackgroundColor forState:XZThemeStateNormal];
}

- (UIColor *)tintColorForState:(XZThemeState)state {
    return [self colorForAttribute:XZThemeAttributeTintColor forState:state];
}

- (UIColor *)tintColor {
    return [self colorForAttribute:XZThemeAttributeTintColor forState:XZThemeStateNormal];
}

- (BOOL)isHiddenForState:(XZThemeState)state {
    return [self boolValueForAttribute:XZThemeAttributeIsHidden forState:state];
}

- (BOOL)isHidden {
    return [self boolValueForAttribute:XZThemeAttributeIsHidden forState:XZThemeStateNormal];
}

- (CGFloat)alphaForState:(XZThemeState)state {
    return (CGFloat)[self floatValueForAttribute:XZThemeAttributeAlpha forState:state];
}

- (CGFloat)alpha {
    return (CGFloat)[self floatValueForAttribute:XZThemeAttributeAlpha forState:XZThemeStateNormal];
}

- (BOOL)isOpaqueForState:(XZThemeState)state {
    return [self boolValueForAttribute:XZThemeAttributeIsOpaque forState:state];
}

- (BOOL)isOpaque {
    return [self boolValueForAttribute:XZThemeAttributeIsOpaque forState:XZThemeStateNormal];
}



@end
