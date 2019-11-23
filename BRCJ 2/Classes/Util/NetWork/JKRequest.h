
#import <Foundation/Foundation.h>

#import "JKNetwork.h"

@interface JKRequest : NSObject

#pragma mark - Login Module ---------------
// SMSCode
+(void)requestSMSCodeWithPhoneNum:(NSString *)phoneNum
                          smsType:(NSNumber *)smsType
                          success:(SuccessHandler)success
                          failure:(FailureHandler)failure;

// register
+(void)requestRegisterWithUserName:(NSString *)userName
                        Invitation:(NSString *)invitation
                           smsCode:(NSString *)smsCode
                           success:(SuccessHandler)success
                           failure:(FailureHandler)failure;
// login
+(void)requestLoginWithPhoneNum:(NSString *)phoneNum
                        smsCode:(NSString *)smsCode
                        success:(SuccessHandler)success
                        failure:(FailureHandler)failure;
// checkVersion
+(void)requestCheckVersionWithVersion:(NSString *)version
                                 type:(NSString *)type
                              success:(SuccessHandler)success
                              failure:(FailureHandler)failure;
// 获取gupiao数据
+(void)requestWithStr:(NSString *)url
              success:(SuccessHandler)success
              failure:(FailureHandler)failure;

#pragma mark -- HomeList
+(void)requestHomepageInfoWithSuccess:(SuccessHandler)success
                              failure:(FailureHandler)failure;

+(void)requestHomeBannerListWithSuccess:(SuccessHandler)success
                                failure:(FailureHandler)failure;

+(void)requestHomeSecuritiescompanyListWithPage:(NSString *)pageIndex
                                       pageSize:(NSString *)pageSize
                                    companyName:(NSString*)company
                                        Success:(SuccessHandler)success
                                        failure:(FailureHandler)failure;

+(void)requestHomeNewVideoListWithPage:(NSString *)pageIndex
                              pageSize:(NSString *)pageSize
                               Success:(SuccessHandler)success
                               failure:(FailureHandler)failure;

#pragma mark - School Module ------------------
// School List
+(void)requestSchoolListWithPageNumber:(NSString *)pageNumber
                              PageSize:(NSString *)pageSize
                             schoolType:(NSString *)schoolType
                                success:(SuccessHandler)success
                                failure:(FailureHandler)failure;
//  school EspeciallyList
+(void)requestSchoolEspeciallyPageNumber:(NSString *)pageNumber
                                PageSize:(NSString *)pageSize
                                AnchorId:(NSString *)anchorId
                                 success:(SuccessHandler)success
                                 failure:(FailureHandler)failure;

//  school check
+(void)requestSchoolcheckWithType:(NSString *)type
                       materialId:(NSString *)materialId
                          success:(SuccessHandler)success
                          failure:(FailureHandler)failure;

// MoneyInfo
+(void)requestMoneyInfoWithSuccess:(SuccessHandler)success
                           failure:(FailureHandler)failure;
// BRMoneyCardList
+(void)requestBRMoneyCardList:(NSString *)userID
                      success:(SuccessHandler)success
                      failure:(FailureHandler)failure;
// BRMoneyCardAdd
+(void)requestMoneyCardAdd:(NSString *)cardOwner
                 cardNumber:(NSString *)cardNumber
                   bankName:(NSString *)bankName
               reservePhone:(NSString *)reservePhone
                   isDefault:(NSString *)isDefault
                    success:(SuccessHandler)success
                    failure:(FailureHandler)failure;
// DeleteCard
+(void)requestMoneyCardDelete:(NSString *)cardId
                       success:(SuccessHandler)success
                       failure:(FailureHandler)failure;
// MoneyAdd
+(void)requestMoneyAdd:(NSString *)cardId
            drawAmount:(NSString *)drawAmount
               success:(SuccessHandler)success
               failure:(FailureHandler)failure;

// friends
+(void)requestFriendsListWithPage:(NSNumber *)page
                         pageSize:(NSNumber *)pageSize
                             type:(NSNumber *)type
                          success:(SuccessHandler)success
                          failure:(FailureHandler)failure;

// messages
+(void)requestMessageListWithPage:(NSString *)page
                         pageSize:(NSString *)pageSize
                          success:(SuccessHandler)success
                          failure:(FailureHandler)failure;

// update inviteCode
+(void)requestUpdateInviteCodeSuccess:(SuccessHandler)success
                          failure:(FailureHandler)failure;

