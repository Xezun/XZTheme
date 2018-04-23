//
//  XZThemeStyle+UIButton.m
//  XZKit
//
//  Created by mlibai on 2017/12/7.
//

#import "UIButton+XZThemeStyle.h"
#import "XZThemeAttribute.h"
#import "XZThemeState.h"

@implementation XZThemeStyle (UIButton)

- (NSString *)titleForState:(XZThemeState)state {
    return [self stringValueForAttribute:XZThemeAttributeTitle forState:state];
}

- (NSString *)title {
    return [self stringValueForAttribute:XZThemeAttributeTitle forState:XZThemeStateNormal];
}


- (UIColor *)titleColorForState:(XZThemeState)state {
    return [self colorForAttribute:XZThemeAttributeTitleColor forState:state];
}

- (UIColor *)titleColor {
    return [self colorForAttribute:XZThemeAttributeTitleColor forState:XZThemeStateNormal];
}

- (UIImage *)backgroundImageForState:(XZThemeState)state {
    return [self imageForAttribute:XZThemeAttributeBackgroundImage forState:state];
}

- (UIImage *)backgroundImage {
    return [self imageForAttribute:XZThemeAttributeBackgroundImage forState:XZThemeStateNormal];
}

- (NSAttributedString *)attributedTitleForState:(XZThemeState)state {
    return [self attributedStringForAttribute:XZThemeAttributeAttributedTitle forState:state];
}

- (NSAttributedString *)attributedTitle {
    return [self attributedStringForAttribute:XZThemeAttributeAttributedTitle forState:XZThemeStateNormal];
}

- (UIColor *)titleShadowColorForState:(XZThemeState)state {
    return [self colorForAttribute:XZThemeAttributeTitleShadowColor forState:state];
}

- (UIColor *)titleShadowColor {
    return [self colorForAttribute:XZThemeAttributeTitleShadowColor forState:XZThemeStateNormal];
}

@end
