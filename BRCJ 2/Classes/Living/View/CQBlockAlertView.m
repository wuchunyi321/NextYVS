//
//  CQBlockAlertView.m
//  AlertToastHUD
//
//  Created by caiqiang on 2018/12/6.
//  Copyright © 2018年 Caiqiang. All rights reserved.
//

#import "CQBlockAlertView.h"
#import "Masonry.h"
#import "UIButton+CQBlockSupport.h"



@implementation CQBlockAlertView


#pragma mark - 带block回调的弹窗
/** 带block回调的弹窗 */
+ (void)alertWithButtonClickedBlock:(void (^)(void))buttonClickedBlock {
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 背景View
    UIView *bgImageView = [[UIView alloc] init];
    bgImageView.backgroundColor= [UIColor whiteColor];
    [bgView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(267, 367));
    }];
    
    // 上面的两头牛
    UIImageView *logoLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"living_hubImage"]];
    [bgImageView addSubview:logoLabel];
    [logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(160);
        make.width.mas_equalTo(250);
        make.centerX.mas_equalTo(bgImageView);
        make.top.equalTo(bgImageView).offset(10);
    }];
        
    // title
    UILabel *titleLabel = [[UILabel alloc] init];
    [bgImageView addSubview:titleLabel];
    titleLabel.textColor = RGBCOLOR(0, 0, 0);
    titleLabel.text = @"投资风险提示公告";
    titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Bold" size:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImageView);
        make.height.mas_equalTo(16);
        make.top.equalTo(logoLabel.mas_bottom).offset(10);
    }];
    
    //content
    UILabel *contentLabel = [[UILabel alloc] init];
    [bgImageView addSubview:contentLabel];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = RGBCOLOR(106, 106, 106);
    contentLabel.text = @"尊敬的云视界用户：云视界是为用户提供财经类信息交流和知识内容的知识分享平台，一直致力于营造健康的网络学习环境，为帮助大家提高风险意识，加强自我保护，云视界提示您在享受平台服务的同时，知悉以下内容。";
    contentLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:12];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(95);
        make.left.equalTo(bgImageView).offset(9);
        make.right.equalTo(bgImageView).offset(-9);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
    }];
    
    // 立即阅读按钮
    UIButton *conversionButton = [[UIButton alloc] init];
    [bgView addSubview:conversionButton];
    [conversionButton setTitle:@"立即阅读" forState:UIControlStateNormal];
    [conversionButton setTitleColor:RGBCOLOR(255, 0, 0) forState:UIControlStateNormal];
    [conversionButton.titleLabel setFont:[UserContext getTheFontWithName:@"PingFang-SC-Medium" size:13]];
    conversionButton.layer.cornerRadius = 11;
    conversionButton.layer.masksToBounds = YES;
    conversionButton.layer.borderColor = RGBCOLOR(255, 43, 43).CGColor;
    conversionButton.layer.borderWidth = 0.5f;
    // 兑换按钮点击
    [conversionButton cq_addAction:^(UIButton *button) {
        buttonClickedBlock();
        [bgView removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [conversionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgImageView);
        make.top.mas_equalTo(contentLabel.mas_bottom).mas_offset(8);
        make.size.mas_equalTo(CGSizeMake(77, 28));
    }];
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    [bgView addSubview:cancelButton];
    [cancelButton setImage:[UIImage imageNamed:@"living_close"] forState:UIControlStateNormal];
    // 取消按钮点击
    [cancelButton cq_addAction:^(UIButton *button) {
        [bgView removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgImageView);
        make.top.equalTo(bgImageView.mas_bottom).mas_offset(18);
        make.size.mas_equalTo(CGSizeMake(33, 30));
    }];
}

