//
//  XZTheme.m
//  XZKit
//
//  Created by mlibai on 2017/10/14.
//

#import "XZTheme.h"
#import <objc/runtime.h>
#import "NSObject+XZTheme.h"
#import "UIViewController+XZKit.h"
#import "XZThemeStyle.h"
#import "XZThemeManager.h"

@interface _XZIdentifiedThemeStyleItem: NSObject
@property (nonatomic, readonly, nonnull) XZThemeIdentifier identifier;
@property (nonatomic, readonly, nonnull) XZThemeStyle *style;
+ (instancetype)itemWithIdentifier:(nonnull XZThemeIdentifier)identifier style:(nonnull XZThemeStyle *)style;
- (NSComparisonResult)compare:(nonnull _XZIdentifiedThemeStyleItem *)item;
@end


/// 判断两个子主题标识符数组是否有包含关系。
BOOL XZThemeIdentifierArrayContainsThemeIdentifierArray(NSArray<XZThemeIdentifier> *subidentifiers1, NSArray<XZThemeIdentifier> *subidentifiers2);

@interface XZTheme () {
    NSMutableDictionary<XZThemeIdentifier, XZThemeStyle *>  * _Nonnull _styles;
    /// 存储的值为 NSNull 或 XZThemeStyle 。
    NSMutableDictionary<XZThemeIdentifier, /*XZThemeStyle **/ id>  * _Nonnull _cachedStyles;
}

@end

@implementation XZTheme

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self != nil) {
        _name         = [name copy];
        _styles       = [NSMutableDictionary dictionary];
        _cachedStyles = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (XZTheme *)themeWithName:(NSString *)name configuration:(NSDictionary<NSString *,NSDictionary<NSString *,id> *> *)configuration {
    XZTheme *theme = [[XZTheme alloc] initWithName:name];
    [theme addStylesFromConfiguration:configuration];
    return theme;
}

- (void)addStylesFromConfiguration:(NSDictionary<NSString *,NSDictionary<NSString *,id> *> *)configuration {
    // 过滤多余空格的正则。
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"\\s{2,}" options:(0) error:nil];
    NSCharacterSet *characterSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    [configuration enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSDictionary<NSString *,id> *obj, BOOL *stop) {
        XZThemeIdentifier identifier = [key stringByTrimmingCharactersInSet:characterSet];
        NSRange range = NSMakeRange(0, identifier.length);
        identifier = [regularExpression stringByReplacingMatchesInString:identifier options:0 range:range withTemplate:XZThemeIdentifierSeparator];
        XZThemeStyle *newStyle = [XZThemeStyle themeStyleWithConfiguration:obj];
        XZThemeStyle *oldStyle = [self styleForIdentifier:identifier];
        if (oldStyle != nil) {
            [oldStyle addAttributesAndSubstylesFromStyle:newStyle];
        } else {
            [self setStyle:newStyle forIdentifier:identifier];
        }
    }];
}

- (XZThemeStyle *)styleForIdentifier:(XZThemeIdentifier const)identifier {
    XZThemeStyle *result = _cachedStyles[identifier];
    if ([result isEqual:[NSNull null]]) {
        return nil;
    }
    if (result != nil) {
        return result;
    }
    // 按照规则 复合标识符 的可能性更大。
    NSArray<NSString *> *subidentifiers = [identifier componentsSeparatedByString:XZThemeIdentifierSeparator];
    if (subidentifiers.count == 1) {
        // 单标识符，直接从库取数据。
        result = _styles[identifier];
        if (result == nil) {
            _cachedStyles[identifier] = [NSNull null];
        }
        return result;
    }
    // 复合标识符。需要查找所有包含的子标识符，然后并集。
    result = [[XZThemeStyle alloc] init];
    // 找到所有的子标识符。
    NSMutableArray<_XZIdentifiedThemeStyleItem *> *matchedIdentifiers = [NSMutableArray array];
    [_styles enumerateKeysAndObjectsUsingBlock:^(XZThemeIdentifier  _Nonnull key, XZThemeStyle * _Nonnull obj, BOOL * _Nonnull stop) {
        if (XZThemeIdentifierArrayContainsThemeIdentifierArray(subidentifiers, [key componentsSeparatedByString:XZThemeIdentifierSeparator])) {
            [matchedIdentifiers addObject:[_XZIdentifiedThemeStyleItem itemWithIdentifier:key style:obj]];
        }
    }];
    // 排序标识符。
    [matchedIdentifiers sortUsingComparator:^NSComparisonResult(_XZIdentifiedThemeStyleItem * _Nonnull obj1, _XZIdentifiedThemeStyleItem * _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    // 复合。
    for (XZThemeIdentifier tid in matchedIdentifiers) {
        [result addAttributesAndSubstylesFromStyle:_styles[tid]];
    }
    // 缓存。
    _cachedStyles[identifier] = result;
    return result;
}

- (void)setStyle:(XZThemeStyle *)style forIdentifier:(XZThemeIdentifier)identifier {
    [_styles setObject:[style copy] forKeyedSubscript:identifier];
    [_cachedStyles removeAllObjects];
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[XZTheme class]]) {
        return [self isEqualToTheme:object];
    }
    return NO;
}

