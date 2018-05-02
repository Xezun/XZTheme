//
//  UIView+XZTheme.h
//  XZKit
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XZThemeSupporting)

/// 作为视图控件，其每次被添加到父视图上时，都会检查当前已应用的主题与 App 当前主题是否一致，从而判断是否需要刷新主题外观。
+ (void)load;

@end
