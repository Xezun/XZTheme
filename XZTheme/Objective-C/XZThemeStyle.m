//
//  XZThemeStyle.m
//  XZKit
//
//  Created by mlibai on 2017/10/14.
//

#import "XZThemeStyle.h"
#import "XZThemeState.h"
#import "XZThemeAttribute.h"
#import "XZThemeStyleValueParser.h"
#import "UIColor+XZKit.h"

NSString * const _Nonnull XZThemeStyleConfigurationValueNone = @"\\nil";


/**
 解析配置中的属性值。如果值是 \nil 则转化为 [NSNull null]，否则原样返回。

 @param value 主题样式配置值。
 @param regularExpression 用于判断 nil 格式的正则表达式 <pre>@"^\\\\+nil$"</pre>。
 @return 解析后的值。
 */
static inline id _Nullable parseValue(id _Nullable value, NSRegularExpression * _Nonnull regularExpression) {
    if (![value isKindOfClass:[NSString class]]) {
        return value;
    }
    
    NSString *aString = (NSString *)value;

    if ([aString hasPrefix:@"\\"]) {
        // 判断是否为空值。
        if ([aString isEqualToString:XZThemeStyleConfigurationValueNone]) {
            return [NSNull null];
        }
        // 如果是以双斜线开头，匹配其模式是否为 \\\\nil 格式。
        NSRange range1 = NSMakeRange(0, aString.length);
        NSRange range2 = [regularExpression rangeOfFirstMatchInString:aString options:(0) range:range1];
        if (NSEqualRanges(range1, range2)) {
            return [aString substringFromIndex:1];
        }
    }
    
    return aString;
}




@interface XZThemeStyle () {
    NSMutableDictionary<XZThemeAttribute, NSMutableDictionary<XZThemeState, id> *> *_attributedValues;
    NSMutableDictionary<NSString *, XZThemeStyle *> *_keyedSubstyles;
}

@end

@implementation XZThemeStyle

// 属性

- (NSArray<XZThemeAttribute> *)attributes {
    return [_attributedValues allKeys];
}

- (NSDictionary<NSString *,XZThemeStyle *> *)substyles {
    return [_keyedSubstyles copy];
}

- (NSMutableDictionary<XZThemeAttribute, NSMutableDictionary<XZThemeState, id> *> *)attributedValues {
    if (_attributedValues != nil) {
        return _attributedValues;
    }
    _attributedValues = [NSMutableDictionary dictionary];
    return _attributedValues;
}

- (NSMutableDictionary<NSString *, XZThemeStyle *> *)keyedSubstyles {
    if (_keyedSubstyles != nil) {
        return _keyedSubstyles;
    }
    _keyedSubstyles = [NSMutableDictionary dictionary];
    return _keyedSubstyles;
}

+ (instancetype)themeStyleWithConfiguration:(NSDictionary *)configuration {
    XZThemeStyle *themeStyle = [[self alloc] init];
    [themeStyle addAttributesAndSubstylesFromConfiguration:configuration];
    return themeStyle;
}

// 方法

