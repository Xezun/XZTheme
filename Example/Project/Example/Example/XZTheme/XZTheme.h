//
//  XZTheme.h
//  Example
//
//  Created by 徐臻 on 2018/12/21.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 主题状态。
typedef NSString * XZThemeState NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(XZThemeStyle.State);
/// 主题属性。
typedef NSString * XZThemeAttribute NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(XZThemeStyle.Attribute);
/// 主题标识符。
typedef NSString * XZThemeIdentifier NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(XZTheme.Identifier);

FOUNDATION_EXPORT XZThemeState const XZThemeStateNone NS_SWIFT_NAME(none);

@class XZTheme, XZThemeStyle, XZThemeStyleSheet;

NS_ASSUME_NONNULL_BEGIN

/// 主题。
NS_SWIFT_NAME(Theme)
@interface XZTheme : NSObject <NSCopying>

/// 默认主题。
@property (class, nonatomic, readonly) XZTheme *defaultTheme NS_SWIFT_NAME(default);
/// 当前主题。
@property (class, nonatomic, readonly) XZTheme *currentTheme NS_SWIFT_NAME(current);

/// 构造主题对象。
///
/// @param name 主题名称。
+ (XZTheme *)themeNamed:(NSString *)name NS_SWIFT_NAME(init(named:));
- (instancetype)init NS_UNAVAILABLE;

/// 主题名称。
@property (nonatomic, readonly) NSString *name;

/// 判断两个主题是否是同一主题。
///
/// @param otherTheme 待比较的主题。
/// @return 是否相同。
- (BOOL)isEqualToTheme:(nullable XZTheme *)otherTheme;

/// 获取对象的主题样式表。
///
/// @param object 对象。
/// @return 主题样式表对象。
- (nullable XZThemeStyleSheet *)themeStyleSheetForObject:(NSObject *)object NS_SWIFT_NAME(themeStyleSheet(for:));

@end


/// 主题样式。
NS_SWIFT_NAME(XZTheme.Style)
@interface XZThemeStyle : NSObject

/// 构造指定状态下的主题样式。
///
/// @param themeState 主题状态。
/// @return 主题样式 XZThemeStyle 对象。
+ (XZThemeStyle *)themeStyleForState:(XZThemeState)themeState NS_SWIFT_NAME(init(for:));
/// 给指定对象构造私有样式。
///
/// @param object 主题样式所属的对象。
/// @return 主题样式 XZThemeStyle 对象。
+ (XZThemeStyle *)themeStyleForObject:(NSObject *)object NS_SWIFT_NAME(init(for:));
/// 为对象构造指定状态下的主题样式。
///
/// @param themeState 主题状态。
/// @param object 主题样式所属的对象。
/// @return 主题样式 XZThemeStyle 对象。
+ (XZThemeStyle *)themeStyleForState:(XZThemeState)themeState object:(nullable NSObject *)object NS_SWIFT_NAME(init(for:object:));

/// 主题状态。
@property (nonatomic, copy, readonly) XZThemeState state;
/// 主题属性与值。
@property (nonatomic, readonly) NSDictionary<XZThemeAttribute, id> *attributedStyleValues;

- (instancetype)init NS_UNAVAILABLE;

/// 获取主题属性对应的样式值。
///
/// @param themeAttribute 主题属性。
/// @return 主题样式值。
- (nullable id)valueForAttribute:(XZThemeAttribute)themeAttribute NS_SWIFT_NAME(value(for:));
/// 设置主题属性样式值。
///
/// @param value 主题样式值。
/// @param themeAttribute 主题属性。
- (void)setValue:(nullable id)value forAttribute:(XZThemeAttribute)themeAttribute NS_SWIFT_NAME(setValue(_:for:));

/// 获取主题属性对应的样式值。
///
/// @param themeAttribute 主题属性。
/// @return 主题样式值。
- (nullable id)objectForKeyedSubscript:(XZThemeAttribute)themeAttribute;
/// 设置主题属性样式值。
///
/// @param value 主题样式值。
/// @param themeAttribute 主题属性。
- (void)setObject:(nullable id)value forKeyedSubscript:(XZThemeAttribute)themeAttribute;

/// 主题样式中是否包含指定主题属性。
///
/// @param themeAttribute 主题属性。
/// @return 是否包含主题属性。
- (BOOL)containsAttribute:(XZThemeAttribute)themeAttribute NS_SWIFT_NAME(contains(_:));

/// 将另一个主题样式中的所有值复制到当前主题样式中。
///
/// @param themeStyle 被复制到主题样式。
- (void)addValuesFromThemeStyle:(nullable XZThemeStyle *)themeStyle NS_SWIFT_NAME(addValues(from:));

