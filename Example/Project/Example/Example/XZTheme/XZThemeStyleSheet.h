//
//  XZThemeStyleSheet.h
//  Example
//
//  Created by 徐臻 on 2018/12/21.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+XZThemeSupporting.h"

@class XZThemeStyle;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(XZTheme.StyleSheet)
@interface XZThemeStyleSheet : NSObject

@property (nonatomic, readonly) NSURL *url;
@property (nonatomic, readonly) NSDictionary<XZThemeIdentifier, XZThemeStyle *> *identifiedThemeStyles;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithURL:(NSURL *)sheetURL NS_SWIFT_NAME(init(_:));

- (nullable XZThemeStyle *)themeStyleForObject:(NSObject *)object NS_SWIFT_NAME(themeStyle(for:));

- (void)addThemeStylesFromThemeStyleSheet:(nullable XZThemeStyleSheet *)otherStyleSheet NS_SWIFT_NAME(addThemeStyles(from:));

@end

NS_ASSUME_NONNULL_END
