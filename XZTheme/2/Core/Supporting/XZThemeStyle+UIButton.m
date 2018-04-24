//
//  XZThemeStyle+UIButton.m
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyle+UIButton.h"

@implementation XZThemeStyle (UIButton)
- (NSString *)title {
    return [self valueForThemeAttribute:(XZThemeAttributeTitle)];
}

- (void)setTitle:(NSString * _Nullable)title {
    [self setValue:title forThemeAttribute:(XZThemeAttributeTitle)];
}

- (UIColor *)titleColor {
    return [self valueForThemeAttribute:(XZThemeAttributeTitleColor)];
}

- (void)setTitleColor:(UIColor * _Nullable)titleColor {
    [self setValue:titleColor forThemeAttribute:(XZThemeAttributeTitleColor)];
}

- (UIImage *)backgroundImage {
    return [self valueForThemeAttribute:(XZThemeAttributeBackgroundImage)];
}

- (void)setBackgroundImage:(UIImage * _Nullable)backgroundImage {
    [self setValue:backgroundImage forThemeAttribute:(XZThemeAttributeBackgroundImage)];
}

- (UIColor *)titleShadowColor {
    return [self valueForThemeAttribute:(XZThemeAttributeTitleShadowColor)];
}

- (void)setTitleShadowColor:(UIColor * _Nullable)titleShadowColor {
    [self setValue:titleShadowColor forThemeAttribute:(XZThemeAttributeTitleShadowColor)];
}

- (NSAttributedString *)attributedTitle {
    return [self valueForThemeAttribute:(XZThemeAttributeAttributedTitle)];
}

- (void)setAttributedTitle:(NSAttributedString * _Nullable)attributedTitle {
    [self setValue:attributedTitle forThemeAttribute:(XZThemeAttributeAttributedTitle)];
}
@end
