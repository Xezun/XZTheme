//
//  XZThemeStyle+ValueParser.m
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyle+ValueParser.h"
#import "XZThemeStyleValueParser.h"

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
    _fontParser = [[XZThemeStyleFontValueParser alloc] init];
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
    _colorParser = [[XZThemeStyleColorValueParser alloc] init];
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
    _imageParser = [[XZThemeStyleImageValueParser alloc] init];
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
    _stringParser = [[XZThemeStyleStringValueParser alloc] init];
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
    _attributedStringParser = [[XZThemeStyleAttributedStringValueParser alloc] init];
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
    _stringAttributesParser = [[XZThemeStyleStringAttributesValueParser alloc] init];
    return _stringAttributesParser;
}

+ (void)setStringAttributesParser:(XZThemeStyleValueParser<NSDictionary<NSAttributedStringKey,id> *> *)stringAttributesParser {
    _stringAttributesParser = stringAttributesParser;
}

@end
