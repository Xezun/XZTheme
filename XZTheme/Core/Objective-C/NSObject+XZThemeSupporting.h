//
//  NSObject+XZThemeSupporting.h
//  XZTheme
//
//  Created by mlibai on 2018/5/21.
//

#import <Foundation/Foundation.h>

@interface NSObject (XZThemeSupporting)

/// 当对象初始化时，判断对象是否需要创建自动管理主题的对象。
+ (void)load;

@end
