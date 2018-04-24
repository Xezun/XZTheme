//
//  XZThemeStyle.m
//  XZTheme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyle.h"
#import "XZThemeStyleValueParser.h"

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



static XZThemeStyleValueParser<UIFont *> *_fontParser                                             = nil;
static XZThemeStyleValueParser<UIColor *> *_colorParser                                           = nil;
static XZThemeStyleValueParser<UIImage *> *_imageParser                                           = nil;
static XZThemeStyleValueParser<NSString *> *_stringParser                                         = nil;
static XZThemeStyleValueParser<NSAttributedString *> *_attributedStringParser                     = nil;
static XZThemeStyleValueParser<NSDictionary<NSAttributedStringKey,id> *> *_stringAttributesParser = nil;

@implementation XZThemeStyle (ValueParser)

// UIFont

+ (XZThemeStyleValueParser<UIFont *> *)fontParser {
    if (_fontParser != nil) {
        return _fontParser;
    }
    _fontParser = XZThemeStyleFontParser.defaultParser;
    return _fontParser;
}

+ (void)setFontParser:(XZThemeStyleValueParser<UIFont *> *)fontParser {
    _fontParser = fontParser;
}

// UIColor

+ (XZThemeStyleValueParser<UIColor *> *)colorParser {
    if (_colorParser != nil) {
        return _colorParser;
    }
    _colorParser = XZThemeStyleColorParser.defaultParser;
    return _colorParser;
}

+ (void)setColorParser:(XZThemeStyleValueParser<UIColor *> *)colorParser {
    _colorParser = colorParser;
}


// UIImage

+ (XZThemeStyleValueParser<UIImage *> *)imageParser {
    if (_imageParser != nil) {
        return _imageParser;
    }
    _imageParser = XZThemeStyleImageParser.defaultParser;
    return _imageParser;
}

+ (void)setImageParser:(XZThemeStyleValueParser<UIImage *> *)imageParser {
    _imageParser = imageParser;
}

// NSString

+ (XZThemeStyleValueParser<NSString *> *)stringParser {
    if (_stringParser != nil) {
        return _stringParser;
    }
    _stringParser = XZThemeStyleStringParser.defaultParser;
    return _stringParser;
}

+ (void)setStringParser:(XZThemeStyleValueParser<NSString *> *)stringParser {
    _stringParser = stringParser;
}

// NSAttributedString

+ (XZThemeStyleValueParser<NSAttributedString *> *)attributedStringParser {
    if (_attributedStringParser != nil) {
        return _attributedStringParser;
    }
    _attributedStringParser = XZThemeStyleAttributedStringParser.defaultParser;
    return _attributedStringParser;
}

+ (void)setAttributedStringParser:(XZThemeStyleValueParser<NSAttributedString *> *)attributedStringParser {
    _attributedStringParser = attributedStringParser;
}


// NSDictionary

+ (XZThemeStyleValueParser<NSDictionary<NSAttributedStringKey,id> *> *)stringAttributesParser {
    if (_stringAttributesParser != nil) {
        return _stringAttributesParser;
    }
    _stringAttributesParser = XZThemeStyleStringAttributesParser.defaultParser;
    return _stringAttributesParser;
}

+ (void)setStringAttributesParser:(XZThemeStyleValueParser<NSDictionary<NSAttributedStringKey,id> *> *)stringAttributesParser {
    _stringAttributesParser = stringAttributesParser;
}

@end

