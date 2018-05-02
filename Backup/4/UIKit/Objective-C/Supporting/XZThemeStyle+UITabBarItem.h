//
//  XZThemeStyle+UITabBarItem.h
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyle.h"

@interface XZThemeStyle (UITabBarItem)
@property (nonatomic, strong) UIImage * _Nullable selectedImage;
@property (nonatomic, copy) NSDictionary<NSAttributedStringKey, id> * _Nullable titleTextAttributes;
@property (nonatomic, strong) UIImage * _Nullable landscapeImagePhone;
@property (nonatomic, strong) UIImage * _Nullable largeContentSizeImage;
@end
