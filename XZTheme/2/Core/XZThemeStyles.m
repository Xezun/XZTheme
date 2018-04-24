//
//  XZThemeStyle.m
//  XZTheme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "XZThemeStyles.h"

@implementation XZThemeStyle {
    NSMutableDictionary<XZThemeAttribute, id> *_themeAttributes;
}

- (NSArray<XZThemeAttribute> *)themeAttributes {
    return _themeAttributes.allKeys;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _themeAttributes = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setValue:(id)value forThemeAttribute:(XZThemeAttribute)themeAttribute {
    _themeAttributes[themeAttribute] = value;
}

- (id)valueForThemeAttribute:(XZThemeAttribute)themeAttribute {
    return _themeAttributes[themeAttribute];
}

@end



@implementation XZThemeStyles {
    NSMutableDictionary<XZThemeState, XZThemeStyle *> *_statedAttributes;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _statedAttributes = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSArray<XZThemeState> *)themeStates {
    return [@[XZThemeStateNormal] arrayByAddingObjectsFromArray:_statedAttributes.allKeys];
}

- (XZThemeStyle *)themeAttributesForState:(XZThemeState)state {
    if ([state isEqualToString:XZThemeStateNormal]) {
        return self;
    }
    return _statedAttributes[state];
}

- (void)setThemeAttributes:(XZThemeStyle *)themeAttributes forState:(XZThemeState)state {
    if (![state isEqualToString:XZThemeStateNormal]) {
        _statedAttributes[state] = themeAttributes;
    }
}

- (XZThemeStyle *)normal {
    return self;
}

- (XZThemeStyle *)highlighted {
    XZThemeStyle *themeAttributes = _statedAttributes[XZThemeStateHighlighted];
    if (themeAttributes != nil) {
        return themeAttributes;
    }
    themeAttributes = [[XZThemeStyle alloc] init];
    _statedAttributes[XZThemeStateHighlighted] = themeAttributes;
    return themeAttributes;
}

- (XZThemeStyle *)highlightedIfLoaded {
    return _statedAttributes[XZThemeStateHighlighted];
}

- (XZThemeStyle *)selected {
    XZThemeStyle *themeAttributes = _statedAttributes[XZThemeStateSelected];
    if (themeAttributes != nil) {
        return themeAttributes;
    }
    themeAttributes = [[XZThemeStyle alloc] init];
    _statedAttributes[XZThemeStateSelected] = themeAttributes;
    return themeAttributes;
}

- (XZThemeStyle *)selectedIfLoaded {
    return _statedAttributes[XZThemeStateSelected];
}

- (XZThemeStyle *)disabled {
    XZThemeStyle *themeAttributes = _statedAttributes[XZThemeStateDisabled];
    if (themeAttributes != nil) {
        return themeAttributes;
    }
    themeAttributes = [[XZThemeStyle alloc] init];
    _statedAttributes[XZThemeStateDisabled] = themeAttributes;
    return themeAttributes;
}

- (XZThemeStyle *)disabledIfLoaded {
    return _statedAttributes[XZThemeStateDisabled];
}

- (XZThemeStyle *)focused {
    XZThemeStyle *themeAttributes = _statedAttributes[XZThemeStateFocused];
    if (themeAttributes != nil) {
        return themeAttributes;
    }
    themeAttributes = [[XZThemeStyle alloc] init];
    _statedAttributes[XZThemeStateFocused] = themeAttributes;
    return themeAttributes;
}

- (XZThemeStyle *)focusedIfLoaded {
    return _statedAttributes[XZThemeStateFocused];
}

@end


@implementation XZThemeStyle (XZExtendedThemeAttributes)

// MARK: - UIView

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [self setValue:backgroundColor forThemeAttribute:(XZThemeAttributeBackgroundColor)];
}

- (UIColor *)backgroundColor {
    return [self valueForThemeAttribute:(XZThemeAttributeBackgroundColor)];
}

- (void)setTintColor:(UIColor * _Nullable)tintColor {
    [self setValue:tintColor forThemeAttribute:(XZThemeAttributeTintColor)];
}

- (UIColor *)tintColor {
    return [self valueForThemeAttribute:(XZThemeAttributeTintColor)];
}

- (void)setIsHidden:(BOOL)isHidden {
    [self setValue:[NSNumber numberWithBool:isHidden] forThemeAttribute:(XZThemeAttributeIsHidden)];
}

