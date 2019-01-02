//
//  XZThemeStyle.m
//  Example
//
//  Created by 徐臻 on 2019/1/2.
//  Copyright © 2019 mlibai. All rights reserved.
//

#import "XZThemeStyle.h"

NS_ASSUME_NONNULL_BEGIN
/// 单一状态主题样式。
@interface XZThemeStyle () {
    NSMutableDictionary *_attributedStyleValues;
}
- (instancetype)initWithState:(XZThemeState)themeState NS_DESIGNATED_INITIALIZER;
@end
/// 包含多状态下的主题样式。
@interface XZStatedThemeStyle : XZThemeStyle {
    @package
    NSMutableDictionary<XZThemeState, XZThemeStyle *> *_statedThemeStyles;
}
@property (nonatomic, readonly) NSMutableDictionary<XZThemeState, XZThemeStyle *> *statedThemeStyles;
- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithState:(XZThemeState)themeState NS_UNAVAILABLE;
@end
/// 单一状态私有样式。
@interface XZObjectThemeStyle : XZThemeStyle
@property (nonatomic, weak, nullable, readonly) NSObject *object;
- (instancetype)initWithState:(XZThemeState)themeState NS_UNAVAILABLE;
- (instancetype)initWithObject:(NSObject *)object state:(XZThemeState)themeState NS_DESIGNATED_INITIALIZER;
@end
/// 多个状态私有样式。
@interface XZStatedObjectThemeStyle : XZStatedThemeStyle
@property (nonatomic, weak, nullable, readonly) NSObject *object;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithObject:(NSObject *)object;
@end
NS_ASSUME_NONNULL_END



@implementation XZThemeStyle

+ (XZThemeStyle *)themeStyleForState:(XZThemeState)themeState {
    if ([themeState isEqualToString:XZThemeStateNone]) {
        return [[XZStatedThemeStyle alloc] init];
    } else {
        return [[XZThemeStyle alloc] initWithState:themeState];
    }
}

+ (XZThemeStyle *)themeStyleForObject:(NSObject *)object {
    return [[XZStatedObjectThemeStyle alloc] initWithObject:object];
}

+ (XZThemeStyle *)themeStyleForObject:(NSObject *)object forState:(XZThemeState)themeState {
    if ([themeState isEqualToString:XZThemeStateNone]) {
        return [[XZStatedObjectThemeStyle alloc] initWithObject:object];
    } else {
        return [[XZObjectThemeStyle alloc] initWithObject:object state:themeState];
    }
}

