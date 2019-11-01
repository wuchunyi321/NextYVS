//
//  NewsDetailViewController.m
//  TSQ
//
//  Created by wuchunyi on 16/11/14.
//  Copyright © 2016年 cy. All rights reserved.
//

#import "NewsDetailViewController.h"

#import "WKDelegateController.h"

#import <WebKit/WebKit.h>

#import "StockModel.h"
#import "ReportListModel.h"

@interface NewsDetailViewController ()<WKDelegate>


@end

@implementation NewsDetailViewController

- (void)initTheView{
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
    NSString *htmlStr = [self getTheStr];
    [headerView loadHTMLString:htmlStr baseURL:[NSURL URLWithString:@"http://www.jiankanglicheng.com"]];
    [self.view addSubview:headerView];
}

- (NSString *)getTheStr{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"text" ofType:@"html"];
    NSData  *data  = [NSData dataWithContentsOfFile:path];
    NSMutableString  *resultStr = [[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if (self.type == 1) { //文章
        [resultStr replaceOccurrencesOfString:@"{{Title}}" withString:self.stockItem.shareTitle options:NSLiteralSearch range:NSMakeRange(0, resultStr.length)];
        if (self.stockItem.addTime){
            [resultStr replaceOccurrencesOfString:@"{{time}}" withString:[self.stockItem.addTime substringToIndex:11] options:NSLiteralSearch range:NSMakeRange(0, resultStr.length)];
        }else{
            [resultStr replaceOccurrencesOfString:@"{{time}}" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, resultStr.length)];
        }
        [resultStr replaceOccurrencesOfString:@"{{ThemeContent}}" withString:self.stockItem.videoUrl.length>0?self.stockItem.videoUrl:@"" options:NSLiteralSearch  range:NSMakeRange(0, resultStr.length)];
    }else if (self.type == 2) { //文章
        [resultStr replaceOccurrencesOfString:@"{{Title}}" withString:self.reportItem.rrName options:NSLiteralSearch range:NSMakeRange(0, resultStr.length)];
        if (self.stockItem.addTime){
            [resultStr replaceOccurrencesOfString:@"{{time}}" withString:[self.reportItem.addTime substringToIndex:11] options:NSLiteralSearch range:NSMakeRange(0, resultStr.length)];
        }else{
            [resultStr replaceOccurrencesOfString:@"{{time}}" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, resultStr.length)];
        }
        [resultStr replaceOccurrencesOfString:@"{{ThemeContent}}" withString:self.reportItem.rrHtml.length>0?self.reportItem.rrHtml:@"" options:NSLiteralSearch  range:NSMakeRange(0, resultStr.length)];
    }
    return resultStr;
}

- (void)initTheCheckWithType:(NSString *)type AndId:(NSString *)itemId{
    [JKRequest requestSchoolcheckWithType:type
                               materialId:itemId
                                  success:^(id responseObject) {
        NSLog(@"统计正常");
    }
                                  failure:^(NSString *errorMessage, id responseObject) {
        NSLog(@"失败");
    }];
}

- (void)initTheData{
    if (self.type == 1) {
        [self initTheCheckWithType:@"shares"
                             AndId:self.stockItem.stock_id];
    }else{
        [JKRequest requestReportCheckwithId:self.reportItem.r_id
                                    success:^(id responseObject) {
            NSLog(@"统计正常");
        }
                                    failure:^(NSString *errorMessage, id responseObject) {
            NSLog(@"失败");
        }];
    }
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initTheView];
    [self initTheData];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
