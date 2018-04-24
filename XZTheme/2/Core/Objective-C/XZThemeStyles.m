//
//  XZThemeStyles.m
//  Example
//
//  Created by mlibai on 2018/4/24.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyles.h"
#import "XZTheme.h"

@implementation XZThemeStyles {
    NSMutableDictionary<XZThemeState, XZThemeStyle *> *_statedThemeStyles;
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
    if ([state isEqualToString:XZThemeStateNormal]) {
        return;
    }
    _statedThemeStyles[state] = themeAttributes;
    [self.object xz_setNeedsThemeAppearanceUpdate];
}

- (XZThemeStyle *)normalStyle {
    return self;
}

- (XZThemeStyle *)highlightedStyle {
    XZThemeStyle *themeAttributes = _statedThemeStyles[XZThemeStateHighlighted];
    if (themeAttributes != nil) {
        return themeAttributes;
    }
    themeAttributes = [[XZThemeStyle alloc] initWithObject:self.object];
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
    themeAttributes = [[XZThemeStyle alloc] initWithObject:self.object];
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
    themeAttributes = [[XZThemeStyle alloc] initWithObject:self.object];
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
    themeAttributes = [[XZThemeStyle alloc] initWithObject:self.object];
    _statedThemeStyles[XZThemeStateFocused] = themeAttributes;
    return themeAttributes;
}

- (XZThemeStyle *)focusedStyleIfLoaded {
    return _statedThemeStyles[XZThemeStateFocused];
}

@end
