//
//  XZThemeStyle+UIButton.h
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyle.h"

@interface XZThemeStyle (UIButton)
@property (nonatomic, copy) NSString * _Nullable title;
@property (nonatomic, strong) UIColor * _Nullable titleColor;
@property (nonatomic, strong) UIImage * _Nullable backgroundImage;
@property (nonatomic, strong) UIColor * _Nullable titleShadowColor;
@property (nonatomic, strong) NSAttributedString * _Nullable attributedTitle;
@end