- (BOOL)isHidden {
    return [[self valueForThemeAttribute:(XZThemeAttributeIsHidden)] boolValue];
}

- (CGFloat)alpha {
    return (CGFloat)[[self valueForThemeAttribute:(XZThemeAttributeAlpha)] doubleValue];
}

- (void)setAlpha:(CGFloat)alpha {
    [self setValue:[NSNumber numberWithDouble:alpha] forThemeAttribute:(XZThemeAttributeAlpha)];
}

- (void)setIsOpaque:(BOOL)isOpaque {
    [self setValue:[NSNumber numberWithBool:isOpaque] forThemeAttribute:(XZThemeAttributeIsOpaque)];
}

- (BOOL)isOpaque {
    return [[self valueForThemeAttribute:(XZThemeAttributeIsOpaque)] boolValue];
}

// MARK: - UILabel

- (NSString *)text {
    return [self valueForThemeAttribute:(XZThemeAttributeText)];
}

- (void)setText:(NSString * _Nullable)text {
    [self setValue:text forThemeAttribute:(XZThemeAttributeText)];
}

- (UIColor *)textColor {
    return [self valueForThemeAttribute:(XZThemeAttributeTextColor)];
}

- (void)setTextColor:(UIColor * _Nullable)textColor {
    [self setValue:textColor forThemeAttribute:(XZThemeAttributeTextColor)];
}

- (UIFont *)font {
    return [self valueForThemeAttribute:(XZThemeAttributeFont)];
}

- (void)setFont:(UIFont * _Nullable)font {
    [self setValue:font forThemeAttribute:(XZThemeAttributeFont)];
}

- (UIColor *)shadowColor {
    return [self valueForThemeAttribute:(XZThemeAttributeShadowColor)];
}

- (void)setShadowColor:(UIColor * _Nullable)shadowColor {
    [self setValue:shadowColor forThemeAttribute:(XZThemeAttributeShadowColor)];
}

- (UIColor *)highlightedTextColor {
    return [self valueForThemeAttribute:(XZThemeAttributeHighlightedTextColor)];
}

- (void)setHighlightedTextColor:(UIColor * _Nullable)highlightedTextColor {
    [self setValue:highlightedTextColor forThemeAttribute:(XZThemeAttributeHighlightedTextColor)];
}

// MARK: - UIButton

- (NSString *)title {
    return [self valueForThemeAttribute:(XZThemeAttributeTitle)];
}

- (void)setTitle:(NSString * _Nullable)title {
    [self setValue:title forThemeAttribute:(XZThemeAttributeTitle)];
}

- (UIColor *)titleColor {
    return [self valueForThemeAttribute:(XZThemeAttributeTitleColor)];
}

- (void)setTitleColor:(UIColor * _Nullable)titleColor {
    [self setValue:titleColor forThemeAttribute:(XZThemeAttributeTitleColor)];
}

- (UIImage *)backgroundImage {
    return [self valueForThemeAttribute:(XZThemeAttributeBackgroundImage)];
}

- (void)setBackgroundImage:(UIImage * _Nullable)backgroundImage {
    [self setValue:backgroundImage forThemeAttribute:(XZThemeAttributeBackgroundImage)];
}

- (UIColor *)titleShadowColor {
    return [self valueForThemeAttribute:(XZThemeAttributeTitleShadowColor)];
}

- (void)setTitleShadowColor:(UIColor * _Nullable)titleShadowColor {
    [self setValue:titleShadowColor forThemeAttribute:(XZThemeAttributeTitleShadowColor)];
}

- (NSAttributedString *)attributedTitle {
    return [self valueForThemeAttribute:(XZThemeAttributeAttributedTitle)];
}

- (void)setAttributedTitle:(NSAttributedString * _Nullable)attributedTitle {
    [self setValue:attributedTitle forThemeAttribute:(XZThemeAttributeAttributedTitle)];
}

// MARK: - UIImageView

- (UIImage *)image {
    return [self valueForThemeAttribute:(XZThemeAttributeImage)];
}

- (void)setImage:(UIImage * _Nullable)image {
    [self setValue:image forThemeAttribute:(XZThemeAttributeImage)];
}

- (UIImage *)highlightedImage {
    return [self valueForThemeAttribute:(XZThemeAttributeHighlightedImage)];
}

- (void)setHighlightedImage:(UIImage * _Nullable)highlightedImage {
    [self setValue:highlightedImage forThemeAttribute:(XZThemeAttributeHighlightedImage)];
}

