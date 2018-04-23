//
//  XZThemeStyle+UILabel.h
//  XZKit
//
//  Created by mlibai on 2017/12/7.
//

#import <UIKit/UIKit.h>
#import "XZThemeDefines.h"
#import "XZThemeStyle.h"


@class UIFont;

@interface XZThemeStyle (UILabel)

- (NSString * _Nullable)textForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, copy) NSString * _Nullable text;

- (UIColor * _Nullable)textColorForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIColor * _Nullable textColor;

- (UIFont * _Nullable)fontForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIFont * _Nullable font;

- (UIColor * _Nullable)shadowColorForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIColor * _Nullable shadowColor;

- (UIColor * _Nullable)highlightedTextColorForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIColor * _Nullable highlightedTextColor;

@end
