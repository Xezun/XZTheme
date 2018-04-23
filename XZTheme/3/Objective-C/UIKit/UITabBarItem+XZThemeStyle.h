//
//  XZThemeStyle+UITabBarItem.h
//  XZKit
//
//  Created by mlibai on 2017/12/7.
//

#import <UIKit/UIKit.h>
#import "XZThemeDefines.h"
#import "XZThemeStyle.h"


@class UIImage;

@interface XZThemeStyle (UITabBarItem)

- (UIImage * _Nullable)selectedImageForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIImage * _Nullable selectedImage;

- (NSDictionary<NSAttributedStringKey, id> * _Nullable)titleTextAttributesForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, copy) NSDictionary<NSAttributedStringKey, id> * _Nullable titleTextAttributes;

- (UIImage * _Nullable)landscapeImagePhoneForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIImage * _Nullable landscapeImagePhone;

- (UIImage * _Nullable)largeContentSizeImageForState:(XZThemeState _Nonnull)state;
@property (nonatomic, readonly, strong) UIImage * _Nullable largeContentSizeImage;

@end
