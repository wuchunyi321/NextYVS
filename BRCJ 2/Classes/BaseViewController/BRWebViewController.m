//
//  BRWebViewController.m
//  BRCJ
//
//  Created by wuchunyi on 2019/8/5.
//  Copyright © 2019 cy. All rights reserved.
//

#import "BRWebViewController.h"

#import "WKDelegateController.h"
#import <WebKit/WebKit.h>

NSString *const AboutUrl = @"https://black-horse-club.oss-cn-hangzhou.aliyuncs.com/wenan/gywm.html";

NSString *const DisclaimerUrl = @"https://black-horse-club.oss-cn-hangzhou.aliyuncs.com/wenan/mzsm.html";

NSString *const ReportUrl = @"https://black-horse-club.oss-cn-hangzhou.aliyuncs.com/wenan/tzfxggts.html";

/**
 关于我们
 */
NSString *const callUs = (@"<p>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp我们客服的联系方式是VX：974467047\n VX：1464510875 </p><p>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp欢迎大家使用我们的服务，恳请大家对我们的服务提出意见和建议。</p>");

@interface BRWebViewController ()<WKDelegate>{
    WKWebView   *showWeb;
}

@end

@implementation BRWebViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    [self initTheView];
    // Do any additional setup after loading the view.
}

-(void)initTheView{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [userContentController addUserScript:wkUScript];
    
    WKDelegateController * delegateController = [[WKDelegateController alloc]init];
    delegateController.delegate = self;
    [userContentController addScriptMessageHandler:delegateController name:@"showImage"];
    configuration.userContentController = userContentController;
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.javaScriptEnabled = YES;
    configuration.preferences = preferences;
    
    WKWebView *headerView = [[WKWebView alloc] initWithFrame:CGRectMake(0, TopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-TopHeight) configuration:configuration];
    
    if (self.mType == WebTypeReport) {
        NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
        NSString *encodedString = [ReportUrl stringByAddingPercentEncodingWithAllowedCharacters:set];
        NSURL *url =[NSURL URLWithString:encodedString];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [headerView loadRequest:request];
    }else if (self.mType == WebTypeAboutUs) {
        NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
        NSString *encodedString = [AboutUrl stringByAddingPercentEncodingWithAllowedCharacters:set];
        NSURL *url =[NSURL URLWithString:encodedString];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [headerView loadRequest:request];
    }else if (self.mType == WebTypeCallUs){
        [headerView loadHTMLString:callUs baseURL:nil];
    }else if (self.mType == WebTypeDisclaimer){
        NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
        NSString *encodedString = [DisclaimerUrl stringByAddingPercentEncodingWithAllowedCharacters:set];
        NSURL *url =[NSURL URLWithString:encodedString];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [headerView loadRequest:request];
    }else{
        NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
        NSString *encodedString = [self.infoUrl stringByAddingPercentEncodingWithAllowedCharacters:set];
        NSURL *url =[NSURL URLWithString:encodedString];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        [headerView loadRequest:request];
    }
    
    [self.view addSubview:headerView];
}

//{
//    if (@available(iOS 11.0, *)) {
//        showWeb.scrollView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets =NO;
//    }
//
//    CGFloat top =iPhoneX ? 88 : 64;
//    CGFloat bottom =iPhoneX ? 23 : 0;
//    showWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, top, SCREEN_WIDTH, SCREEN_HEIGHT  - top - bottom)];
//    showWeb.delegate = self;
//    showWeb.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:showWeb];
//
//    if (self.mType == WebTypeReport) {
//        NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
//        NSString *encodedString = [ReportUrl stringByAddingPercentEncodingWithAllowedCharacters:set];
//        NSURL *url =[NSURL URLWithString:encodedString];
//        NSURLRequest *request =[NSURLRequest requestWithURL:url];
//        [showWeb loadRequest:request];
//    }else if (self.mType == WebTypeAboutUs) {
////        [showWeb loadHTMLString:AdoutUsText baseURL:nil];
//        NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
//        NSString *encodedString = [AboutUrl stringByAddingPercentEncodingWithAllowedCharacters:set];
//        NSURL *url =[NSURL URLWithString:encodedString];
//        NSURLRequest *request =[NSURLRequest requestWithURL:url];
//        [showWeb loadRequest:request];
//        [showWeb setScalesPageToFit:YES];
//    }else if (self.mType == WebTypeCallUs){
//        [showWeb loadHTMLString:callUs baseURL:nil];
//    }else if (self.mType == WebTypeDisclaimer){
////        [showWeb loadHTMLString:DisclaimerText baseURL:nil];
//        NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
//        NSString *encodedString = [DisclaimerUrl stringByAddingPercentEncodingWithAllowedCharacters:set];
//        NSURL *url =[NSURL URLWithString:encodedString];
//        NSURLRequest *request =[NSURLRequest requestWithURL:url];
//        [showWeb loadRequest:request];
//        [showWeb setScalesPageToFit:YES];
//    }else{
//        NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
//        NSString *encodedString = [self.infoUrl stringByAddingPercentEncodingWithAllowedCharacters:set];
//        NSURL *url =[NSURL URLWithString:encodedString];
//        NSURLRequest *request =[NSURLRequest requestWithURL:url];
//        [showWeb loadRequest:request];
//        [showWeb setScalesPageToFit:YES];
//    }
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
