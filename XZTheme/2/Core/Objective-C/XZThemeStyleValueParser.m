//
//  XZThemeStyleValueParser.m
//  XZKit
//
//  Created by mlibai on 2017/12/21.
//  Copyright © 2017年 mlibai. All rights reserved.
//

#import "XZThemeStyleValueParser.h"
@import XZKit;

@implementation XZThemeStyleValueParser

+ (instancetype)alloc {
    NSAssert(self != [XZThemeStyleValueParser class], @"XZThemeParser can not initialized directly, use subclass instead.");
    return [super alloc];
}

- (id)parse:(id)value {
    NSAssert(NO, @"XZThemeParser can not be used directly, use its static property instead.");
    return value;
}

@end

@implementation XZThemeStyleFontParser

+ (XZThemeStyleFontParser *)defaultParser {
    static XZThemeStyleFontParser *defaultParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultParser = [[XZThemeStyleFontParser alloc] init];
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

@implementation XZThemeStyleColorParser

+ (XZThemeStyleColorParser *)defaultParser {
    static XZThemeStyleColorParser *defaultParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultParser = [[XZThemeStyleColorParser alloc] init];
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
        return [UIColor xz_colorWithNumber:(UInt32)[(NSNumber *)value integerValue]];
    }
    return nil;
}

@end

@implementation XZThemeStyleImageParser

+ (XZThemeStyleImageParser *)defaultParser {
    static XZThemeStyleImageParser *defaultParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultParser = [[XZThemeStyleImageParser alloc] init];
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

@implementation XZThemeStyleStringParser

+ (XZThemeStyleStringParser *)defaultParser {
    static XZThemeStyleStringParser *defaultParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultParser = [[XZThemeStyleStringParser alloc] init];
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

@implementation XZThemeStyleAttributedStringParser

+ (XZThemeStyleAttributedStringParser *)defaultParser {
    static XZThemeStyleAttributedStringParser *defaultParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultParser = [[XZThemeStyleAttributedStringParser alloc] init];
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

@implementation XZThemeStyleStringAttributesParser

+ (XZThemeStyleStringAttributesParser *)defaultParser {
    static XZThemeStyleStringAttributesParser *defaultParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultParser = [[XZThemeStyleStringAttributesParser alloc] init];
    });
    return defaultParser;
}

- (NSDictionary *)parse:(id)value {
    if (![value isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithDictionary:value];
    attrs[NSFontAttributeName] = [XZThemeStyleFontParser.defaultParser parse:attrs[@"font"]];
    [attrs removeObjectForKey:@"font"];
    attrs[NSForegroundColorAttributeName] = [XZThemeStyleColorParser.defaultParser parse:attrs[@"color"]];
    [attrs removeObjectForKey:@"color"];
    attrs[NSBackgroundColorAttributeName] = [XZThemeStyleColorParser.defaultParser parse:attrs[@"backgroundColor"]];
    [attrs removeObjectForKey:@"backgroundColor"];
    return attrs;
}

@end
