//
//  UIView+XZTheme.h
//  XZKit
//
//  Created by mlibai on 2017/10/14.
//

#import <UIKit/UIKit.h>
#import "NSObject+XZTheme.h"


@interface UIView (XZTheme)

/// 作为视图控件，其每次被添加到父视图上时，都会检查当前已应用的主题与 App 当前主题是否一致，从而判断是否需要调用应用主题的方法。
+ (void)load;

/// 作为视图控件，当其自身被标为需要更新主题时，其子视图会同时标记为需要更新主题。
- (void)xz_setNeedsThemeAppearanceUpdate;

/// 当主题改变时，是否应该更新子控件样式。UIView 默认 YES；UIButton 默认 NO。
- (BOOL)xz_shouldUpdateAppearanceForSubviews; 

@end
