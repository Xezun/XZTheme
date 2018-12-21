//
//  XZThemeStyleSheet.m
//  Example
//
//  Created by 徐臻 on 2018/12/21.
//  Copyright © 2018 mlibai. All rights reserved.
//

#import "XZThemeStyleSheet.h"

@implementation XZThemeStyleSheet {
    NSDictionary<XZThemeIdentifier, XZThemeStyle *> *_identifiedThemeStyles;
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self != nil) {
        _name = name.copy;
        _identifiedThemeStyles = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSDictionary<XZThemeIdentifier,XZThemeStyle *> *)identifiedThemeStyles {
    return _identifiedThemeStyles;
}

@end
