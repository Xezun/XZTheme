//
//  XZThemeStyle+UITabBarItem.m
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyle+UITabBarItem.h"

@implementation XZThemeStyle (UITabBarItem)

- (UIImage *)selectedImage {
    return [XZThemeStyle.imageParser parse:[self valueForThemeAttribute:(XZThemeAttributeSelectedImage)]];
}

- (void)setSelectedImage:(UIImage * _Nullable)selectedImage {
    [self setValue:selectedImage forThemeAttribute:(XZThemeAttributeSelectedImage)];
}

- (NSDictionary<NSAttributedStringKey,id> *)titleTextAttributes {
    return [XZThemeStyle.stringAttributesParser parse:[self valueForThemeAttribute:(XZThemeAttributeTitleTextAttributes)]];
}

- (void)setTitleTextAttributes:(NSDictionary<NSAttributedStringKey,id> * _Nullable)titleTextAttributes {
    [self setValue:titleTextAttributes forThemeAttribute:(XZThemeAttributeTitleTextAttributes)];
}

- (UIImage *)landscapeImagePhone {
    return [XZThemeStyle.imageParser parse:[self valueForThemeAttribute:(XZThemeAttributeLandscapeImagePhone)]];
}

- (void)setLandscapeImagePhone:(UIImage * _Nullable)landscapeImagePhone {
    [self setValue:landscapeImagePhone forThemeAttribute:(XZThemeAttributeLandscapeImagePhone)];
}

- (UIImage *)largeContentSizeImage {
    return [XZThemeStyle.imageParser parse:[self valueForThemeAttribute:(XZThemeAttributeLargeContentSizeImage)]];
}

- (void)setLargeContentSizeImage:(UIImage * _Nullable)largeContentSizeImage {
    [self setValue:largeContentSizeImage forThemeAttribute:(XZThemeAttributeLargeContentSizeImage)];
}

@end
