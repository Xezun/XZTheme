//
//  XZTheme.h
//  XZTheme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XZThemeStyles;

typedef NSString * XZTheme NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(Theme);

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN XZTheme const XZThemeDefault;
/// 当主题发生改变时，所发送通知的名称。
UIKIT_EXTERN NSNotificationName const _Nonnull XZThemeDidChangeNotification NS_SWIFT_NAME(ThemeDidChange);

/// 保存默认主题使用的 NSUserDefault 键名。
UIKIT_EXTERN NSString * const _Nonnull XZThemeUserDefaultsKey;

NS_SWIFT_NAME(Themes) @interface XZThemes : NSObject

@property (nonatomic, unsafe_unretained, readonly, nonnull) UIView *object;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithObject:(NSObject *)object NS_DESIGNATED_INITIALIZER NS_SWIFT_NAME(init(_:));

- (nonnull XZThemeStyles *)styleForTheme:(nonnull XZTheme)theme;
- (void)setStyle:(nonnull XZThemeStyles *)style forTheme:(nonnull XZTheme)theme;

/// 默认主题的样式。
@property (nonatomic, nonnull, readonly) XZThemeStyles *defaultStyle NS_SWIFT_NAME(default);

/// 当前主题，默认 XZThemeDefault 。
@property (class, nonatomic, nonnull) XZTheme currentTheme;

@end


@interface NSObject (XZThemeSupporting)

@property (nonatomic, strong, readonly, nonnull) XZThemes *xz_themes NS_SWIFT_NAME(themes);
@property (nonatomic, strong, readonly, nullable) XZThemes *xz_themesIfLoaded NS_SWIFT_NAME(themesIfLoaded);

@end
NS_ASSUME_NONNULL_END
