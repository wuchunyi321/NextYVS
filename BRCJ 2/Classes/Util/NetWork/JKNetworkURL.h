
#import <Foundation/Foundation.h>

@interface JKNetworkURL : NSObject

extern NSString const*LogOutNotification;
#pragma mark --- base
extern NSString *const BRBaseURL;
extern NSString *const BRRongCloudKey;
extern NSString * const BRRongStock_sha;
extern NSString * const BRRongStock_she;
extern NSString * const BRRongStock_chu;
extern NSString * const BRCheckVersion;
#pragma mark - register && login
extern NSString * const BRSMSCodeURL;
extern NSString * const BRRegisterURL;
extern NSString * const BRLoginURL;
#pragma mark --- HomePage
extern NSString * const BRHomePageList;
extern NSString * const BRHomeBannerList;
extern NSString * const BRHomeSecuritiescompanyList;
extern NSString * const BRHomeNewViedios;
#pragma mark - school
extern NSString * const BRSchoolList;
extern NSString * const BRSchoolEspeciallyList;
#pragma mark - money
extern NSString * const BRMoneyInfo;      //可提额等信息
extern NSString * const BRMoneyCardList;  //
extern NSString * const BRMoneyCardAdd;   //添加
extern NSString * const BRMoneyCardDelete;//删除
extern NSString * const BRMoneyAdd;       //添加请求
#pragma mark - friends
extern NSString * const BRFriendsList;
#pragma mark - message
extern NSString * const BRMessageList;
#pragma mark - update inviteCode
extern NSString * const BRUpdateInviteCode;
#pragma mark - stock
extern NSString * const BRStockList;
extern NSString * const BRStockplay;
extern NSString * const BRVedioCheck;
#pragma mark --- Report
extern NSString * const BRReportPerson;
extern NSString * const BRReportList;
extern NSString * const BRReportcheck;
#pragma mark - Comment
extern NSString * const BRCommentAdd;
extern NSString * const BRCommentList;

#pragma mark ------ Upload && userInfoUpdate
extern NSString * const BRUpload;
extern NSString * const BRUserRevise;
#pragma mark --- pay
extern NSString * const BRPay;
extern NSString * const BRPayVX;
extern NSString * const BRPayList;
extern NSString * const BRPaySearch;

@end
