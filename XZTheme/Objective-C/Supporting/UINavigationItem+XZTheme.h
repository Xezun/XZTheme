//
//  UINavigationItem+XZTheme.h
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

#import <UIKit/UIKit.h>
#ifdef XZKIT_FRAMEWORK
#import <XZKit/NSObject+XZTheme.h>
#else
#import "NSObject+XZTheme.h"
#endif

@interface UINavigationItem (XZTheme)

/**
 当被标记为需要更新主题时，其 backBarButtonItem、leftBarButtonItems、rightBarButtonItems 会被标记为需要更新。
 */
- (void)xz_setNeedsThemeApply;

@end
