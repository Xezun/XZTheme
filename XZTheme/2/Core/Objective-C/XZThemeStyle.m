//
//  XZThemeStyle.m
//  XZTheme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyle.h"
#import "XZTheme.h"
#import "XZThemeParser.h"

@implementation XZThemeStyle {
    NSMutableDictionary<XZThemeAttribute, id> *_attributedValues;
}

- (NSArray<XZThemeAttribute> *)themeAttributes {
    return _attributedValues.allKeys;
}

- (instancetype)initWithObject:(id<XZThemeSupporting>)object {
    self = [super init];
    if (self) {
        _object = object;
        _attributedValues = [NSMutableDictionary dictionary];
    }
    return self;
}

- (BOOL)containsThemeAttribute:(XZThemeAttribute)themeAttribute {
    return (_attributedValues[themeAttribute] != nil);
}

- (void)setValue:(id)value forThemeAttribute:(XZThemeAttribute)themeAttribute {
    _attributedValues[themeAttribute] = value;
    [_object xz_setNeedsThemeAppearanceUpdate];
}

- (id)valueForThemeAttribute:(XZThemeAttribute)themeAttribute {
    id value = _attributedValues[themeAttribute];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

- (id)objectForKeyedSubscript:(XZThemeAttribute)themeAttribute {
    return [self valueForThemeAttribute:themeAttribute];
}

- (void)setObject:(id)object forKeyedSubscript:(XZThemeAttribute)themeAttribute {
    [self setValue:object forThemeAttribute:themeAttribute];
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
    return [XZTheme.stringParser parse:[self valueForThemeAttribute:themeAttribute]];
}

// image

- (UIImage *)imageForThemeAttribute:(XZThemeAttribute)themeAttribute {
    return [XZTheme.imageParser parse:[self valueForThemeAttribute:themeAttribute]];
}

// colr

- (UIColor *)colorForThemeAttribute:(XZThemeAttribute)themeAttribute {
    return [XZTheme.colorParser parse:[self valueForThemeAttribute:themeAttribute]];
}

// font

- (UIFont *)fontForThemeAttribute:(XZThemeAttribute)themeAttribute {
    return [XZTheme.fontParser parse:[self valueForThemeAttribute:themeAttribute]];
}

// attributedString

- (NSAttributedString *)attributedStringForThemeAttribute:(XZThemeAttribute)themeAttribute {
    return [XZTheme.attributedStringParser parse:[self valueForThemeAttribute:themeAttribute]];
}

// stringAttributes

- (nullable NSDictionary<NSAttributedStringKey, id> *)stringAttributesForThemeAttribute:(XZThemeAttribute)themeAttribute {
    return [XZTheme.stringAttributesParser parse:[self valueForThemeAttribute:themeAttribute]];
}

@end


