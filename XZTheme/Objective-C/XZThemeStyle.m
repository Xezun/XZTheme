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


/// 解析配置中的属性值。如果值是 nil 则转化为 [NSNull null]，否则原样返回。
static id _Nullable EscapeNilValue(id _Nullable value);
static void ParseThemeStyleConfiguration(NSDictionary *configuration, XZThemeStyle *style);

@interface XZThemeStyle () {
    /// 样式存储，非空。
    NSMutableDictionary<XZThemeAttribute, NSMutableDictionary<XZThemeState, id> *> * _Nonnull _attributedValues;
    /// 子样式存储，非空。
    NSMutableDictionary<NSString *, XZThemeStyle *> * _Nonnull _keyedSubstyles;
}

@end

@implementation XZThemeStyle

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        /// 背景色默认 nil ，不继承上一个样式。
        _attributedValues = [NSMutableDictionary dictionaryWithObject:[NSMutableDictionary dictionaryWithObject:[NSNull null] forKey:XZThemeStateNormal] forKey:XZThemeAttributeBackgroundColor];
        _keyedSubstyles = [NSMutableDictionary dictionary];
    }
    return self;
}

// 属性

- (NSArray<XZThemeAttribute> *)attributes {
    return [_attributedValues allKeys];
}

- (NSDictionary<NSString *,XZThemeStyle *> *)substyles {
    return [_keyedSubstyles copy];
}

+ (instancetype)themeStyleWithConfiguration:(NSDictionary *)configuration {
    XZThemeStyle *themeStyle = [[self alloc] init];
    ParseThemeStyleConfiguration(configuration, themeStyle);
    return themeStyle;
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
    [_keyedSubstyles setObject:[substyle copy] forKeyedSubscript:aKey];
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
        _attributedValues[attribute] = statedValues;
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




NSString * const _Nonnull XZThemeStyleConfigurationValueNone = @"nil";

static inline id _Nullable EscapeNilValue(id _Nullable value) {
    if (![value isKindOfClass:[NSString class]]) {
        return value;
    }
    
    NSString *aString = (NSString *)value;
    
    if ([aString isEqualToString:XZThemeStyleConfigurationValueNone]) {
        return [NSNull null];
    }
    
    if ([aString hasPrefix:@"\\"]) {
        // 因为显示 nil 字符串的机会很低，这里不会对性能造成很大影响。
        NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"^\\\\+nil$" options:0 error:NULL];
        // 如果是以双斜线开头，匹配其模式是否为 \\\\nil 格式。
        NSRange range1 = NSMakeRange(0, aString.length);
        NSRange range2 = [regularExpression rangeOfFirstMatchInString:aString options:(0) range:range1];
        if (NSEqualRanges(range1, range2)) {
            return [aString substringFromIndex:1];
        }
    }
    return aString;
}

/// 检查字符串指定范围的字符是否符合指定的正则表达式。
static inline BOOL CheckName(NSString *aString, NSInteger location, NSRegularExpression *regularExpression) {
    if (aString.length <= location) {
        return NO;
    }
    NSRange range1 = NSMakeRange(location, aString.length - location);
    NSRange range2 = [regularExpression rangeOfFirstMatchInString:aString options:(0) range:range1];
    return NSEqualRanges(range1, range2);
}