- (void)addAttributesAndSubstylesFromConfiguration:(NSDictionary * _Nonnull)configuration {
    // 配置字典 Key-Value 可能包含三种情况
    NSMutableDictionary<XZThemeAttribute, id>         * __block result1 = nil; // 属性：状态字典或样式值。
    NSMutableDictionary<XZThemeState, NSDictionary *> * __block result2 = nil; // 状态：属性-样式字典。
    NSMutableDictionary<NSString *, NSDictionary *>   * __block result3 = nil; // 子样式配置。
    [configuration enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![key isKindOfClass:[NSString class]]) {
            NSLog(@"Unrecognizable key `%@` in XZThemeStyle configuration. \n%@", key, configuration);
            return;
        }
        if ([key hasPrefix:@"."]) { // key 主题属性名，value 可能是值，也可能是状态-值字典。
            if (result1 == nil) { result1 = [NSMutableDictionary dictionary]; }
            result1[key] = obj;
            return;
        } else if ([key hasPrefix:@":"]) { // key 状态，value 必须是属性-值字典。
            if ([obj isKindOfClass:[NSDictionary class]]) {
                if (result2 == nil) { result2 = [NSMutableDictionary dictionary]; }
                result2[key] = obj;
            }
            return;
        } else if ([obj isKindOfClass:[NSDictionary class]]) { // key 子样式名，value 是子样式配置字典。
            if (result3 == nil) { result3 = [NSMutableDictionary dictionary]; }
            result3[key] = obj;
            return;
        }
        NSLog(@"Unrecognizable key `%@` and value `%@` in XZThemeStyle configuration. \n%@", key, obj, configuration);
    }];
    
    // 解析 nil 的正则表达式。
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"^\\\\+nil$" options:0 error:NULL];
    
    [result1 enumerateKeysAndObjectsUsingBlock:^(XZThemeAttribute  _Nonnull attribute, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            // 判断字典是否为 状态-样式值 字典。
            BOOL __block isStatedValues = YES;
            [(NSDictionary *)obj enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if ([key isKindOfClass:[NSString class]] && [key hasPrefix:@":"]) { return; }
                *stop = YES;
                isStatedValues = NO;
            }];
            // 如果为 状态-样式值 字典，遍历并存储，否则作为属性值存储。
            if (isStatedValues) {
                [(NSDictionary *)obj enumerateKeysAndObjectsUsingBlock:^(XZThemeState _Nonnull state, id  _Nonnull value, BOOL * _Nonnull stop) {
                    [self setValue:parseValue(value, regularExpression) forAttribute:attribute forState:state];
                }];
            } else {
                [self setValue:obj forAttribute:attribute forState:XZThemeStateNormal];
            }
        } else {
            [self setValue:parseValue(obj, regularExpression) forAttribute:attribute forState:XZThemeStateNormal];
        }
    }];
    
    [result2 enumerateKeysAndObjectsUsingBlock:^(XZThemeState _Nonnull state, NSDictionary * _Nonnull attributedValues, BOOL * _Nonnull stop) {
        [attributedValues enumerateKeysAndObjectsUsingBlock:^(XZThemeAttribute _Nonnull attribute, id  _Nonnull value, BOOL * _Nonnull stop) {
            if (![attribute isKindOfClass:[NSString class]] || ![attribute hasPrefix:@"."]) {
                NSLog(@"Unrecognizable XZThemeAttribute `%@` of state `%@` in XZThemeStyle configuration. \n%@", attribute, state, configuration);
                return;
            }
            [self setValue:parseValue(value, regularExpression) forAttribute:attribute forState:state];
        }];
    }];
    
    [result3 enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSDictionary * _Nonnull obj, BOOL * _Nonnull stop) {
        XZThemeStyle *substyle = [[XZThemeStyle alloc] init];
        [substyle addAttributesAndSubstylesFromConfiguration:obj];
        [self setSubstyle:substyle forKey:key];
    }];
}

- (void)addAttributesAndSubstylesFromStyle:(XZThemeStyle *)style {
    // 合并属性。
    [style->_attributedValues enumerateKeysAndObjectsUsingBlock:^(XZThemeAttribute  _Nonnull attribute, NSMutableDictionary<XZThemeState,id> * _Nonnull dict, BOOL * _Nonnull stop) {
        [dict enumerateKeysAndObjectsUsingBlock:^(XZThemeState _Nonnull state, id _Nonnull value, BOOL * _Nonnull stop) {
            [self setValue:value forAttribute:attribute forState:state];
        }];
    }];
    // 合并子样式：遍历目标样式的子样式，将其添加到子样式中，或合并到相同 Key 的子样式中。
    [style->_keyedSubstyles enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull substyleKey, XZThemeStyle * _Nonnull obj, BOOL * _Nonnull stop) {
        XZThemeStyle *style = [self substyleForKey:substyleKey];
        if (style != nil) {
            [style addAttributesAndSubstylesFromStyle:obj];
        } else {
            [self setSubstyle:obj forKey:substyleKey];
        }
    }];
}

- (id)copyWithZone:(NSZone *)zone {
    XZThemeStyle *newStyle = [[self.class alloc] init];
    [newStyle addAttributesAndSubstylesFromStyle:self];
    return newStyle;
}

// 方法

- (void)setSubstyle:(XZThemeStyle *)substyle forKey:(NSString *)aKey {
    [self.keyedSubstyles setObject:[substyle copy] forKeyedSubscript:aKey];
} 

- (XZThemeStyle *)substyleForKey:(NSString *)aKey {
    return [_keyedSubstyles objectForKeyedSubscript:aKey];
}


