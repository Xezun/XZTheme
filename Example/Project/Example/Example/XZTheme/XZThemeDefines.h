//
//  XZThemeDefines.h
//  Example
//
//  Created by 徐臻 on 2018/12/21.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 主题状态。
typedef NSString * XZThemeState NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(XZThemeStyle.State);
/// 主题属性。
typedef NSString * XZThemeAttribute NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(XZThemeStyle.Attribute);
/// 主题标识符。
typedef NSString * XZThemeIdentifier NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(XZTheme.Identifier);

NS_ASSUME_NONNULL_BEGIN

/// 没有主题状态。
FOUNDATION_EXPORT XZThemeState const XZThemeStateNone NS_SWIFT_NAME(none);

@protocol XZThemeSupporting <NSObject>
@property (nonatomic, nullable, setter=xz_setThemeIdentifier:) XZThemeIdentifier xz_themeIdentifier NS_SWIFT_NAME(themeIdentifier);
- (void)xz_setNeedsThemeAppearanceUpdate NS_SWIFT_NAME(setNeedsThemeAppearanceUpdate());
@property (nonatomic, nullable, readonly) NSString *xz_styleSheetName NS_SWIFT_NAME(styleSheetName);
@end




NS_ASSUME_NONNULL_END
