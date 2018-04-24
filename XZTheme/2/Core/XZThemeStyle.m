//
//  XZThemeStyle.m
//  XZTheme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyle.h"
#import "XZThemeStyleValueParser.h"
#import "XZThemeStyle+ValueParser.h"

@implementation XZThemeStyle {
    NSMutableDictionary<XZThemeAttribute, id> *_attributedValues;
}

- (NSArray<XZThemeAttribute> *)themeAttributes {
    return _attributedValues.allKeys;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _attributedValues = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setValue:(id)value forThemeAttribute:(XZThemeAttribute)themeAttribute {
    _attributedValues[themeAttribute] = value;
}

- (id)valueForThemeAttribute:(XZThemeAttribute)themeAttribute {
    id value = _attributedValues[themeAttribute];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}





@end






@implementation XZThemeStyle (XZExtendedThemeStyle)

// integer

- (NSInteger)integerValueForThemeAttribute:(XZThemeAttribute)themeAttribute {
    NSNumber *number = [self valueForThemeAttribute:themeAttribute];
    if ([number respondsToSelector:@selector(integerValue)]) {
        return [number integerValue];
    }
    return 0;
}

// float

- (float)floatValueForThemeAttribute:(XZThemeAttribute)themeAttribute {
    NSNumber *number = [self valueForThemeAttribute:themeAttribute];
    if ([number respondsToSelector:@selector(floatValue)]) {
        return [number floatValue];
    }
    return 0;
}

// double

- (double)doubleValueForThemeAttribute:(XZThemeAttribute)themeAttribute {
    NSNumber *number = [self valueForThemeAttribute:themeAttribute];
    if ([number respondsToSelector:@selector(doubleValue)]) {
        return [number doubleValue];
    }
    return 0;
}

// bool

- (BOOL)boolValueForThemeAttribute:(XZThemeAttribute)themeAttribute {
    NSNumber *number = [self valueForThemeAttribute:themeAttribute];
    if ([number respondsToSelector:@selector(boolValue)]) {
        return [number boolValue];
    }
    return false;
}

// string

- (NSString *)stringValueForThemeAttribute:(XZThemeAttribute)themeAttribute {
    return [[XZThemeStyle stringParser] parse:[self valueForThemeAttribute:themeAttribute]];
}

// image

- (UIImage *)imageForThemeAttribute:(XZThemeAttribute)themeAttribute {
    return [[XZThemeStyle imageParser] parse:[self valueForThemeAttribute:themeAttribute]];
}

// colr

- (UIColor *)colorForThemeAttribute:(XZThemeAttribute)themeAttribute {
    return [[XZThemeStyle colorParser] parse:[self valueForThemeAttribute:themeAttribute]];
}

// font

- (UIFont *)fontForThemeAttribute:(XZThemeAttribute)themeAttribute {
    return [[XZThemeStyle fontParser] parse:[self valueForThemeAttribute:themeAttribute]];
}

// attributedString

- (NSAttributedString *)attributedStringForThemeAttribute:(XZThemeAttribute)themeAttribute {
    return [[XZThemeStyle attributedStringParser] parse:[self valueForThemeAttribute:themeAttribute]];
}

// stringAttributes

- (nullable NSDictionary<NSAttributedStringKey, id> *)stringAttributesForThemeAttribute:(XZThemeAttribute)themeAttribute {
    return [[XZThemeStyle stringAttributesParser] parse:[self valueForThemeAttribute:themeAttribute]];
}

@end