- (BOOL)isEqualToTheme:(XZTheme *)theme {
    return [[theme name] isEqualToString:_name];
}

@end







@implementation XZTheme (XZExtendedTheme)

+ (XZTheme *)currentTheme {
    return [[XZThemeManager defaultManager] currentTheme];
}

+ (XZTheme *)themeNamed:(NSString *)name {
    return [[XZThemeManager defaultManager] themeForName:name];
}

- (void)apply {
    [[XZThemeManager defaultManager] setCurrentTheme:self];
}

@end



@implementation _XZIdentifiedThemeStyleItem

- (instancetype)initWithIdentifier:(XZThemeIdentifier)identifier style:(XZThemeStyle *)style {
    self = [super init];
    if (self != nil) {
        _identifier = identifier;
        _style = style;
    }
    return self;
}

+ (instancetype)itemWithIdentifier:(XZThemeIdentifier)identifier style:(XZThemeStyle *)style {
    return [[self alloc] initWithIdentifier:identifier style:style];
}

- (NSComparisonResult)compare:(_XZIdentifiedThemeStyleItem *)item {
    if (_style.priority == item.style.priority) {
        // 如果优先级相同，则比较标识符。
        return [_identifier compare:item.identifier];
    } else if (_style.priority < item.style.priority) {
        return NSOrderedAscending;
    }
    return NSOrderedDescending;
}

@end





BOOL XZThemeIdentifierContainsThemeIdentifier(XZThemeIdentifier identifier1, XZThemeIdentifier identifier2) {
    return XZThemeIdentifierArrayContainsThemeIdentifierArray([identifier1 componentsSeparatedByString:XZThemeIdentifierSeparator], [identifier2 componentsSeparatedByString:XZThemeIdentifierSeparator]);
}

BOOL XZThemeIdentifierArrayContainsThemeIdentifierArray(NSArray<XZThemeIdentifier> *subidentifiers1, NSArray<XZThemeIdentifier> *subidentifiers2) {
    // 1 是单标识符时，判断 2 的尾标识符是否与 1 相同。
    if (subidentifiers1.count == 1) {
        return [subidentifiers1.firstObject isEqualToString:subidentifiers2.lastObject];
    }
    // 2 比 1 子标识符多，肯定不包含。
    if (subidentifiers2.count > subidentifiers1.count) {
        return NO;
    }
    // 如果首位或末位不相等，则一定不包含。
    if (![subidentifiers1.firstObject isEqualToString:subidentifiers2.firstObject] || ![subidentifiers1.lastObject isEqualToString:subidentifiers2.lastObject]) {
        return NO;
    }
    // 在 1 中找 2 的所有字串，且顺序一致则表示包含。
    NSInteger index1 = 1, index2 = 1;
    // 遍历 2 ，然后在 1 中找，如果在遍历完 1 之前就完整遍历了 2，说明包含。
    for (; index2 < (subidentifiers2.count - 1); index2++) {
        XZThemeIdentifier subidentifier2 = subidentifiers2[index2];
        // 遍历 1，查找是否包含子串。
        BOOL isSubidentifier2InIdentifier1 = NO;
        while (index1 < (subidentifiers1.count - 1)) {
            if ([subidentifier2 isEqualToString:subidentifiers1[index1++]]) {
                isSubidentifier2InIdentifier1 = YES;
                break;
            }
        }
        // 如果不包含子串，直接判断不包含。
        if (!isSubidentifier2InIdentifier1) {
            return NO;
        }
    }
    // 遍历完 2，说明全部找到了。
    return YES;
}


NSNotificationName const _Nonnull XZThemeDidChangeNotification  = @"com.mlibai.XZKit.theme.changed";
NSString         * const _Nonnull XZThemeBundleKey              = @"XZThemeBundleKey";
NSString         * const _Nonnull XZThemeUserDefaultsKey        = @"com.mlibai.XZKit.theme.default";
NSString         * const _Nonnull XZThemeIdentifierSeparator    = @" ";