+(void)alertShowWithType:(NSInteger)grade
             VXBackBlock:(void (^)(void))vxBlock
            ZFBBackBlock:(void (^)(void))zfbBlock{
    // 大背景
    UIView *bgView = [[UIView alloc] init];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 背景View
    UIView *bgImageView = [[UIView alloc] init];
    bgImageView.backgroundColor= [UIColor whiteColor];
    bgImageView.layer.cornerRadius = 5;
    bgImageView.layer.masksToBounds = YES;
    [bgView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(296, 392));
    }];
    
    //logo
    UIButton *logoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [logoBtn setImage:[UIImage imageNamed:@"show_logo"] forState:UIControlStateNormal];
    [logoBtn setTitle:@"云视界" forState:UIControlStateNormal];
    logoBtn.titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Bold" size:22];
    [logoBtn setTitleColor:RGBCOLOR(216, 31, 66) forState:UIControlStateNormal];
    [bgImageView addSubview:logoBtn];
    
    [logoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImageView);
        make.top.equalTo(bgImageView).offset(20);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(190);
    }];
    
    //content
    MyMember *member = [MyMember readFromFile];
    NSString *content = [NSString stringWithFormat:@"您当前的俱乐部等级是%@俱乐部，\n观看该视频/文章需要加入%@厅俱乐部",[BRTool getTheBackStrWithgrade:member.vipLevel.integerValue],[BRTool getTheBackStrWithgrade:grade]];
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.text = content;
    contentLabel.textColor = RGBCOLOR(34, 34, 34);
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
    contentLabel.numberOfLines = 2;
    [bgImageView addSubview:contentLabel];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImageView);
        make.top.equalTo(logoBtn.mas_bottom).offset(20);
        make.left.equalTo(bgImageView).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    //line
    UIView *line_o = [UIView new];
    line_o.backgroundColor = RGBCOLOR(189, 154, 93);
    [bgImageView addSubview:line_o];
    [line_o mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImageView);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(bgImageView).offset(20);
        make.top.equalTo(contentLabel.mas_bottom).offset(20);
    }];
    
    UIView *line_t = [UIView new];
    line_t.backgroundColor = RGBCOLOR(189, 154, 93);
    [bgImageView addSubview:line_t];
    
    [line_t mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImageView);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(bgImageView).offset(20);
        make.top.equalTo(line_o.mas_bottom).offset(4);
    }];
    
    //title
    NSString *title = [NSString stringWithFormat:@"升级%@俱乐部邀请函",[BRTool getTheBackStrWithgrade:grade]];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = title;
    titleLabel.textColor = RGBCOLOR(189, 154, 93);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Bold" size:19];
    [bgImageView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImageView);
        make.height.mas_equalTo(20);
        make.left.equalTo(bgImageView).offset(20);
        make.top.equalTo(line_t.mas_bottom).offset(18);
    }];
    
    //subContent
    NSString *subContent = [NSString stringWithFormat:@"加入%@厅俱乐部，享受更多权益，更多权益升级后了解。",[BRTool getTheBackStrWithgrade:grade]];
    
    UILabel *subContentLabel = [UILabel new];
    subContentLabel.text = subContent;
    subContentLabel.textColor = RGBCOLOR(34, 34, 34);
    subContentLabel.textAlignment = NSTextAlignmentLeft;
    subContentLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
    subContentLabel.numberOfLines = 2;
    [bgImageView addSubview:subContentLabel];
    
    [subContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImageView);
        make.height.mas_equalTo(40);
        make.left.equalTo(bgImageView).offset(20);
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
    }];
    
    //content1
    UILabel *content1Label = [UILabel new];
    content1Label.text = [NSString stringWithFormat:@"升级为%@俱乐部会员",[BRTool getTheBackStrWithgrade:grade]];
    content1Label.textColor = RGBCOLOR(34, 34, 34);
    content1Label.textAlignment = NSTextAlignmentLeft;
    content1Label.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:15];
    [bgImageView addSubview:content1Label];
    
    [content1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImageView);
        make.height.mas_equalTo(18);
        make.left.equalTo(bgImageView).offset(20);
        make.top.equalTo(subContentLabel.mas_bottom).offset(5);
    }];
    
    //content1
    UILabel *content2Label = [UILabel new];
    content2Label.text = [NSString stringWithFormat:@"您需要支付 %ld 元",(long)([BRTool getThePriceStrWith:grade]-[BRTool getThePriceStrWith:member.vipLevel.intValue])];
    content2Label.textColor = RGBCOLOR(34, 34, 34);
    content2Label.textAlignment = NSTextAlignmentLeft;
    content2Label.font = [UserContext getTheFontWithName:@"PingFang-SC-Medium" size:15];
    [bgImageView addSubview:content2Label];
    [content2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImageView);
        make.height.mas_equalTo(18);
        make.left.equalTo(bgImageView).offset(20);
        make.top.equalTo(content1Label.mas_bottom).offset(3);
    }];
    
    //underImage1
    UIButton *signImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [signImage setImage:[UIImage imageNamed:@"pay_vx"] forState:UIControlStateNormal];
    [bgImageView addSubview:signImage];

    [signImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.top.equalTo(content2Label.mas_bottom).offset(20);
        make.right.equalTo(bgImageView.mas_centerX).offset(-32);
    }];
    [signImage cq_addAction:^(UIButton *button) {
        vxBlock();
        [bgView removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *signLabel = [UILabel new];
    signLabel.text = @"微信支付";
    signLabel.textColor = RGBCOLOR(34, 34, 34);
    signLabel.textAlignment = NSTextAlignmentCenter;
    signLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
    [bgImageView addSubview:signLabel];

    [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.top.equalTo(signImage.mas_bottom).offset(10);
        make.height.mas_equalTo(15);
        make.centerX.equalTo(signImage);
    }];
    
    //underImage2
    UIButton *classifyImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [classifyImage setImage:[UIImage imageNamed:@"pay_zfb"] forState:UIControlStateNormal];
    [bgImageView addSubview:classifyImage];

    [classifyImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.top.equalTo(content2Label.mas_bottom).offset(20);
        make.left.equalTo(bgImageView.mas_centerX).offset(32);
    }];

    [classifyImage cq_addAction:^(UIButton *button) {
        zfbBlock();
        [bgView removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *classifyLabel = [UILabel new];
    classifyLabel.text = @"支付宝支付";
    classifyLabel.textColor = RGBCOLOR(34, 34, 34);
    classifyLabel.textAlignment = NSTextAlignmentCenter;
    classifyLabel.font = [UserContext getTheFontWithName:@"PingFang-SC-Regular" size:14];
    [bgImageView addSubview:classifyLabel];

    [classifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.top.equalTo(classifyImage.mas_bottom).offset(10);
        make.height.mas_equalTo(15);
        make.centerX.equalTo(classifyImage);
    }];
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] init];
    [bgView addSubview:cancelButton];
    [cancelButton setImage:[UIImage imageNamed:@"base_close"] forState:UIControlStateNormal];
    // 取消按钮点击
    [cancelButton cq_addAction:^(UIButton *button) {
        [bgView removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgImageView);
        make.top.equalTo(bgImageView.mas_bottom).mas_offset(18);
        make.size.mas_equalTo(CGSizeMake(33, 30));
    }];
}


@end
