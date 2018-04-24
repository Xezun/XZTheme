//
//  XZThemeStyles.h
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyle.h"

NS_SWIFT_NAME(Theme.Styles) @interface XZThemeStyles : XZThemeStyle

/// 所有状态，至少有一个状态 Normal 。
@property (nonatomic, copy, readonly, nonnull) NSArray<XZThemeState> *themeStates;

/// 获取指定状态下的样式属性配置。
///
/// @param themeState 主题状态。
/// @return 主题样式。
- (nullable XZThemeStyle *)themeStyleForThemeState:(nonnull XZThemeState)themeState;

/// 添加多状态样式，状态 XZThemeStateNormal 的样式无需添加。
///
/// @param themeStyle 待添加的样式。
/// @param themeState 待添加的样式状态。
- (void)setThemeStyle:(nullable XZThemeStyle *)themeStyle forThemeState:(nonnull XZThemeState)themeState;

@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *normalStyle NS_SWIFT_NAME(normal);

@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *highlightedStyle NS_SWIFT_NAME(highlighted);
@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *selectedStyle    NS_SWIFT_NAME(selected);
@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *disabledStyle    NS_SWIFT_NAME(disabled);
@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *focusedStyle     NS_SWIFT_NAME(focused);

@property (nonatomic, strong, readonly, nullable) XZThemeStyle *highlightedStyleIfLoaded NS_SWIFT_NAME(highlightedIfLoaded);
@property (nonatomic, strong, readonly, nullable) XZThemeStyle *selectedStyleIfLoaded    NS_SWIFT_NAME(selectedIfLoaded);
@property (nonatomic, strong, readonly, nullable) XZThemeStyle *disabledStyleIfLoaded    NS_SWIFT_NAME(disabledIfLoaded);
@property (nonatomic, strong, readonly, nullable) XZThemeStyle *focusedStyleIfLoaded     NS_SWIFT_NAME(focusedIfLoaded);

@end
