//
//  XZThemeStyles.m
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyles.h"

@implementation XZThemeStyles {
    NSMutableDictionary<XZThemeState, XZThemeStyle *> *_statedThemeStyles;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _statedThemeStyles = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSArray<XZThemeState> *)themeStates {
    return [@[XZThemeStateNormal] arrayByAddingObjectsFromArray:_statedThemeStyles.allKeys];
}

- (XZThemeStyle *)themeStyleForThemeState:(XZThemeState)state {
    if ([state isEqualToString:XZThemeStateNormal]) {
        return self;
    }
    return _statedThemeStyles[state];
}

- (void)setThemeStyle:(XZThemeStyle *)themeAttributes forThemeState:(XZThemeState)state {
    if (![state isEqualToString:XZThemeStateNormal]) {
        _statedThemeStyles[state] = themeAttributes;
    }
}

- (XZThemeStyle *)normalStyle {
    return self;
}

- (XZThemeStyle *)highlightedStyle {
    XZThemeStyle *themeAttributes = _statedThemeStyles[XZThemeStateHighlighted];
    if (themeAttributes != nil) {
        return themeAttributes;
    }
    themeAttributes = [[XZThemeStyle alloc] init];
    _statedThemeStyles[XZThemeStateHighlighted] = themeAttributes;
    return themeAttributes;
}

- (XZThemeStyle *)highlightedStyleIfLoaded {
    return _statedThemeStyles[XZThemeStateHighlighted];
}

- (XZThemeStyle *)selectedStyle {
    XZThemeStyle *themeAttributes = _statedThemeStyles[XZThemeStateSelected];
    if (themeAttributes != nil) {
        return themeAttributes;
    }
    themeAttributes = [[XZThemeStyle alloc] init];
    _statedThemeStyles[XZThemeStateSelected] = themeAttributes;
    return themeAttributes;
}

- (XZThemeStyle *)selectedStyleIfLoaded {
    return _statedThemeStyles[XZThemeStateSelected];
}

- (XZThemeStyle *)disabledStyle {
    XZThemeStyle *themeAttributes = _statedThemeStyles[XZThemeStateDisabled];
    if (themeAttributes != nil) {
        return themeAttributes;
    }
    themeAttributes = [[XZThemeStyle alloc] init];
    _statedThemeStyles[XZThemeStateDisabled] = themeAttributes;
    return themeAttributes;
}

- (XZThemeStyle *)disabledStyleIfLoaded {
    return _statedThemeStyles[XZThemeStateDisabled];
}

- (XZThemeStyle *)focusedStyle {
    XZThemeStyle *themeAttributes = _statedThemeStyles[XZThemeStateFocused];
    if (themeAttributes != nil) {
        return themeAttributes;
    }
    themeAttributes = [[XZThemeStyle alloc] init];
    _statedThemeStyles[XZThemeStateFocused] = themeAttributes;
    return themeAttributes;
}

- (XZThemeStyle *)focusedStyleIfLoaded {
    return _statedThemeStyles[XZThemeStateFocused];
}

@end
