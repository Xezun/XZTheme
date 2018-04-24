//
//  XZThemeStyle+UIImageView.h
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyle.h"

@interface XZThemeStyle (UIImageView)
@property (nonatomic, strong) UIImage * _Nullable image;
@property (nonatomic, strong) UIImage * _Nullable highlightedImage;
@property (nonatomic, copy) NSArray<UIImage *> * _Nullable animationImages;
@property (nonatomic, copy) NSArray<UIImage *> * _Nullable highlightedAnimationImages;
@property (nonatomic) BOOL isAnimating;
@property (nonatomic) BOOL isHighlighted;
@end
