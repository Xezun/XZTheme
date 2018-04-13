//
//  XZThemeStyle+UILabel.m
//  XZKit
//
//  Created by mlibai on 2017/12/7.
//

#import "UILabel+XZThemeStyle.h"
#import "XZThemeAttribute.h"
#import "XZThemeState.h"


@implementation XZThemeStyle (UILabel)

- (NSString *)textForState:(XZThemeState)state {
    return [self stringValueForAttribute:XZThemeAttributeText forState:state];
}

- (NSString *)text {
    return [self stringValueForAttribute:XZThemeAttributeText forState:XZThemeStateNormal];
}

- (UIColor *)textColorForState:(XZThemeState)state {
    return [self colorForAttribute:XZThemeAttributeTextColor forState:state];
}

- (UIColor *)textColor {
    return [self colorForAttribute:XZThemeAttributeTextColor forState:XZThemeStateNormal];
}

- (UIFont *)fontForState:(XZThemeState)state {
    return [self fontForAttribute:XZThemeAttributeFont forState:state];
}

- (UIFont *)font {
    return [self fontForAttribute:XZThemeAttributeFont forState:XZThemeStateNormal];
}

- (UIColor *)shadowColorForState:(XZThemeState)state {
    return [self colorForAttribute:XZThemeAttributeShadowColor forState:state];
}

- (UIColor *)shadowColor {
    return [self colorForAttribute:XZThemeAttributeShadowColor forState:XZThemeStateNormal];
}

- (UIColor *)highlightedTextColorForState:(XZThemeState)state {
    return [self colorForAttribute:XZThemeAttributeHighlightedTextColor forState:state];
}

- (UIColor *)highlightedTextColor {
    return [self colorForAttribute:XZThemeAttributeHighlightedTextColor forState:XZThemeStateNormal];
}

@end
