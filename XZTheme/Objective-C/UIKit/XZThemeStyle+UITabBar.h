//
//  XZThemeStyle+UITabBar.h
//  XZKit
//
//  Created by mlibai on 2017/12/7.
//

#import <UIKit/UIKit.h>
#ifdef XZKIT_FRAMEWORK
#import <XZKit/XZThemeDefines.h>
#import <XZKit/XZThemeStyle.h>
#else
#import "XZThemeDefines.h"
#import "XZThemeStyle.h"
#endif



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
