//
//  XZThemeStyleSheet.m
//  Example
//
//  Created by 徐臻 on 2019/1/2.
//  Copyright © 2019 mlibai. All rights reserved.
//

#import "XZThemeStyleSheet.h"

@implementation XZThemeStyleSheet {
    NSDictionary<XZThemeIdentifier, XZThemeStyle *> *_identifiedThemeStyles;
}

- (instancetype)initWithURL:(NSURL *)sheetURL {
    self = [super init];
    if (self != nil) {
        _url = sheetURL;
        _identifiedThemeStyles = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSDictionary<XZThemeIdentifier,XZThemeStyle *> *)identifiedThemeStyles {
    return _identifiedThemeStyles;
}

- (XZThemeStyle *)themeStyleForObject:(NSObject *)object {
    return nil;
}

- (void)addThemeStylesFromThemeStyleSheet:(XZThemeStyleSheet *)otherStyleSheet {
    
}

@end
