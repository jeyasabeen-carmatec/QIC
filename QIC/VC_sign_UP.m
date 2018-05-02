//
//  VC_sign_UP.m
//  QIC
//
//  Created by anumolu mac mini on 25/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_sign_UP.h"
#import "APIHelper.h"


@interface VC_sign_UP ()<UIWebViewDelegate>

@end

@implementation VC_sign_UP

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_BTN_back addTarget:self action:@selector(back_action) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSURL *url = [[NSURL alloc]initWithString:@"http://www.qic-anaya.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.about_us_VW loadRequest:request];

}
- (void)back_action {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    //Terms and Conditions
    }

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
    [APIHelper start_animation:self];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [APIHelper stop_activity_animation:self];
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
