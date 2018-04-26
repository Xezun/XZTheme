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

- (NSMutableDictionary<XZThemeState, XZThemeStyle *> *)statedThemeStyles {
    if (_statedThemeStyles != nil) {
        return _statedThemeStyles;
    }
    _statedThemeStyles = [NSMutableDictionary dictionary];
    return _statedThemeStyles;
}

- (NSArray<XZThemeState> *)themeStates {
    if (_statedThemeStyles != nil) {
        return [@[XZThemeStateNormal] arrayByAddingObjectsFromArray:_statedThemeStyles.allKeys];
    }
    return @[XZThemeStateNormal];
}

- (XZThemeStyle *)themeStyleForThemeState:(XZThemeState)themeState {
    if ([themeState isEqualToString:XZThemeStateNormal]) {
        return self;
    }
    return _statedThemeStyles[themeState];
}

- (XZThemeStyle *)themeStyleLazyLoadForThemeState:(XZThemeState)themeState {
    if ([themeState isEqualToString:XZThemeStateNormal]) {
        return self;
    }
    XZThemeStyle *themeStyle = _statedThemeStyles[themeState];
    if (themeStyle != nil) {
        return themeStyle;
    }
    themeStyle = [[XZThemeStyle alloc] initWithObject:self.object];
    _statedThemeStyles[themeState] = themeStyle;
    return themeStyle;
}

- (void)setThemeStyle:(XZThemeStyle *)themeStyle forThemeState:(XZThemeState)themeState {
    if ([themeState isEqualToString:XZThemeStateNormal]) {
        return;
    }
    if (![themeStyle.object isEqual:self.object]) {
        return;
    }
    self.statedThemeStyles[themeState] = themeStyle;
    [self.object xz_setNeedsThemeAppearanceUpdate];
}



@end





@implementation XZThemeStyles (XZExtendedThemeStyles)
- (XZThemeStyle *)normalStyle {
    return self;
}

- (XZThemeStyle *)highlightedStyle {
    XZThemeStyle *themeAttributes = _statedThemeStyles[XZThemeStateHighlighted];
    if (themeAttributes != nil) {
        return themeAttributes;
    }
    themeAttributes = [[XZThemeStyle alloc] initWithObject:self.object];
    self.statedThemeStyles[XZThemeStateHighlighted] = themeAttributes;
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
    self.statedThemeStyles[XZThemeStateSelected] = themeAttributes;
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
    self.statedThemeStyles[XZThemeStateDisabled] = themeAttributes;
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
    self.statedThemeStyles[XZThemeStateFocused] = themeAttributes;
    return themeAttributes;
}

- (XZThemeStyle *)focusedStyleIfLoaded {
    return _statedThemeStyles[XZThemeStateFocused];
}
@end

