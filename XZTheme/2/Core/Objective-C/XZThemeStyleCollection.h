//
//  XZThemeStyleSet.h
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyle.h"
#import "XZThemeDefines.h"
@class XZThemeCollection;

/// XZThemeStyleSet 是 XZThemeStyle 的集合，管理了主题样式的状态和属性值。
/// XZThemeStyleSet 本身也是主题样式，主题的默认状态（XZThemeStateNormal）的样式即为 XZThemeStyles 自身。
/// @note XZThemeStyleSet 为其它四种常用状态样式提供懒加载属性，方便直接调用。
NS_SWIFT_NAME(XZThemeStyle.Collection)
XZ_THEME_SUBCLASSING_RESTRICTED
@interface XZThemeStyleCollection : XZThemeStyle

/// 所有状态，至少有一个状态 Normal 。
@property (nonatomic, copy, readonly, nonnull) NSArray<XZThemeState> *themeStates;

/// 获取指定状态下的样式属性配置。
///
/// @param themeState 主题状态。
/// @return 主题样式。
- (nullable XZThemeStyle *)themeStyleForThemeState:(nonnull XZThemeState)themeState;

/// 获取指定状态下的样式属性配置，懒加载。
///
/// @param themeState 主题状态。
/// @return 主题样式。
- (nonnull XZThemeStyle *)themeStyleLazyLoadForThemeState:(nonnull XZThemeState)themeState;

/// 添加/修改/删除多状态样式。
/// @note 添加 XZThemeStateNormal 的样式无效。
/// @note 如果样式已存在，则会被替换。
/// @note 样式的所有者，必须相同。
///
/// @param themeStyle 待添加的样式。
/// @param themeState 待添加的样式状态。
- (void)setThemeStyle:(nullable XZThemeStyle *)themeStyle forThemeState:(nonnull XZThemeState)themeState;

@end


@interface XZThemeStyleCollection (XZExtendedThemeStyles)

/// XZThemeStateNormal 状态下的主题样式，当前对象自身。
@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *normalStyle      NS_SWIFT_NAME(normal);
/// XZThemeStateHighlighted  状态下的主题样式，懒加载。
@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *highlightedStyle NS_SWIFT_NAME(highlighted);
/// XZThemeStateSelected  状态下的主题样式，懒加载。
@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *selectedStyle    NS_SWIFT_NAME(selected);
/// XZThemeStateDisabled  状态下的主题样式，懒加载。
@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *disabledStyle    NS_SWIFT_NAME(disabled);
/// XZThemeStateFocused  状态下的主题样式，懒加载。
@property (nonatomic, strong, readonly, nonnull) XZThemeStyle *focusedStyle     NS_SWIFT_NAME(focused);

/// XZThemeStateHighlighted  状态下的主题样式，如果已创建。
@property (nonatomic, strong, readonly, nullable) XZThemeStyle *highlightedStyleIfLoaded NS_SWIFT_NAME(highlightedIfLoaded);
/// XZThemeStateSelected  状态下的主题样式，如果已创建。
@property (nonatomic, strong, readonly, nullable) XZThemeStyle *selectedStyleIfLoaded    NS_SWIFT_NAME(selectedIfLoaded);
/// XZThemeStateDisabled  状态下的主题样式，如果已创建。
@property (nonatomic, strong, readonly, nullable) XZThemeStyle *disabledStyleIfLoaded    NS_SWIFT_NAME(disabledIfLoaded);
/// XZThemeStateFocused  状态下的主题样式，如果已创建。
@property (nonatomic, strong, readonly, nullable) XZThemeStyle *focusedStyleIfLoaded     NS_SWIFT_NAME(focusedIfLoaded);

@end