static void ParseThemeStyleConfiguration(NSDictionary *configuration, XZThemeStyle *themeStyle) {
    // 配置字典 Key-Value 可能包含三种情况：<属性：状态字典或样式值>、<状态：属性-样式字典>、<子样式配置>。
    NSMutableDictionary<XZThemeAttribute, id>         * __block result1 = [NSMutableDictionary dictionary];
    NSMutableDictionary<XZThemeState, NSDictionary *> * __block result2 = [NSMutableDictionary dictionary];
    NSMutableDictionary<NSString *, NSDictionary *>   * __block result3 = [NSMutableDictionary dictionary];
    
    NSCharacterSet *trimmingCharacters = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"^[A-Za-z0-9_\\-]+$" options:0 error:NULL];
    
    [configuration enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull configKey, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![configKey isKindOfClass:[NSString class]]) {
            NSLog(@"Unrecognizable key `%@` in XZThemeStyle configuration. \n%@", configKey, configuration);
            return;
        }
        // 去首位空格。
        NSString *const aKey = [configKey stringByTrimmingCharactersInSet:trimmingCharacters];
        if (aKey.length == 0) { return; }
        switch ([aKey characterAtIndex:0]) {
            case '.': {
                // 子样式可能为：".name" or ".name1 .name2"
                // 子样式在这里不处理，留到步骤三。
                // 子样式名处理为 name.name1.name2 格式。
                if (aKey.length > 2) {
                    NSString *aString = [aKey stringByReplacingOccurrencesOfString:@" " withString:@""];
                    NSString *substyleName = [aString substringFromIndex:1];
                    result3[substyleName] = obj;
                } else {
                    NSLog(@"不合法的子样式名: %@", configKey);
                }
                break;
            }
            case ':':
                if (CheckName(aKey, 1, regularExpression)) {
                    result2[aKey] = obj;
                } else {
                    NSLog(@"不合法的样式属性状态名: %@", configKey);
                }
                break;
                
            default:
                if (CheckName(aKey, 0, regularExpression)) {
                    result1[aKey] = obj;
                } else {
                    NSLog(@"不合法的样式属性名: %@", configKey);
                }
                break;
        }
    }];
    
    // <属性: 状态-值字典或属性值>
    [result1 enumerateKeysAndObjectsUsingBlock:^(XZThemeAttribute  _Nonnull attribute, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            // 判断字典是否为 <状态:样式值> 字典: {"backgroundColor": {":normal": #fff, ":selected": #f00}}
            BOOL __block isStatedValues = YES;
            NSMutableDictionary<XZThemeState, id> *statedValues = [NSMutableDictionary dictionary];
            [(NSDictionary *)obj enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                if ([key isKindOfClass:[NSString class]]) {
                    NSString *aKey = [key stringByTrimmingCharactersInSet:trimmingCharacters];
                    if ([aKey hasPrefix:@":"]) {
                        if (CheckName(aKey, 1, regularExpression)) {
                            [statedValues setObject:obj forKeyedSubscript:aKey];
                        } else {
                            NSLog(@"不合法的字样式属性状态名: %@", key);
                        }
                        return;
                    }
                }
                *stop = YES;
                isStatedValues = NO;
            }];
            // 如果为 状态-样式值 字典，遍历并存储，否则作为属性值存储。
            if (isStatedValues) {
                [statedValues enumerateKeysAndObjectsUsingBlock:^(XZThemeState _Nonnull state, id  _Nonnull value, BOOL * _Nonnull stop) {
                    [themeStyle setValue:EscapeNilValue(value) forAttribute:attribute forState:state];
                }];
            } else {
                [themeStyle setValue:obj forAttribute:attribute forState:XZThemeStateNormal];
            }
        } else {
            [themeStyle setValue:EscapeNilValue(obj) forAttribute:attribute forState:XZThemeStateNormal];
        }
    }];
    
    // <状态:属性键值字典>
    [result2 enumerateKeysAndObjectsUsingBlock:^(XZThemeState _Nonnull state, NSDictionary * _Nonnull attributedValues, BOOL * _Nonnull stop) {
        [attributedValues enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
            if ([key isKindOfClass:[NSString class]]) {
                XZThemeAttribute attribute = [key stringByTrimmingCharactersInSet:trimmingCharacters];
                if (CheckName(attribute, 0, regularExpression)) {
                    [themeStyle setValue:EscapeNilValue(value) forAttribute:attribute forState:state];
                    return;
                }
            }
            NSLog(@"不合法的样式属性名：%@", key);
        }];
    }];
    
    // 子样式 key 已处理为 name.name1.name2 格式。
    [result3 enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSDictionary * _Nonnull obj, BOOL * _Nonnull stop) {
        NSArray<NSString *> *substyleNames = [key componentsSeparatedByString:@"."];
        for (NSString *substyleName in substyleNames) {
            if (CheckName(substyleName, 0, regularExpression)) {
                // TODO: 是否需要考虑子样式合并的问题。
                XZThemeStyle *substyle = [XZThemeStyle themeStyleWithConfiguration:obj];
                [themeStyle setSubstyle:substyle forKey:key];
            } else {
                NSLog(@"不合法的字样式子样式名: %@", substyleName);
            }
        }
        
    }];
}
