//
//  UIViewController+XZTheme.h
//  XZKit
//
//  Created by mlibai on 2017/10/14.
//

#import <UIKit/UIKit.h>
#ifdef XZKIT_FRAMEWORK
#import <XZKit/NSObject+XZTheme.h>
#else
#import "NSObject+XZTheme.h"
#endif



@interface UIViewController (XZTheme)

/**
 在 UIViewController 中：
 @note 控制器每次显示时都会检查当前已应用的主题是否与 App 当前主题是否一致，从而决定是否执行应用主题的方法。
 */
+ (void)load;

/**
 作为控制器，当其自身被标记为需要应用主题时，会同时标记其 childViewControllers、presentedViewController、navigationItem、toolbarItems、tabBarItem 。
 */
- (void)xz_setNeedsThemeApply;

@end
