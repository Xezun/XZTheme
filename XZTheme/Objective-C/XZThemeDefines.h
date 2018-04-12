//
//  XZThemeDefines.h
//  XZKit
//
//  Created by mlibai on 2017/10/14.
//

#import <Foundation/Foundation.h>

/// 主题标识符，复合标识符用空格间隔。
/// @note 请不要使用空字符串作为标识符。
/// @note 在 Swift 中，复合标识符可以用数组表示，Objective-C 中只能使用空格隔开的字符串。
/// @note 在 Swift 中，可以使用字符串字面量创建标识符，可以使用 for-in 遍历其中的子标识符。
typedef NSString * XZThemeIdentifier NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(Theme.Identifier);

/// 主题样式属性。
/// @note 自定义属性，请以 . 开头。
typedef NSString * XZThemeAttribute NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(Theme.Attribute);

/// 主题样式属性状态。
/// @note 自定义属性状态，请以 : 开头。
typedef NSString * XZThemeState NS_EXTENSIBLE_STRING_ENUM NS_SWIFT_NAME(Theme.State);