// Upload
+(void)requestUploadWithKey:(NSString *)key
                       data:(NSData *)data
                    success:(SuccessHandler)success
                    failure:(FailureHandler)failure;

// 修改个人信息
+ (void)requestUserInfoUpdate:(NSString *)nickName
                          sex:(NSString *)sex
                         name:(NSString *)name
                 headPortrait:(NSString *)headPortrait
                           id:(NSString *)u_id
                      success:(SuccessHandler)success
                      failure:(FailureHandler)failure;

#pragma mark --- StockList
+ (void)requestGetStockListWithType:(NSString *)type
                          PageIndex:(NSString *)pageIndex
                           pageSize:(NSString *)pageSize
                           classify:(NSString *)classify
                            success:(SuccessHandler)success
                            failure:(FailureHandler)failure;
#pragma mark --- StockPlay
+ (void)requestGetStockPlayWithType:(NSString *)type
                          pageIndex:(NSString *)pageIndex
                           pageSize:(NSString *)pageSize
                           anchorId:(NSString *)anchorId
                            success:(SuccessHandler)success
                            failure:(FailureHandler)failure;

//Report
+ (void)requestReportPersonListsuccess:(SuccessHandler)success
                               failure:(FailureHandler)failure;

//ReportCheck
+ (void)requestReportCheckwithId:(NSString *)r_id
                         success:(SuccessHandler)success
                         failure:(FailureHandler)failure;

//ReportList
+(void)requestReportListWithPageIndex:(NSNumber *)pageIndex
                             PageSize:(NSNumber *)pageSize
                               userId:(NSString *)userId
                               status:(NSString *)status
                                grade:(NSString *)grade
                              success:(SuccessHandler)success
                              failure:(FailureHandler)failure;

// Comment
+(void)requestCommentAddWithContent:(NSString *)content
                         materialId:(NSString *)materialId
                            success:(SuccessHandler)success
                            failure:(FailureHandler)failure;

+(void)requestCommentListWithPageIndex:(NSString *)pageIndex
                              pageSize:(NSString *)pageSize
                            materialId:(NSString *)materialId
                               success:(SuccessHandler)success
                               failure:(FailureHandler)failure;

//Pay
+(void)requestPayWithRechargeLevel:(NSString *)rechargeLevel
                            userId:(NSString *)userId
                             grade:(NSString *)grade
                            mobile:(NSString *)mobile
                            success:(SuccessHandler)success
                            failure:(FailureHandler)failure;

//Pay
+(void)requestPayWithVXRechargeLevel:(NSString *)rechargeLevel
                            userId:(NSString *)userId
                             grade:(NSString *)grade
                            mobile:(NSString *)mobile
                            success:(SuccessHandler)success
                            failure:(FailureHandler)failure;

//#pragma mark - reform Module --------------------
//// 新闻
//+ (void)requestNewsWithType:(NSString *)type
//                    withKey:(NSString *)key
//                    success:(SuccessHandler)success
//                    failure:(FailureHandler)failure;
//// 笑话大全
//+ (void)requestJokersWithSort:(NSString *)sort
//                      withKey:(NSString *)key
//                    pageIndex:(NSInteger)pageIndex
//                     pageSize:(NSInteger)pageSize
//                         time:(NSString *)time
//                      success:(SuccessHandler)success
//                      failure:(FailureHandler)failure;
//// 历史上的今天
//+ (void)requestHistoryIn:(NSString *)version
//                 withKey:(NSString *)key
//                   month:(NSInteger )month
//                     day:(NSInteger)day
//                 success:(SuccessHandler)success
//                 failure:(FailureHandler)failure;
//
////老黄历
//+ (void)requestLaohuangliWithDate:(NSString *)date
//                              Key:(NSString *)key
//                          success:(SuccessHandler)success
//                          failure:(FailureHandler)failure;
//
////testLogin
//+ (void)requestTestLoginWith:(NSString *)user_name
//                    password:(NSString *)password
//                     success:(SuccessHandler)success
//                     failure:(FailureHandler)failure;
//
//+(void)requestMedicineNewsTitlesSuccess:(SuccessHandler)success
//                                failure:(FailureHandler)failure;
//
//+(void)requestAllTypesMedicineNews:(NSNumber *)page
//                          pageSize:(NSNumber *)pageSize
//                          newsType:(NSString *)newsType
//                           success:(SuccessHandler)success
//                           failure:(FailureHandler)failure;
//+(void)requestMedicineNewsDetail:(NSNumber *)newsID
//                         success:(SuccessHandler)success
//                         failure:(FailureHandler)failure;

@end
