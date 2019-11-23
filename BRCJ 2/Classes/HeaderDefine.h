//
//  HeaderDefine.h
//  Br
//
//  Created by wuchunyi on 2019/10/24.
//  Copyright © 2019 cy. All rights reserved.
//

#ifndef HeaderDefine_h
#define HeaderDefine_h

typedef void(^noDataBlock)(void);
typedef void(^oneDataBlock)(id data);
// HUD
#define JK_HUD_YES(msg) [SVProgressHUD showSuccessWithStatus:msg];
#define JK_HUD_NO(msg)  [SVProgressHUD showErrorWithStatus:msg];

#define JK_HUD_SHOW     [SVProgressHUD show];
#define JK_HUD_DISMISS  [SVProgressHUD dismiss];

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

/**
 不管横竖屏，只要短的那一边
 */
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height?[UIScreen mainScreen].bounds.size.height:[UIScreen mainScreen].bounds.size.width)
/**
  不管横竖屏，只要长的那一边
 */
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height>[UIScreen mainScreen].bounds.size.width?[UIScreen mainScreen].bounds.size.height:[UIScreen mainScreen].bounds.size.width)
/**
 设计图是按照6的尺寸制作的，所有适配比例也按照6的来
 */
#define mulNumber  (SCREEN_WIDTH/375.0)
/**
 iPhone 5，5S，SE
 */
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)|| CGSizeEqualToSize(CGSizeMake(1136, 640), [[UIScreen mainScreen] currentMode].size) ) : NO)
/**
 iPhone 6，7，8
 */
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)|| CGSizeEqualToSize(CGSizeMake(1334, 750), [[UIScreen mainScreen] currentMode].size)) : NO)
/**
 iPhone 6P，7P， 8P
 */
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1080, 1920), [[UIScreen mainScreen] currentMode].size)|| CGSizeEqualToSize(CGSizeMake(1920, 1080), [[UIScreen mainScreen] currentMode].size)) : NO)
/**
 iPhone X 和 Xs 和 11
 */
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size)|| CGSizeEqualToSize(CGSizeMake(2436, 1125), [[UIScreen mainScreen] currentMode].size)) : NO)
/**
 Xr 和 Max 和11Max 的尺寸
 */
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(2688, 1242), [[UIScreen mainScreen] currentMode].size)) : NO)
/**
 状态栏高度
 */
#define TopStatus  ((iPhoneX || iPhoneXR)?44:20)
/**
 导航栏高度
 */
#define TopHeight  ((iPhoneX || iPhoneXR)?88:64)
/**
 底部高度
 */
#define BottomHeight ((iPhoneX || iPhoneXR)?34:0)
/**
 tabBar高度
 */
#define BottomStatus ((iPhoneX || iPhoneXR)?(49+34):49)
/**
 散户厅价格
 */
#define COPPER_CARD_MEMBER_PRICE 1980
/**
 百万厅价格
 */
#define SILVER_MEMBER_PRICE      29800
/**
 千万厅价格
 */
#define GOLD_MEMBER_PRICE       158000
/**
 亿万厅价格
 */
#define PLATINUM_MEMBER_PRICE    990000


#endif /* PrefixHeader_pch */