- (instancetype)initWithState:(XZThemeState)themeState {
    self = [super init];
    if (self != nil) {
        _state = [themeState copy];
        _attributedStyleValues = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSDictionary<XZThemeAttribute,id> *)attributedStyleValues {
    return _attributedStyleValues;
}

- (id)valueForAttribute:(XZThemeAttribute)themeAttribute {
    return _attributedStyleValues[themeAttribute];
}

- (void)setValue:(id)value forAttribute:(XZThemeAttribute)themeAttribute {
    _attributedStyleValues[themeAttribute] = value;
}

- (id)objectForKeyedSubscript:(XZThemeAttribute)themeAttribute {
    return [self valueForAttribute:themeAttribute];
}

- (void)setObject:(id)value forKeyedSubscript:(XZThemeAttribute)themeAttribute {
    [self setValue:value forAttribute:themeAttribute];
}

- (BOOL)containsAttribute:(XZThemeAttribute)themeAttribute {
    return _attributedStyleValues[themeAttribute] != nil;
}

- (void)addValuesFromThemeStyle:(XZThemeStyle *)themeStyle {
    if (themeStyle == nil) {
        return;
    }
    [themeStyle.attributedStyleValues enumerateKeysAndObjectsUsingBlock:^(XZThemeAttribute _Nonnull themeAttribute, id _Nonnull value, BOOL * _Nonnull stop) {
        [self->_attributedStyleValues setObject:value forKeyedSubscript:themeAttribute];
    }];
    // 如果目标样式是集合样式。
    if ([themeStyle isKindOfClass:[XZStatedThemeStyle class]]) {
        themeStyle = [(XZStatedThemeStyle *)themeStyle themeStyleIfLoadedForState:_state];
        [themeStyle.attributedStyleValues enumerateKeysAndObjectsUsingBlock:^(XZThemeAttribute _Nonnull themeAttribute, id  _Nonnull value, BOOL * _Nonnull stop) {
            [self->_attributedStyleValues setObject:value forKeyedSubscript:themeAttribute];
        }];
    }
}

- (XZThemeStyle *)themeStyleIfLoadedForState:(XZThemeState)themeState {
    return self;
}

- (XZThemeStyle *)themeStyleForState:(XZThemeState)themeState {
    return self;
}

- (id)valueForAttribute:(XZThemeAttribute)themeAttribute forState:(XZThemeState)themeState {
    return [self valueForAttribute:themeAttribute forState:(XZThemeStateNone)];
}

- (void)setValue:(id)value forAttribute:(XZThemeAttribute)themeAttribute forState:(XZThemeState)themeState {
    [self setValue:value forAttribute:themeAttribute forState:(XZThemeStateNone)];
}

@end


@implementation XZStatedThemeStyle

@synthesize statedThemeStyles = _statedThemeStyles;

- (instancetype)init {
    self = [super initWithState:(XZThemeStateNone)];
    if (self != nil) {
        _statedThemeStyles = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addValuesFromThemeStyle:(XZThemeStyle *)themeStyle {
    if (themeStyle == nil) {
        return;
    }
    if ([themeStyle isKindOfClass:[XZStatedThemeStyle class]]) {
        [themeStyle.attributedStyleValues enumerateKeysAndObjectsUsingBlock:^(XZThemeAttribute  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self setValue:obj forAttribute:key];
        }];
        XZStatedThemeStyle *statedThemeStyle = (XZStatedThemeStyle *)themeStyle;
        [statedThemeStyle->_statedThemeStyles enumerateKeysAndObjectsUsingBlock:^(XZThemeState _Nonnull themeState, XZThemeStyle * _Nonnull themeStyle, BOOL * _Nonnull stop) {
            XZThemeStyle *newThemeStyle = [self themeStyleForState:themeState];
            [themeStyle.attributedStyleValues enumerateKeysAndObjectsUsingBlock:^(XZThemeAttribute _Nonnull themeAttribute, id  _Nonnull value, BOOL * _Nonnull stop) {
                [newThemeStyle setValue:value forAttribute:themeAttribute];
            }];
        }];
    } else {
        XZThemeStyle *newThemeStyle = [self themeStyleForState:themeStyle.state];
        [themeStyle.attributedStyleValues enumerateKeysAndObjectsUsingBlock:^(XZThemeAttribute _Nonnull themeAttribute, id  _Nonnull value, BOOL * _Nonnull stop) {
            [newThemeStyle setValue:value forAttribute:themeAttribute];
        }];
    }
}

- (XZThemeStyle *)themeStyleIfLoadedForState:(XZThemeState)themeState {
    if ([themeState isEqualToString:XZThemeStateNone]) {
        return self;
    }
    return _statedThemeStyles[themeState];
}

- (XZThemeStyle *)themeStyleForState:(XZThemeState)themeState {
    XZThemeStyle *themeStyle = [self themeStyleIfLoadedForState:themeState];
    if (themeStyle != nil) {
        return themeStyle;
    }
    themeStyle = [XZThemeStyle themeStyleForState:themeState];
    _statedThemeStyles[themeState] = themeStyle;
    return themeStyle;
}

- (id)valueForAttribute:(XZThemeAttribute)themeAttribute forState:(XZThemeState)themeState {
    return [[self themeStyleIfLoadedForState:themeState] valueForAttribute:themeAttribute];
}

- (void)setValue:(id)value forAttribute:(XZThemeAttribute)themeAttribute forState:(XZThemeState)themeState {
    [[self themeStyleForState:themeState] setValue:value forAttribute:themeAttribute];
}

@end


@implementation XZObjectThemeStyle

- (instancetype)initWithObject:(NSObject *)object state:(XZThemeState)themeState {
    self = [super initWithState:themeState];
    if (self != nil) {
        _object = object;
    }
    return self;
}

- (void)setValue:(id)value forAttribute:(XZThemeAttribute)themeAttribute {
    [super setValue:value forAttribute:themeAttribute];
    [_object xz_themeStyleDidChange];
}

- (void)addValuesFromThemeStyle:(XZThemeStyle *)themeStyle {
    [super addValuesFromThemeStyle:themeStyle];
    [_object xz_themeStyleDidChange];
}

@end

@implementation XZStatedObjectThemeStyle

- (instancetype)initWithObject:(NSObject *)object {
    self = [super init];
    if (self != nil) {
        _object = object;
    }
    return self;
}

- (void)setValue:(id)value forAttribute:(XZThemeAttribute)themeAttribute {
    [super setValue:value forAttribute:themeAttribute];
    [_object xz_themeStyleDidChange];
}

- (void)addValuesFromThemeStyle:(XZThemeStyle *)themeStyle {
    [super addValuesFromThemeStyle:themeStyle];
    [_object xz_themeStyleDidChange];
}

- (XZThemeStyle *)themeStyleForState:(XZThemeState)themeState {
    XZThemeStyle *themeStyle = [self themeStyleIfLoadedForState:themeState];
    if (themeStyle != nil) {
        return themeStyle;
    }
    themeStyle = [XZThemeStyle themeStyleForObject:_object forState:themeState];
    _statedThemeStyles[themeState] = themeStyle;
    return themeStyle;
}

@end