- (NSArray<UIImage *> *)animationImages {
    return [self valueForThemeAttribute:(XZThemeAttributeAnimationImages)];
}

- (void)setAnimationImages:(NSArray<UIImage *> * _Nullable)animationImages {
    [self setValue:animationImages forThemeAttribute:(XZThemeAttributeAnimationImages)];
}

- (NSArray<UIImage *> *)highlightedAnimationImages {
    return [self valueForThemeAttribute:(XZThemeAttributeHighlightedAnimationImages)];
}

- (void)setHighlightedAnimationImages:(NSArray<UIImage *> * _Nullable)highlightedAnimationImages {
    [self setValue:highlightedAnimationImages forThemeAttribute:(XZThemeAttributeHighlightedAnimationImages)];
}

- (BOOL)isAnimating {
    return [self valueForThemeAttribute:(XZThemeAttributeIsAnimating)];
}

- (void)setIsAnimating:(BOOL)isAnimating {
    [self setValue:[NSNumber numberWithBool:isAnimating] forThemeAttribute:(XZThemeAttributeIsAnimating)];
}

- (BOOL)isHighlighted {
    return [[self valueForThemeAttribute:(XZThemeAttributeIsHighlighted)] boolValue];
}

- (void)setIsHighlighted:(BOOL)isHighlighted {
    [self setValue:[NSNumber numberWithBool:isHighlighted] forThemeAttribute:(XZThemeAttributeIsHighlighted)];
}

// MARK: - UITabBar

- (UIColor *)barTintColor {
    return [self valueForThemeAttribute:(XZThemeAttributeBarTintColor)];
}

- (void)setBarTintColor:(UIColor * _Nullable)barTintColor {
    [self setValue:barTintColor forThemeAttribute:(XZThemeAttributeBarTintColor)];
}

- (UIImage *)shadowImage {
    return [self valueForThemeAttribute:(XZThemeAttributeShadowImage)];
}

- (void)setShadowImage:(UIImage * _Nullable)shadowImage {
    [self setValue:shadowImage forThemeAttribute:(XZThemeAttributeShadowImage)];
}

- (UIColor *)unselectedItemTintColor {
    return [self valueForThemeAttribute:(XZThemeAttributeUnselectedItemTintColor)];
}

- (void)setUnselectedItemTintColor:(UIColor * _Nullable)unselectedItemTintColor {
    [self setValue:unselectedItemTintColor forThemeAttribute:(XZThemeAttributeUnselectedItemTintColor)];
}

- (UIImage *)selectionIndicatorImage {
    return [self valueForThemeAttribute:(XZThemeAttributeSelectionIndicatorImage)];
}

- (void)setSelectionIndicatorImage:(UIImage * _Nullable)selectionIndicatorImage {
    [self setValue:selectionIndicatorImage forThemeAttribute:(XZThemeAttributeSelectionIndicatorImage)];
}

// MARK: - UITabBarItem

- (UIImage *)selectedImage {
    return [self valueForThemeAttribute:(XZThemeAttributeSelectedImage)];
}

- (void)setSelectedImage:(UIImage * _Nullable)selectedImage {
    [self setValue:selectedImage forThemeAttribute:(XZThemeAttributeSelectedImage)];
}

- (NSDictionary<NSAttributedStringKey,id> *)titleTextAttributes {
    return [self valueForThemeAttribute:(XZThemeAttributeTitleTextAttributes)];
}

- (void)setTitleTextAttributes:(NSDictionary<NSAttributedStringKey,id> * _Nullable)titleTextAttributes {
    [self setValue:titleTextAttributes forThemeAttribute:(XZThemeAttributeTitleTextAttributes)];
}

- (UIImage *)landscapeImagePhone {
    return [self valueForThemeAttribute:(XZThemeAttributeLandscapeImagePhone)];
}

- (void)setLandscapeImagePhone:(UIImage * _Nullable)landscapeImagePhone {
    [self setValue:landscapeImagePhone forThemeAttribute:(XZThemeAttributeLandscapeImagePhone)];
}

- (UIImage *)largeContentSizeImage {
    return [self valueForThemeAttribute:(XZThemeAttributeLargeContentSizeImage)];
}

- (void)setLargeContentSizeImage:(UIImage * _Nullable)largeContentSizeImage {
    [self setValue:largeContentSizeImage forThemeAttribute:(XZThemeAttributeLargeContentSizeImage)];
}


@end





