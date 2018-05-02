//
//  ThemeStyle.m
//  Theme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyle.h"
#import "XZTheme.h"
//#import "XZThemeParser.h"

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


