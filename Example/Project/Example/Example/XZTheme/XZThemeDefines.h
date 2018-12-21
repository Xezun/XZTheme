//
//  XZThemeDefines.h
//  Example
//
//  Created by 徐臻 on 2018/12/21.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString * XZThemeState NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(XZThemeStyle.State);
typedef NSString * XZThemeAttribute NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(XZThemeStyle.Attribute);
typedef NSString * XZThemeIdentifier NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(XZTheme.Identifier);

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT XZThemeState const XZThemeStateNone NS_SWIFT_NAME(none);

@protocol XZThemeSupporting <NSObject>
- (void)xz_setNeedsThemeAppearanceUpdate NS_SWIFT_NAME(setNeedsThemeAppearanceUpdate());
@end




NS_ASSUME_NONNULL_END
