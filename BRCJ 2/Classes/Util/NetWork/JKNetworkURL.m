#import "JKNetworkURL.h"

NSString const*LogOutNotification = @"LogOutNotification";
// test main url
NSString * const BRBaseURL  = @"https://v1.yunvision.com.cn/one/api/";
//NSString * const BRBaseURL  = @"https://cloud.yunvision.com.cn/one/api/";
NSString * const BRRongCloudKey = @"vnroth0kv49wo";
NSString * const BRRongStock_sha = @"https://hq.sinajs.cn/list=s_sh000001";
NSString * const BRRongStock_chu = @"https://hq.sinajs.cn/list=s_sz399006";
NSString * const BRRongStock_she = @"https://hq.sinajs.cn/list=s_sz399001";
NSString * const BRCheckVersion = @"check/version";
#pragma mark --- HomePage
NSString * const BRHomePageList = @"homepage/list";
NSString * const BRHomeBannerList = @"banner/list";
NSString * const BRHomeSecuritiescompanyList = @"securitiescompany/list";
NSString * const BRHomeNewViedios = @"newvideos/list";
#pragma mark - register && login
NSString * const BRSMSCodeURL = @"smsSend";
NSString * const BRRegisterURL = @"user/registerIos";
NSString * const BRLoginURL = @"user/loginIos";
#pragma mark - school
NSString * const BRSchoolList = @"schoolvideo/list";
NSString * const BRSchoolEspeciallyList = @"schoolvideo/play";
#pragma mark - money
NSString * const BRMoneyInfo        = @"userfinance/drawSkip";      //可金额等信息
NSString * const BRMoneyCardList    = @"bankcard/list";  //列表
NSString * const BRMoneyCardAdd     = @"bankcard/add";   //添加
NSString * const BRMoneyCardDelete  = @"bankcard/delete";//删除
NSString * const BRMoneyAdd         = @"draworder/add";       //添加请求
#pragma mark - friends
NSString * const BRFriendsList = @"user/goodfriends";
#pragma mark - message
NSString * const BRMessageList = @"pushmessage/list";
#pragma mark - update inviteCode
NSString * const BRUpdateInviteCode = @"user/resetInvitationCode";
#pragma mark - stock
NSString * const BRStockList = @"sharecontent/backList";
NSString * const BRStockplay = @"sharecontent/play";
NSString * const BRVedioCheck = @"schoolvideo/check";
#pragma mark ------ Upload && userInfoUpdate
NSString * const BRUpload = @"oss/upload";
NSString * const BRUserRevise = @"user/revise";

#pragma mark --- Report
NSString * const BRReportPerson = @"securitiespersonel/list";
NSString * const BRReportList = @"researchreport/reportList";
NSString * const BRReportcheck = @"researchreport/check";
#pragma mark - Comment
NSString * const BRCommentAdd = @"comment/add";
NSString * const BRCommentList = @"comment/list";
#pragma mark --- pay
NSString * const BRPay = @"order/ali";
NSString * const BRPayVX = @"order/wx";
NSString * const BRPayList = @"order/orderList";
NSString * const BRPaySearch = @"order/orderQuery";
