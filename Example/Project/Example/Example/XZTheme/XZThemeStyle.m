//
//  XZThemeStyle.m
//  Example
//
//  Created by 徐臻 on 2018/12/21.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import "XZThemeStyle.h"

NS_ASSUME_NONNULL_BEGIN

@interface XZStatedThemeStyle : XZThemeStyle
@property (nonatomic, readonly) NSMutableDictionary<XZThemeState, XZThemeStyle *> *statedThemeStyles;
@end

NS_ASSUME_NONNULL_END

@implementation XZThemeStyle {
    NSMutableDictionary *_attributedStyleValues;
}

+ (XZThemeStyle *)themeStyleForState:(XZThemeState)themeState {
    return [XZThemeStyle themeStyleForState:themeState object:nil];
}

+ (XZThemeStyle *)themeStyleForObject:(id<XZThemeSupporting>)object {
    return [XZThemeStyle themeStyleForState:XZThemeStateNone object:object];
}

+ (XZThemeStyle *)themeStyleForState:(XZThemeState)themeState object:(nullable id<XZThemeSupporting>)object {
    if ([themeState isEqualToString:XZThemeStateNone]) {
        return [[XZStatedThemeStyle alloc] initWithState:themeState object:object];
    } else {
        return [[XZThemeStyle alloc] initWithState:themeState object:object];
    }
}

- (instancetype)initWithState:(XZThemeState)themeState object:(id)object {
    self = [super init];
    if (self != nil) {
        _object = object;
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
    return _attributedStyleValues[themeAttribute];
}

- (void)setObject:(id)value forKeyedSubscript:(XZThemeAttribute)themeAttribute {
    _attributedStyleValues[themeAttribute] = value;
}

- (BOOL)containsAttribute:(XZThemeAttribute)themeAttribute {
    return _attributedStyleValues[themeAttribute] != nil;
}

- (void)addValuesFromThemeStyle:(XZThemeStyle *)themeStyle {
    if (themeStyle == nil) {
        return;
    }
    [themeStyle.attributedStyleValues enumerateKeysAndObjectsUsingBlock:^(XZThemeAttribute _Nonnull key, id _Nonnull obj, BOOL * _Nonnull stop) {
        [self->_attributedStyleValues setObject:obj forKeyedSubscript:key];
    }];
    // 如果目标样式是集合样式。
    if ([themeStyle isKindOfClass:[XZStatedThemeStyle class]]) {
        themeStyle = [(XZStatedThemeStyle *)themeStyle themeStyleIfLoadedForState:self.state];
        [themeStyle.attributedStyleValues enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [self->_attributedStyleValues setObject:obj forKeyedSubscript:key];
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

- (NSMutableDictionary<XZThemeState, XZThemeStyle *> *)statedThemeStyles {
    if (_statedThemeStyles != nil) {
        return _statedThemeStyles; 
    }
    _statedThemeStyles = [NSMutableDictionary dictionary];
    return _statedThemeStyles;
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
    themeStyle = [[XZThemeStyle alloc] initWithState:themeState object:self.object];
    self.statedThemeStyles[themeState] = themeStyle;
    return themeStyle;
}

- (id)valueForAttribute:(XZThemeAttribute)themeAttribute forState:(XZThemeState)themeState {
    return [[self themeStyleIfLoadedForState:themeState] valueForAttribute:themeAttribute];
}

- (void)setValue:(id)value forAttribute:(XZThemeAttribute)themeAttribute forState:(XZThemeState)themeState {
    [[self themeStyleForState:themeState] setValue:value forAttribute:themeAttribute];
}

@end
