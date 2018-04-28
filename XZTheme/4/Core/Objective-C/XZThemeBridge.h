//
//  XZThemeStyle.h
//  XZTheme
//
//  Created by mlibai on 2018/4/23.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZThemeBridge<ObjectType> : NSObject

@property (nonatomic, unsafe_unretained, nonnull) ObjectType object;

- (nonnull instancetype)initWithObject:(nonnull ObjectType)object;

@end


NS_ASSUME_NONNULL_END
