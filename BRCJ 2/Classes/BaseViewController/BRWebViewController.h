//
//  BRWebViewController.h
//  BRCJ
//
//  Created by wuchunyi on 2019/8/5.
//  Copyright © 2019 cy. All rights reserved.
//

#import "BRBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,WebType) {
    WebTypeDisclaimer = 0, //免责声明
    WebTypeReport        , //用户投资风险公告
    WebTypeAboutUs       ,  //关于我们
    WebTypeWeb,              //网页
    WebTypeCallUs
};

/**
 用户服务协议
 免责声明
 **/

@interface BRWebViewController : BRBaseViewController

@property (nonatomic,assign)WebType  mType;

//链接
@property (nonatomic,copy)NSString *infoUrl;

@end

NS_ASSUME_NONNULL_END
