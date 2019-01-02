//
//  XZThemeStyleSheet.h
//  Example
//
//  Created by 徐臻 on 2019/1/2.
//  Copyright © 2019 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZTheme.h"

NS_ASSUME_NONNULL_BEGIN

/// 主题样式表。
NS_SWIFT_NAME(XZTheme.StyleSheet)
@interface XZThemeStyleSheet : NSObject
/// xzss 文件路径。
@property (nonatomic, readonly) NSURL *url;
/// 样式。
@property (nonatomic, readonly) NSDictionary<XZThemeIdentifier, XZThemeStyle *> *identifiedThemeStyles NS_SWIFT_NAME(identifiedStyles);

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithURL:(NSURL *)sheetURL NS_SWIFT_NAME(init(_:));

- (nullable XZThemeStyle *)themeStyleForObject:(NSObject *)object NS_SWIFT_NAME(style(for:));

- (void)addThemeStylesFromThemeStyleSheet:(nullable XZThemeStyleSheet *)otherStyleSheet NS_SWIFT_NAME(addStyles(from:));

@end
NS_ASSUME_NONNULL_END
