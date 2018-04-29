//
//  XZThemeParser.m
//  XZKit
//
//  Created by mlibai on 2017/12/21.
//  Copyright © 2017年 mlibai. All rights reserved.
//

#import "XZThemeParser.h"
@import XZKit;

@implementation XZThemeParser
- (id)parse:(id)value {
    return value;
}
@end



@implementation XZThemeFontParser

+ (XZThemeFontParser *)defaultParser {
    static XZThemeFontParser *defaultParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultParser = [[XZThemeFontParser alloc] init];
    });
    return defaultParser;
}

- (UIFont *)parse:(id)value {
    if ([value isKindOfClass:[UIFont class]]) {
        return (UIFont *)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [UIFont fontWithName:(NSString *)value size:[UIFont systemFontSize]];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [UIFont systemFontOfSize:(CGFloat)[(NSNumber *)value doubleValue]];
    }
    if (![value isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSDictionary<NSString *, id> *dict = (NSDictionary<NSString *, id> *)value;
    CGFloat fontSize = [dict[@"size"] respondsToSelector:@selector(floatValue)] ? [dict[@"size"] floatValue] : [UIFont systemFontSize];
    if ([dict[@"name"] isKindOfClass:[NSString class]]) {
        return [UIFont fontWithName:dict[@"name"] size:fontSize];
    }
    if (@available(iOS 8.2, *)) {
        CGFloat fontWeight = [dict[@"weight"] respondsToSelector:@selector(floatValue)] ? [dict[@"weight"] floatValue] : 0;
        return [UIFont systemFontOfSize:fontSize weight:fontWeight];
    } else {
        return [UIFont systemFontOfSize:fontSize];
    }
}

@end

@implementation XZThemeColorParser

+ (XZThemeColorParser *)defaultParser {
    static XZThemeColorParser *defaultParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultParser = [[XZThemeColorParser alloc] init];
    });
    return defaultParser;
}

- (UIColor *)parse:(id)value {
    if ([value isKindOfClass:[UIColor class]]) {
        return (UIColor *)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [UIColor xz_colorWithString:(NSString *)value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [UIColor xz_colorWithColorValue:(XZColorValue)[(NSNumber *)value integerValue]];
    }
    return nil;
}

@end

@implementation XZThemeImageParser

+ (XZThemeImageParser *)defaultParser {
    static XZThemeImageParser *defaultParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultParser = [[XZThemeImageParser alloc] init];
    });
    return defaultParser;
}

- (UIImage *)parse:(id)value {
    if ([value isKindOfClass:[UIImage class]]) {
        return (UIImage *)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [UIImage imageNamed:(NSString *)value];
    }
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)value;
        if ([dict[@"name"] isKindOfClass:[NSString class]]) {
            if ([dict[@"duration"] respondsToSelector:@selector(doubleValue)]) {
                return [UIImage animatedImageNamed:dict[@"name"] duration:(NSTimeInterval)[dict[@"duration"] doubleValue]];
            }
        }
    }
    return nil;
}

@end

@implementation XZThemeStringParser

+ (XZThemeStringParser *)defaultParser {
    static XZThemeStringParser *defaultParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultParser = [[XZThemeStringParser alloc] init];
    });
    return defaultParser;
}

- (NSString *)parse:(id)value {
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString *)value;
    }
    return [value description];
}

@end

@implementation XZThemeAttributedStringParser

+ (XZThemeAttributedStringParser *)defaultParser {
    static XZThemeAttributedStringParser *defaultParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultParser = [[XZThemeAttributedStringParser alloc] init];
    });
    return defaultParser;
}

- (NSAttributedString *)parse:(id)value {
    if ([value isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSData *data = [value dataUsingEncoding:(NSUTF8StringEncoding)];
    if (data == nil) {
        return nil;
    }
    NSDictionary<NSAttributedStringDocumentReadingOptionKey,id> *options = @{NSDocumentTypeDocumentOption: NSHTMLTextDocumentType};
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:NULL];
}

@end

@implementation XZThemeStringAttributesParser

+ (XZThemeStringAttributesParser *)defaultParser {
    static XZThemeStringAttributesParser *defaultParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultParser = [[XZThemeStringAttributesParser alloc] init];
    });
    return defaultParser;
}

