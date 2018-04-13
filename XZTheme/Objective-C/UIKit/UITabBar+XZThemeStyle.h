//
//  XZThemeStyle+UITabBar.h
//  XZKit
//
//  Created by mlibai on 2017/12/7.
//

#import <UIKit/UIKit.h>
#import "XZThemeDefines.h"
#import "XZThemeStyle.h"



@interface XZThemeStyle (UITabBar)

- (UIColor * _Nullable)barTintColorForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIColor * _Nullable barTintColor;

- (UIImage * _Nullable)shadowImageForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIImage * _Nullable shadowImage;

- (UIColor * _Nullable)unselectedItemTintColorForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIColor * _Nullable unselectedItemTintColor;

- (UIImage * _Nullable)selectionIndicatorImageForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIImage * _Nullable selectionIndicatorImage;

@end