- (id)valueForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state {
    id value = [[_attributedValues objectForKeyedSubscript:attribute] objectForKeyedSubscript:state];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

- (void)setValue:(id)value forAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state {
    NSMutableDictionary<XZThemeState, id> *statedValues = _attributedValues[attribute];
    if (statedValues == nil) {
        if (value == nil) { return; }
        statedValues = [NSMutableDictionary dictionary];
        self.attributedValues[attribute] = statedValues;
    }
    statedValues[state] = value;
}


- (id)valueForAttribute:(XZThemeAttribute)attribute {
    return [self valueForAttribute:attribute forState:XZThemeStateNormal];
}

- (void)setValue:(id)value forAttribute:(XZThemeAttribute)attribute {
    [self setValue:value forAttribute:attribute forState:XZThemeStateNormal];
}

@end


@implementation XZThemeStyle (XZExtendedThemeStyle)

// integer

- (NSInteger)integerValueForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state {
    NSNumber *number = [self valueForAttribute:attribute forState:state];
    if ([number respondsToSelector:@selector(integerValue)]) {
        return [number integerValue];
    }
    return 0;
}

- (NSInteger)integerValueForAttribute:(XZThemeAttribute)attribute {
    return [self integerValueForAttribute:attribute forState:XZThemeStateNormal];
}

// float

- (float)floatValueForAttribute:(XZThemeAttribute)attribute forState:(nonnull XZThemeState)state {
    NSNumber *number = [self valueForAttribute:attribute forState:state];
    if ([number respondsToSelector:@selector(floatValue)]) {
        return [number floatValue];
    }
    return 0;
}

- (float)floatValueForAttribute:(XZThemeAttribute)attribute {
    return [self floatValueForAttribute:attribute forState:XZThemeStateNormal];
}

// double

- (double)doubleValueForAttribute:(XZThemeAttribute)attribute forState:(nonnull XZThemeState)state {
    NSNumber *number = [self valueForAttribute:attribute forState:state];
    if ([number respondsToSelector:@selector(doubleValue)]) {
        return [number doubleValue];
    }
    return 0;
}

- (double)doubleValueForAttribute:(XZThemeAttribute)attribute {
    return [self doubleValueForAttribute:attribute forState:XZThemeStateNormal];
}

// bool

- (BOOL)boolValueForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state {
    NSNumber *number = [self valueForAttribute:attribute forState:state];
    if ([number respondsToSelector:@selector(boolValue)]) {
        return [number boolValue];
    }
    return false;
}

- (BOOL)boolValueForAttribute:(XZThemeAttribute)attribute {
    return [self boolValueForAttribute:attribute forState:XZThemeStateNormal];
}

// string 

- (NSString *)stringValueForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state {
    return [[XZThemeStyle stringParser] parse:[self valueForAttribute:attribute forState:state]];
}

- (NSString *)stringValueForAttribute:(XZThemeAttribute)attribute {
    return [[XZThemeStyle stringParser] parse:[self valueForAttribute:attribute forState:XZThemeStateNormal]];
}

// image

- (UIImage *)imageForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state {
    return [[XZThemeStyle imageParser] parse:[self valueForAttribute:attribute forState:state]];
}

- (UIImage *)imageForAttribute:(XZThemeAttribute)attribute {
    return [[XZThemeStyle imageParser] parse:[self valueForAttribute:attribute forState:XZThemeStateNormal]];
}

// colr

- (UIColor *)colorForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state {
    return [[XZThemeStyle colorParser] parse:[self valueForAttribute:attribute forState:state]];
}

- (UIColor *)colorForAttribute:(XZThemeAttribute)attribute {
    return [[XZThemeStyle colorParser] parse:[self valueForAttribute:attribute forState:XZThemeStateNormal]];
}

// font

- (UIFont *)fontForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state {
    return [[XZThemeStyle fontParser] parse:[self valueForAttribute:attribute forState:state]];
}

- (UIFont *)fontForAttribute:(XZThemeAttribute)attribute {
    return [[XZThemeStyle fontParser] parse:[self valueForAttribute:attribute forState:XZThemeStateNormal]];
}

// attributedString

- (NSAttributedString *)attributedStringForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state {
    return [[XZThemeStyle attributedStringParser] parse:[self valueForAttribute:attribute forState:state]];
}

- (NSAttributedString *)attributedStringForAttribute:(XZThemeAttribute)attribute {
    return [[XZThemeStyle attributedStringParser] parse:[self valueForAttribute:attribute forState:XZThemeStateNormal]];
}

// stringAttributes

- (nullable NSDictionary<NSAttributedStringKey, id> *)stringAttributesForAttribute:(XZThemeAttribute)attribute forState:(XZThemeState)state {
    return [[XZThemeStyle stringAttributesParser] parse:[self valueForAttribute:attribute forState:state]];
}

- (nullable NSDictionary<NSAttributedStringKey, id> *)stringAttributesForAttribute:(XZThemeAttribute)attribute {
    return [[XZThemeStyle stringAttributesParser] parse:[self valueForAttribute:attribute forState:XZThemeStateNormal]];
}

@end