/// 获取指定主题状态下的主题样式。
///
/// @param themeState 主题状态。
/// @return 主题样式。
- (nullable XZThemeStyle *)themeStyleIfLoadedForState:(XZThemeState)themeState NS_SWIFT_NAME(themeStyleIfLoaded(for:));
/// 获取指定主题状态下的主题样式，懒加载。
///
/// @param themeState 主题状态。
/// @return 主题样式。
- (XZThemeStyle *)themeStyleForState:(XZThemeState)themeState NS_SWIFT_NAME(themeStyle(for:));

- (nullable id)valueForAttribute:(XZThemeAttribute)themeAttribute forState:(XZThemeState)themeState NS_SWIFT_NAME(value(for:for:));
- (void)setValue:(nullable id)value forAttribute:(XZThemeAttribute)themeAttribute forState:(XZThemeState)themeState NS_SWIFT_NAME(setValue(_:for:for:));

@end


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





@interface NSObject (XZTheme)

/// 主题标识符，用于在样式表中匹配主题样式。
@property (nonatomic, nullable, setter=xz_setThemeIdentifier:) XZThemeIdentifier xz_themeIdentifier NS_SWIFT_NAME(themeIdentifier);
/// 当前已应用的主题。
@property (nonatomic, nullable, readonly) XZTheme *xz_appliedTheme NS_SWIFT_NAME(appliedTheme);
/// 当前对象是否已经被标记为需要更新主题外观样式。
@property (nonatomic, readonly) BOOL xz_needsUpdateThemeAppearance NS_SWIFT_NAME(needsUpdateThemeAppearance);

/// 标记当前对象需要更新主题，在同一 runloop 中，该操作只会被标记一次，并在下一个 runloop 中执行更新操作。
- (void)xz_setNeedsThemeAppearanceUpdate NS_SWIFT_NAME(setNeedsThemeAppearanceUpdate());
/// 当前对象被标记为需要更新主题时，将主题事件传递给下一级或子级。
- (void)xz_forwardThemeAppearanceUpdate NS_SWIFT_NAME(forwardThemeAppearanceUpdate());
/// 如果当前对象已被标记需要更新主题，则立即执行更新主题的操作。
- (void)xz_updateThemeAppearanceIfNeeded NS_SWIFT_NAME(updateThemeAppearanceIfNeeded());

/// 应用新的主题，如果对象已被标记为需要更新主题，则此方法一定会被调用。默认情况下，此方法将查找当前对象的主题样式，并
/// 调用应用主题样式的方法。
- (void)xz_updateAppearanceWithTheme:(XZTheme *)newTheme;
/// 应用主题样式。
- (void)xz_updateAppearanceWithThemeStyle:(XZThemeStyle *)themeStyle;

/// 当前类的全局主题样式，懒加载，不可被继承。
///
/// @param theme 主题。
/// @return 全局主题样式。
+ (XZThemeStyle *)xz_themeStyleForTheme:(XZTheme *)theme NS_SWIFT_NAME(xz_themeStyle(for:));
/// 当前类的全局主题样式，不可被继承。
///
/// @param theme 主题。
/// @return 全局主题样式。
+ (XZThemeStyle *)xz_themeStyleIfLoadedForTheme:(XZTheme *)theme NS_SWIFT_NAME(xz_themeStyleIfLoaded(for:));

/// 当前对象的私有样式，懒加载。
///
/// @param theme 主题。
/// @return 私有样式。
- (XZThemeStyle *)xz_themeStyleForTheme:(XZTheme *)theme NS_SWIFT_NAME(xz_themeStyle(for:));
/// 当前对象的私有样式。
///
/// @param theme 主题。
/// @return 私有样式。
- (XZThemeStyle *)xz_themeStyleIfLoadedForTheme:(XZTheme *)theme NS_SWIFT_NAME(xz_themeStyleIfLoaded(for:));

/// 计算样式，应用到当前对象上的样式，不可直接修改计算样式。
@property (nonatomic, nullable, readonly) XZThemeStyle *xz_computedThemeStyle NS_SWIFT_NAME(computedThemeStyle);

/// 样式表名，用于查找当前对象样式表样式，默认 nil ，没有样式表样式。
@property (nonatomic, nullable, readonly) NSString *xz_themeStyleSheetName NS_SWIFT_NAME(themeStyleSheetName);

@end

@interface UIView (XZTheme)
+ (void)load;
- (NSString *)xz_themeStyleSheetName;
- (void)xz_forwardThemeAppearanceUpdate;
@end

@interface UIWindow (XZTheme)
- (NSString *)xz_themeStyleSheetName;
@end

@interface UINavigationItem (XZTheme)
- (NSString *)xz_themeStyleSheetName;
- (void)xz_forwardThemeAppearanceUpdate;
@end

@interface UIViewController (XZTheme)
+ (void)load;
- (NSString *)xz_themeStyleSheetName;
@end

NS_ASSUME_NONNULL_END
