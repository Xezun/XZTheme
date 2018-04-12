//
//  XZThemeStyle+UIImageView.m
//  XZKit
//
//  Created by mlibai on 2017/12/7.
//

#import "XZThemeStyle+UIImageView.h"
#import "XZThemeAttribute.h"
#import "XZThemeState.h"

@implementation XZThemeStyle (UIImageView)

- (UIImage *)imageForState:(XZThemeState)state {
    return [self imageForAttribute:XZThemeAttributeImage forState:state];
}

- (UIImage *)image {
    return [self imageForAttribute:XZThemeAttributeImage forState:XZThemeStateNormal];
}

- (UIImage *)highlightedImageForState:(XZThemeState)state {
    return [self imageForAttribute:XZThemeAttributeHighlightedImage forState:state];
}

- (UIImage *)highlightedImage {
    return [self imageForAttribute:XZThemeAttributeHighlightedImage forState:XZThemeStateNormal];
}

- (NSArray<UIImage *> *)animationImagesForState:(XZThemeState)state {
    return [[self imageForAttribute:XZThemeAttributeAnimationImages forState:state] images];
}

- (NSArray<UIImage *> *)animationImages {
    return [[self imageForAttribute:XZThemeAttributeAnimationImages forState:XZThemeStateNormal] images];
}

- (NSArray<UIImage *> *)highlightedAnimationImagesForState:(XZThemeState)state {
    return [[self imageForAttribute:XZThemeAttributeHighlightedAnimationImages forState:state] images];
}

- (NSArray<UIImage *> *)highlightedAnimationImages {
    return [[self imageForAttribute:XZThemeAttributeHighlightedAnimationImages forState:XZThemeStateNormal] images];
}

- (BOOL)isAnimatingForState:(XZThemeState)state {
    return [self boolValueForAttribute:XZThemeAttributeIsAnimating forState:state];
}

- (BOOL)isAnimating {
    return [self boolValueForAttribute:XZThemeAttributeIsAnimating forState:XZThemeStateNormal];
}

- (BOOL)isHighlightedForState:(XZThemeState)state {
    return [self boolValueForAttribute:XZThemeAttributeIsHighlighted forState:state];
}

- (BOOL)isHighlighted {
    return [self boolValueForAttribute:XZThemeAttributeIsHighlighted forState:XZThemeStateNormal];
}

@end
