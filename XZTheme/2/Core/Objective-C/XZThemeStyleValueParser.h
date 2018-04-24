//
//  XZThemeStyleValueParser.h
//  XZKit
//
//  Created by mlibai on 2017/12/21.
//  Copyright © 2017年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XZThemeStyle;

/// 主题属性值解析。
/// @note 该类用于派生子类，不可直接实例化使用。
NS_SWIFT_NAME(XZThemeStyle.ValueParser)
@interface XZThemeStyleValueParser<T: id>: NSObject

/// 解析主题属性值。
/// @note 子类应该继承并重写此方法。
///
/// @param value 待解析的主题属性值。
/// @return 解析后的值。
- (nullable T)parse:(nullable id)value;

@end

NS_SWIFT_NAME(XZThemeStyle.FontParser)
@interface XZThemeStyleFontParser: XZThemeStyleValueParser<UIFont *>
@property (class, nonatomic, nonnull, readonly) XZThemeStyleFontParser *defaultParser NS_SWIFT_NAME(default);
@end

NS_SWIFT_NAME(XZThemeStyle.ColorParser)
@interface XZThemeStyleColorParser: XZThemeStyleValueParser<UIColor *>
@property (class, nonatomic, nonnull, readonly) XZThemeStyleColorParser *defaultParser NS_SWIFT_NAME(default);
@end

NS_SWIFT_NAME(XZThemeStyle.ImageParser)
@interface XZThemeStyleImageParser: XZThemeStyleValueParser<UIImage *>
@property (class, nonatomic, nonnull, readonly) XZThemeStyleImageParser *defaultParser NS_SWIFT_NAME(default);
@end

NS_SWIFT_NAME(XZThemeStyle.StringParser)
@interface XZThemeStyleStringParser: XZThemeStyleValueParser<NSString *>
@property (class, nonatomic, nonnull, readonly) XZThemeStyleStringParser *defaultParser NS_SWIFT_NAME(default);
@end

NS_SWIFT_NAME(XZThemeStyle.AttributedStringParser)
@interface XZThemeStyleAttributedStringParser: XZThemeStyleValueParser<NSAttributedString *>
@property (class, nonatomic, nonnull, readonly) XZThemeStyleAttributedStringParser *defaultParser NS_SWIFT_NAME(default);
@end

NS_SWIFT_NAME(XZThemeStyle.StringAttributesParser)
@interface XZThemeStyleStringAttributesParser: XZThemeStyleValueParser<NSDictionary<NSAttributedStringKey,id> *>
@property (class, nonatomic, nonnull, readonly) XZThemeStyleStringAttributesParser *defaultParser NS_SWIFT_NAME(default);
@end


