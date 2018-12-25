//
//  UIKit+XZThemeSupporting.h
//  Example
//
//  Created by 徐臻 on 2018/12/24.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+XZThemeSupporting.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XZThemeSupporting)
+ (void)load;
- (NSString *)xz_themeStyleSheetName;
- (void)xz_forwardThemeAppearanceUpdate;
@end

@interface UIWindow (XZThemeSupporting)
- (NSString *)xz_themeStyleSheetName;
@end

@interface UINavigationItem (XZThemeSupporting)
- (NSString *)xz_themeStyleSheetName;
- (void)xz_forwardThemeAppearanceUpdate;
@end

@interface UIViewController (XZThemeSupporting)
+ (void)load;
- (NSString *)xz_themeStyleSheetName;
@end

NS_ASSUME_NONNULL_END
