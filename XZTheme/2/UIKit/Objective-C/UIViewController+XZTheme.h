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
/// @note 使用此属性的前提是，状态栏样式需是基于控制器控制的。
/// @note 注意 UINavigationController 的状态栏由 navigationBar.barStyle 决定。
@property (nonatomic, setter=xz_setStatusBarStyle:) UIStatusBarStyle xz_statusBarStyle NS_SWIFT_NAME(statusBarStyle);


@end
