//
//  XZThemeStyle+UIButton.h
//  XZKit
//
//  Created by mlibai on 2017/12/7.
//

#import <UIKit/UIKit.h>
#import "XZThemeDefines.h"
#import "XZThemeStyle.h"


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
