//
//  XZThemeStyle.h
//  Example
//
//  Created by 徐臻 on 2018/12/21.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZThemeDefines.h"

NS_ASSUME_NONNULL_BEGIN

@class XZThemeStyle;

NS_SWIFT_NAME(XZTheme.Style)
@interface XZThemeStyle : NSObject

+ (XZThemeStyle *)themeStyleForState:(XZThemeState)themeState NS_SWIFT_NAME(init(for:));
+ (XZThemeStyle *)themeStyleForObject:(nullable id<XZThemeSupporting>)object NS_SWIFT_NAME(init(for:));
+ (XZThemeStyle *)themeStyleForState:(XZThemeState)themeState object:(nullable id<XZThemeSupporting>)object NS_SWIFT_NAME(init(for:object:));

@property (nonatomic, weak, nullable) id<XZThemeSupporting> object;
@property (nonatomic, copy, readonly) XZThemeState state;
@property (nonatomic, readonly) NSDictionary<XZThemeAttribute, id> *attributedStyleValues;

- (instancetype)init NS_UNAVAILABLE;
- (nullable id)valueForAttribute:(XZThemeAttribute)themeAttribute NS_SWIFT_NAME(value(for:));
- (void)setValue:(nullable id)value forAttribute:(XZThemeAttribute)themeAttribute NS_SWIFT_NAME(setValue(_:for:));

- (nullable id)objectForKeyedSubscript:(XZThemeAttribute)themeAttribute;
- (void)setObject:(nullable id)value forKeyedSubscript:(XZThemeAttribute)themeAttribute;

- (BOOL)containsAttribute:(XZThemeAttribute)themeAttribute NS_SWIFT_NAME(contains(_:));

- (void)addValuesFromThemeStyle:(nullable XZThemeStyle *)themeStyle NS_SWIFT_NAME(addValues(from:));

- (nullable XZThemeStyle *)themeStyleIfLoadedForState:(XZThemeState)themeState NS_SWIFT_NAME(themeStyleIfLoaded(for:));
- (XZThemeStyle *)themeStyleForState:(XZThemeState)themeState NS_SWIFT_NAME(themeStyle(for:));

- (nullable id)valueForAttribute:(XZThemeAttribute)themeAttribute forState:(XZThemeState)themeState NS_SWIFT_NAME(value(for:for:));
- (void)setValue:(nullable id)value forAttribute:(XZThemeAttribute)themeAttribute forState:(XZThemeState)themeState NS_SWIFT_NAME(setValue(_:for:for:));


@end

NS_ASSUME_NONNULL_END
