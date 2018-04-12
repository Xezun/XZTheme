//
//  XZThemeStyle+UIView.h
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


@interface XZThemeStyle (UIView)

- (UIColor * _Nullable)backgroundColorForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIColor * _Nullable backgroundColor;

- (UIColor * _Nullable)tintColorForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIColor * _Nullable tintColor;

- (BOOL)isHiddenForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly) BOOL isHidden;

- (CGFloat)alphaForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly) CGFloat alpha;

- (BOOL)isOpaqueForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly) BOOL isOpaque;

@end





