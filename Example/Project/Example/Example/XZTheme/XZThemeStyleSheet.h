//
//  XZThemeStyleSheet.h
//  Example
//
//  Created by 徐臻 on 2018/12/21.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>


@class XZThemeStyle;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(XZTheme.StyleSheet)
@interface XZThemeStyleSheet : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSDictionary<XZThemeIdentifier, XZThemeStyle *> *identifiedThemeStyles;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
