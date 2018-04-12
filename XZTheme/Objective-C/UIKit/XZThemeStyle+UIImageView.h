//
//  XZThemeStyle+UIImageView.h
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

@interface XZThemeStyle (UIImageView)

- (UIImage * _Nullable)imageForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIImage * _Nullable image;

- (UIImage * _Nullable)highlightedImageForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIImage * _Nullable highlightedImage;

- (NSArray<UIImage *> * _Nullable)animationImagesForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, copy) NSArray<UIImage *> * _Nullable animationImages;

- (NSArray<UIImage *> * _Nullable)highlightedAnimationImagesForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, copy) NSArray<UIImage *> * _Nullable highlightedAnimationImages;

- (BOOL)isAnimatingForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly) BOOL isAnimating;

- (BOOL)isHighlightedForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly) BOOL isHighlighted;

@end
