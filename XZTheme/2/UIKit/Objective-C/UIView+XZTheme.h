//
//  UIView+XZTheme.h
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZTheme.h"

@interface UIView (XZTheme)

/// 作为视图控件，其每次被添加到父视图上时，都会检查当前已应用的主题与 App 当前主题是否一致，从而判断是否需要调用应用主题的方法。
+ (void)load;

@end
