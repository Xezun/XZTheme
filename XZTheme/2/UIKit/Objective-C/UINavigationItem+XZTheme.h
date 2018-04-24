//
//  UINavigationItem+XZTheme.h
//  XZKit
//
//  Created by mlibai on 2017/12/6.
//

#import <UIKit/UIKit.h>


@interface UINavigationItem (XZTheme)

/// 当被标记为需要更新主题时，其 backBarButtonItem、leftBarButtonItems、rightBarButtonItems 会被标记为需要更新。
- (void)xz_setNeedsThemeAppearanceUpdate;

@end
