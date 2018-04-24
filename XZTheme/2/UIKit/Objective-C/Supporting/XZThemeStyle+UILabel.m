//
//  XZThemeStyle+UILabel.m
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyle+UILabel.h"

@implementation XZThemeStyle (UILabel)
- (NSString *)text {
    return [self valueForThemeAttribute:(XZThemeAttributeText)];
}

- (void)setText:(NSString * _Nullable)text {
    [self setValue:text forThemeAttribute:(XZThemeAttributeText)];
}

- (UIColor *)textColor {
    return [self valueForThemeAttribute:(XZThemeAttributeTextColor)];
}

- (void)setTextColor:(UIColor * _Nullable)textColor {
    [self setValue:textColor forThemeAttribute:(XZThemeAttributeTextColor)];
}

- (UIFont *)font {
    return [self valueForThemeAttribute:(XZThemeAttributeFont)];
}

- (void)setFont:(UIFont * _Nullable)font {
    [self setValue:font forThemeAttribute:(XZThemeAttributeFont)];
}

- (UIColor *)shadowColor {
    return [self valueForThemeAttribute:(XZThemeAttributeShadowColor)];
}

- (void)setShadowColor:(UIColor * _Nullable)shadowColor {
    [self setValue:shadowColor forThemeAttribute:(XZThemeAttributeShadowColor)];
}

- (UIColor *)highlightedTextColor {
    return [self valueForThemeAttribute:(XZThemeAttributeHighlightedTextColor)];
}

- (void)setHighlightedTextColor:(UIColor * _Nullable)highlightedTextColor {
    [self setValue:highlightedTextColor forThemeAttribute:(XZThemeAttributeHighlightedTextColor)];
}
@end
