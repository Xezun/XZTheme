//
//  XZThemeStyle+UIImageView.m
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyle+UIImageView.h"

@implementation XZThemeStyle (UIImageView)
- (UIImage *)image {
    return [self valueForThemeAttribute:(XZThemeAttributeImage)];
}

- (void)setImage:(UIImage * _Nullable)image {
    [self setValue:image forThemeAttribute:(XZThemeAttributeImage)];
}

- (UIImage *)highlightedImage {
    return [self valueForThemeAttribute:(XZThemeAttributeHighlightedImage)];
}

- (void)setHighlightedImage:(UIImage * _Nullable)highlightedImage {
    [self setValue:highlightedImage forThemeAttribute:(XZThemeAttributeHighlightedImage)];
}

- (NSArray<UIImage *> *)animationImages {
    return [self valueForThemeAttribute:(XZThemeAttributeAnimationImages)];
}

- (void)setAnimationImages:(NSArray<UIImage *> * _Nullable)animationImages {
    [self setValue:animationImages forThemeAttribute:(XZThemeAttributeAnimationImages)];
}

- (NSArray<UIImage *> *)highlightedAnimationImages {
    return [self valueForThemeAttribute:(XZThemeAttributeHighlightedAnimationImages)];
}

- (void)setHighlightedAnimationImages:(NSArray<UIImage *> * _Nullable)highlightedAnimationImages {
    [self setValue:highlightedAnimationImages forThemeAttribute:(XZThemeAttributeHighlightedAnimationImages)];
}

- (BOOL)isAnimating {
    return [self valueForThemeAttribute:(XZThemeAttributeIsAnimating)];
}

- (void)setIsAnimating:(BOOL)isAnimating {
    [self setValue:[NSNumber numberWithBool:isAnimating] forThemeAttribute:(XZThemeAttributeIsAnimating)];
}

- (BOOL)isHighlighted {
    return [[self valueForThemeAttribute:(XZThemeAttributeIsHighlighted)] boolValue];
}

- (void)setIsHighlighted:(BOOL)isHighlighted {
    [self setValue:[NSNumber numberWithBool:isHighlighted] forThemeAttribute:(XZThemeAttributeIsHighlighted)];
}
@end
