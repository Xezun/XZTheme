//
//  XZThemeStyle+UIButton.h
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

@class NSAttributedString;

@interface XZThemeStyle (UIButton)

- (NSString * _Nullable)titleForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, copy) NSString * _Nullable title;

- (UIColor * _Nullable)titleColorForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIColor * _Nullable titleColor;

- (UIImage * _Nullable)backgroundImageForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIImage * _Nullable backgroundImage;

- (UIColor * _Nullable)titleShadowColorForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIColor * _Nullable titleShadowColor;

- (NSAttributedString * _Nullable)attributedTitleForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) NSAttributedString * _Nullable attributedTitle;

@end
