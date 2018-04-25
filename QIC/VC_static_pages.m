//
//  VC_static_pages.m
//  QIC
//
//  Created by anumolu mac mini on 20/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_static_pages.h"
#import "APIHelper.h"

@interface VC_static_pages ()<UIWebViewDelegate>


@end

@implementation VC_static_pages

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _LBL_header.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"header_val"];
    [_BTN_back addTarget:self action:@selector(back_action) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSURL *url = [[NSURL alloc]initWithString:[[NSUserDefaults standardUserDefaults] valueForKey:@"Static_URL"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.about_us_VW loadRequest:request];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)back_action {
    //Terms and Conditions
    if([_LBL_header.text isEqualToString:@"PRIVACY POLICY"]||[_LBL_header.text isEqualToString:@"TERMS AND CONDITIONS"])
    {
        [self.delegate static_page_back:@"static_page"];
    }//NEWS DETAIL
    else if([_LBL_header.text isEqualToString:@"NEWS"])
    {
    [self.delegate static_page_back:@"news"];
    }
    else{
        [self.delegate static_page_back:@"top news"];

    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [APIHelper start_animation:self];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [APIHelper stop_activity_animation:self];
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
