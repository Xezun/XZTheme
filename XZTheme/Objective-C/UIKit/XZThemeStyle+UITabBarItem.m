//
//  XZThemeStyle+UITabBarItem.m
//  XZKit
//
//  Created by mlibai on 2017/12/7.
//

#import "XZThemeStyle+UITabBarItem.h"
#import "XZThemeAttribute.h"
#import "XZThemeState.h"


@implementation XZThemeStyle (UITabBarItem)

- (UIImage *)selectedImageForState:(XZThemeState)state {
    return [self imageForAttribute:XZThemeAttributeSelectedImage forState:state];
}

- (UIImage *)selectedImage {
    return [self imageForAttribute:XZThemeAttributeSelectedImage forState:XZThemeStateNormal];
}

- (NSDictionary<NSAttributedStringKey,id> *)titleTextAttributesForState:(XZThemeState)state {
    return [self stringAttributesForAttribute:XZThemeAttributeTitleTextAttributes forState:state];
}

- (NSDictionary<NSAttributedStringKey,id> *)titleTextAttributes {
    return [self stringAttributesForAttribute:XZThemeAttributeTitleTextAttributes forState:XZThemeStateNormal];
}

- (UIImage *)landscapeImagePhoneForState:(XZThemeState)state {
    return [self imageForAttribute:XZThemeAttributeLandscapeImagePhone forState:state];
}

- (UIImage *)landscapeImagePhone {
    return [self imageForAttribute:XZThemeAttributeLandscapeImagePhone forState:XZThemeStateNormal];
}

- (UIImage *)largeContentSizeImageForState:(XZThemeState)state {
    return [self imageForAttribute:XZThemeAttributeLargeContentSizeImage forState:state];
}

- (UIImage *)largeContentSizeImage {
    return [self imageForAttribute:XZThemeAttributeLargeContentSizeImage forState:XZThemeStateNormal];
}

@end
