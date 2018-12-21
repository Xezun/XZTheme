//
//  NSObject+XZTheme.h
//  Example
//
//  Created by 徐臻 on 2018/12/21.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZThemeDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class XZTheme, XZThemeStyle;

@interface NSObject (XZTheme) <XZThemeSupporting>

@property (nonatomic, nullable, setter=xz_setThemeIdentifier:) XZThemeIdentifier xz_themeIdentifier NS_SWIFT_NAME(themeIdentifier);
@property (nonatomic, nullable, readonly) XZTheme *xz_appliedTheme NS_SWIFT_NAME(appliedTheme);
@property (nonatomic, readonly) BOOL xz_needsUpdateThemeAppearance NS_SWIFT_NAME(needsUpdateThemeAppearance);
@property (nonatomic, readonly) BOOL xz_forwardsThemeAppearanceUpdate NS_SWIFT_NAME(forwardsThemeAppearanceUpdate);

- (void)xz_setNeedsThemeAppearanceUpdate;
- (void)xz_updateThemeAppearanceIfNeeded;
- (void)xz_updateAppearanceWithTheme:(XZTheme *)newTheme;
- (void)xz_updateAppearanceWithThemeStyle:(XZThemeStyle *)themeStyle;


+ (XZThemeStyle *)xz_themeStyleForTheme:(XZTheme *)theme NS_SWIFT_NAME(xz_themeStyle(for:));
+ (XZThemeStyle *)xz_themeStyleIfLoadedForTheme:(XZTheme *)theme NS_SWIFT_NAME(xz_themeStyleIfLoaded(for:));

- (XZThemeStyle *)xz_themeStyleForTheme:(XZTheme *)theme NS_SWIFT_NAME(xz_themeStyle(for:));
- (XZThemeStyle *)xz_themeStyleIfLoadedForTheme:(XZTheme *)theme NS_SWIFT_NAME(xz_themeStyleIfLoaded(for:));

@property (nonatomic, nullable, readonly) XZThemeStyle *xz_computedThemeStyle NS_SWIFT_NAME(computedThemeStyle);

@end

NS_ASSUME_NONNULL_END
