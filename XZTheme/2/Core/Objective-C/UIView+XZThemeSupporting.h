//
//  UIView+XZTheme.h
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+XZThemeSupporting.h"

@interface UIView (XZThemeSupporting)

/// 作为视图控件，其每次被添加到父视图上时，都会检查当前已应用的主题与 App 当前主题是否一致，从而判断是否需要刷新主题外观。
+ (void)load;

/// 作为视图控件，当其自身被标为需要更新主题时，其子视图会同时标记为需要更新主题。
/// @note 子类通过 updatesAppearanceForSubviews() 方法来控制是否传递主题。
- (void)xz_setNeedsThemeAppearanceUpdate;

@end
