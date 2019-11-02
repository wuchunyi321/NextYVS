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

#define mulNumber  ([UIScreen mainScreen].bounds.size.width/375.0)

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.width==414.0f)
#define iPhoneX ([UIScreen mainScreen].bounds.size.height==812.0f)
#define iPhoneXR ([UIScreen mainScreen].bounds.size.height==896.0f)

#define TopStatus  ((iPhoneX || iPhoneXR)?44:20)
#define TopHeight  ((iPhoneX || iPhoneXR)?88:64)
#define BottomHeight ((iPhoneX || iPhoneXR)?34:0)
#define BottomStatus ((iPhoneX || iPhoneXR)?(49+34):49)



#endif /* PrefixHeader_pch */

