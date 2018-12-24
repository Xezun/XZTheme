//
//  XZTheme.h
//  Example
//
//  Created by 徐臻 on 2018/12/21.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+XZThemeSupporting.h"

@class XZThemeStyleSheet;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(Theme)
@interface XZTheme : NSObject <NSCopying>

+ (XZTheme *)themeNamed:(NSString *)name NS_SWIFT_NAME(init(named:));

@property (nonatomic, readonly) NSString *name;
- (instancetype)init NS_UNAVAILABLE;

- (BOOL)isEqualToTheme:(nullable XZTheme *)otherTheme;

@property (class, nonatomic, readonly) XZTheme *defaultTheme NS_SWIFT_NAME(default);
@property (class, nonatomic, readonly) XZTheme *currentTheme NS_SWIFT_NAME(current);

- (nullable XZThemeStyleSheet *)themeStyleSheetForObject:(NSObject *)object;

@end

NS_ASSUME_NONNULL_END
