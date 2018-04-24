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
/// - 该类用于派生子类，不可直接实例化使用。
NS_SWIFT_NAME(XZThemeStyle.ValueParser) @interface XZThemeStyleValueParser<T: id>: NSObject

/**
 解析主题属性值。
 @note 子类应该继承并重写此方法。
 
 @param value 待解析的主题属性值。
 @return 解析后的值。
 */
- (nullable T)parse:(nullable id)value;



@end

@interface XZThemeStyleFontValueParser: XZThemeStyleValueParser<UIFont *>
@end
@interface XZThemeStyleColorValueParser: XZThemeStyleValueParser<UIColor *>
@end
@interface XZThemeStyleImageValueParser: XZThemeStyleValueParser<UIImage *>
@end
@interface XZThemeStyleStringValueParser: XZThemeStyleValueParser<NSString *>
@end
@interface XZThemeStyleAttributedStringValueParser: XZThemeStyleValueParser<NSAttributedString *>
@end
@interface XZThemeStyleStringAttributesValueParser: XZThemeStyleValueParser<NSDictionary<NSAttributedStringKey,id> *>
@end