- (NSDictionary *)parse:(id)value {
    if (![value isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithDictionary:value];
    attrs[NSFontAttributeName] = [XZThemeFontParser.defaultParser parse:attrs[@"font"]];
    [attrs removeObjectForKey:@"font"];
    attrs[NSForegroundColorAttributeName] = [XZThemeColorParser.defaultParser parse:attrs[@"color"]];
    [attrs removeObjectForKey:@"color"];
    attrs[NSBackgroundColorAttributeName] = [XZThemeColorParser.defaultParser parse:attrs[@"backgroundColor"]];
    [attrs removeObjectForKey:@"backgroundColor"];
    return attrs;
}

@end



static XZThemeParser<UIFont *>                                 * _fontParser             = nil;
static XZThemeParser<UIColor *>                                * _colorParser            = nil;
static XZThemeParser<UIImage *>                                * _imageParser            = nil;
static XZThemeParser<NSString *>                               * _stringParser           = nil;
static XZThemeParser<NSAttributedString *>                     * _attributedStringParser = nil;
static XZThemeParser<NSDictionary<NSAttributedStringKey,id> *> * _stringAttributesParser = nil;

@implementation XZTheme (ThemeParser)

// UIFont

+ (XZThemeParser<UIFont *> *)fontParser {
    if (_fontParser != nil) {
        return _fontParser;
    }
    _fontParser = XZThemeFontParser.defaultParser;
    return _fontParser;
}

+ (void)setFontParser:(XZThemeParser<UIFont *> *)fontParser {
    _fontParser = fontParser;
}

// UIColor

+ (XZThemeParser<UIColor *> *)colorParser {
    if (_colorParser != nil) {
        return _colorParser;
    }
    _colorParser = XZThemeColorParser.defaultParser;
    return _colorParser;
}

+ (void)setColorParser:(XZThemeParser<UIColor *> *)colorParser {
    _colorParser = colorParser;
}


// UIImage

+ (XZThemeParser<UIImage *> *)imageParser {
    if (_imageParser != nil) {
        return _imageParser;
    }
    _imageParser = XZThemeImageParser.defaultParser;
    return _imageParser;
}

+ (void)setImageParser:(XZThemeParser<UIImage *> *)imageParser {
    _imageParser = imageParser;
}

// NSString

+ (XZThemeParser<NSString *> *)stringParser {
    if (_stringParser != nil) {
        return _stringParser;
    }
    _stringParser = XZThemeStringParser.defaultParser;
    return _stringParser;
}

+ (void)setStringParser:(XZThemeParser<NSString *> *)stringParser {
    _stringParser = stringParser;
}

// NSAttributedString

+ (XZThemeParser<NSAttributedString *> *)attributedStringParser {
    if (_attributedStringParser != nil) {
        return _attributedStringParser;
    }
    _attributedStringParser = XZThemeAttributedStringParser.defaultParser;
    return _attributedStringParser;
}

+ (void)setAttributedStringParser:(XZThemeParser<NSAttributedString *> *)attributedStringParser {
    _attributedStringParser = attributedStringParser;
}


// NSDictionary

+ (XZThemeParser<NSDictionary<NSAttributedStringKey,id> *> *)stringAttributesParser {
    if (_stringAttributesParser != nil) {
        return _stringAttributesParser;
    }
    _stringAttributesParser = XZThemeStringAttributesParser.defaultParser;
    return _stringAttributesParser;
}

+ (void)setStringAttributesParser:(XZThemeParser<NSDictionary<NSAttributedStringKey,id> *> *)stringAttributesParser {
    _stringAttributesParser = stringAttributesParser;
}

@end
