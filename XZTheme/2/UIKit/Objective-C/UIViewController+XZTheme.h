//
//  UIViewController+XZTheme.h
//  Example
//
//  Created by mlibai on 2018/4/29.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (XZTheme)

/// 方便通过主题控制状态栏样式。
/// @note 注意 UINavigationController 的状态栏由 navigationBar.barStyle 决定。
@property (nonatomic, setter=xz_setStatusBarStyle:) UIStatusBarStyle xz_statusBarStyle NS_SWIFT_NAME(statusBarStyle);


@end
