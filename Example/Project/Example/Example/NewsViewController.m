//
//  NewsViewController.m
//  Example
//
//  Created by mlibai on 2018/5/3.
//  Copyright © 2018年 mlibai. All rights reserved.
//

#import "NewsViewController.h"
@import XZTheme;
@import WebKit;

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *webView;
    
    [webView evaluateJavaScript:@"window.history.back()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
    }];
    
    [webView goToBackForwardListItem:webView.backForwardList.backItem];
    
    [webView goBack];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
