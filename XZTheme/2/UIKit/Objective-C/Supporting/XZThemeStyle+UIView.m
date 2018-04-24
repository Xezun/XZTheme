//
//  XZThemeStyle+UIView.m
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyle+UIView.h"

@implementation XZThemeStyle (UIView)

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [self setValue:backgroundColor forThemeAttribute:(XZThemeAttributeBackgroundColor)];
}

- (UIColor *)backgroundColor {
    return [XZThemeStyle.colorParser parse:[self valueForThemeAttribute:(XZThemeAttributeBackgroundColor)]];
}

- (void)setTintColor:(UIColor * _Nullable)tintColor {
    [self setValue:tintColor forThemeAttribute:(XZThemeAttributeTintColor)];
}

- (UIColor *)tintColor {
    return [XZThemeStyle.colorParser parse:[self valueForThemeAttribute:(XZThemeAttributeTintColor)]];
}

- (void)setIsHidden:(BOOL)isHidden {
    [self setValue:[NSNumber numberWithBool:isHidden] forThemeAttribute:(XZThemeAttributeIsHidden)];
}

- (BOOL)isHidden {
    return [self boolValueForThemeAttribute:(XZThemeAttributeIsHidden)];
}

- (CGFloat)alpha {
    return (CGFloat)[self doubleValueForThemeAttribute:(XZThemeAttributeAlpha)];
}

- (void)setAlpha:(CGFloat)alpha {
    [self setValue:[NSNumber numberWithDouble:alpha] forThemeAttribute:(XZThemeAttributeAlpha)];
}

- (void)setIsOpaque:(BOOL)isOpaque {
    [self setValue:[NSNumber numberWithBool:isOpaque] forThemeAttribute:(XZThemeAttributeIsOpaque)];
}

- (BOOL)isOpaque {
    return [self boolValueForThemeAttribute:(XZThemeAttributeIsOpaque)];
}

@end
