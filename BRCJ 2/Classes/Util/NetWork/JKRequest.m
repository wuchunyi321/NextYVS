
#import "JKRequest.h"

#import "NSString+Security.h"

#import "UserInfoModel.h"
#import "MyMember.h"
#import "SchoolListItem.h"
#import "AnchorModel.h"

#import "BankCardModel.h"

//#import "NewsModel.h"
#import "NewUser.h"
#import "AcountModel.h"

@implementation JKRequest

#pragma mark - GetSMSCode
+(void)requestSMSCodeWithPhoneNum:(NSString *)phoneNum
                          smsType:(NSNumber *)smsType
                          success:(SuccessHandler)success
                          failure:(FailureHandler)failure{

    JKNetwork *network =[JKNetwork new];

    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:phoneNum forKey:@"mobile"];
    [params setObject:smsType forKey:@"type"];

    [network request:BRSMSCodeURL requestType:JKRequestTypePOST parameters:params showLoading:YES success:^(id responseObject) {

        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

#pragma mark - register
+(void)requestRegisterWithUserName:(NSString *)userName
                        Invitation:(NSString *)invitation
                           smsCode:(NSString *)smsCode
                           success:(SuccessHandler)success
                           failure:(FailureHandler)failure{

    JKNetwork *network =[JKNetwork new];

    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:userName forKey:@"mobile"];
    [params setObject:invitation forKey:@"inviteCode"];
    [params setObject:smsCode forKey:@"code"];

    [network request:BRRegisterURL
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            AcountModel *account = [JKModelConvert dataModelWithClass:[AcountModel class] andSource:responseObject[@"account"]];
            [account saveToFile];
            UserInfoModel *model =[JKModelConvert dataModelWithClass:[UserInfoModel class] andSource:responseObject[@"data"]];
            [model saveToFile];
            [UserContext setAccessToken:responseObject[@"token"]];
            if (responseObject[@"member"] && [responseObject[@"member"] isKindOfClass:[NSDictionary class]]) {
                MyMember      *member = [JKModelConvert dataModelWithClass:[MyMember class] andSource:responseObject];
                [member saveToFile];
            }else{
                NSLog(@"非");
            }
            success(@"注册成功");
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}
//
#pragma mark - login
+(void)requestLoginWithPhoneNum:(NSString *)phoneNum
                        smsCode:(NSString *)smsCode
                        success:(SuccessHandler)success
                        failure:(FailureHandler)failure{


    JKNetwork *network =[JKNetwork new];

    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:phoneNum forKey:@"loginName"];
    [params setObject:smsCode forKey:@"passwd"];

    [network request:BRLoginURL
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        NSLog(@"他和 back === %@",responseObject);
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            AcountModel *account = [JKModelConvert dataModelWithClass:[AcountModel class] andSource:responseObject[@"account"]];
            [account saveToFile];
            UserInfoModel *model =[JKModelConvert dataModelWithClass:[UserInfoModel class] andSource:responseObject[@"data"]];
            [model saveToFile];
            [UserContext setAccessToken:responseObject[@"token"]];
            if (responseObject[@"member"] && [responseObject[@"member"] isKindOfClass:[NSDictionary class]]) {
                MyMember      *member = [JKModelConvert dataModelWithClass:[MyMember class] andSource:responseObject[@"member"]];
                [member saveToFile];
            }else{
                NSLog(@"非");
            }
            success(@"登录成功");
        }
        
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

// checkVersion
+(void)requestCheckVersionWithVersion:(NSString *)version
                                 type:(NSString *)type
                              success:(SuccessHandler)success
                              failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setValue:version forKey:@"version"];
    [params setValue:type forKey:@"type"];
    [network request:BRCheckVersion
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage , id responseObject) {
        failure(errorMessage,responseObject);
    }];
}

// 获取gupiao数据
+(void)requestWithStr:(NSString *)url
              success:(SuccessHandler)success
              failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    [network request:url
          parameters:nil
             success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

#pragma mark -- HomeList
+(void)requestHomepageInfoWithSuccess:(SuccessHandler)success
                              failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    
    [network request:BRHomePageList
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage , id responseObject) {
        failure(errorMessage,responseObject);
    }];
}

+(void)requestHomeBannerListWithSuccess:(SuccessHandler)success
                                failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setValue:@"mobile" forKey:@"classification"];
    [network request:BRHomeBannerList
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage , id responseObject) {
        failure(errorMessage,responseObject);
    }];
}

+(void)requestHomeSecuritiescompanyListWithPage:(NSString *)pageIndex
                                       pageSize:(NSString *)pageSize
                                    companyName:(NSString*)company
                                        Success:(SuccessHandler)success
                                        failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setValue:pageIndex forKey:@"pageNo"];
    [params setValue:pageSize forKey:@"pageSize"];
    [network request:BRHomeSecuritiescompanyList
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage , id responseObject) {
        failure(errorMessage,responseObject);
    }];
}

+(void)requestHomeNewVideoListWithPage:(NSString *)pageIndex
                              pageSize:(NSString *)pageSize
                               Success:(SuccessHandler)success
                               failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setValue:pageIndex forKey:@"pageNo"];
    [params setValue:pageSize forKey:@"pageSize"];
    [network request:BRHomeNewViedios
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage , id responseObject) {
        failure(errorMessage,responseObject);
    }];
}

// School List
+(void)requestSchoolListWithPageNumber:(NSString *)pageNumber
                              PageSize:(NSString *)pageSize
                            schoolType:(NSString *)schoolType
                               success:(SuccessHandler)success
                               failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:pageNumber forKey:@"pageNo"];
    [params setObject:pageSize forKey:@"pageSize"];
    [params setObject:schoolType forKey:@"videoType"];
    
    [network request:BRSchoolList requestType:JKRequestTypePOST parameters:params showLoading:YES success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = responseObject[@"data"];
            NSArray *array = [JKModelConvert dataModelWithClass:[SchoolListItem class] andSource:dict[@"list"]];
            success(array);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}
//  school EspeciallyList
+(void)requestSchoolEspeciallyPageNumber:(NSString *)pageNumber
                                PageSize:(NSString *)pageSize
                                AnchorId:(NSString *)anchorId
                                 success:(SuccessHandler)success
                                 failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:pageNumber forKey:@"pageNo"];
    [params setObject:pageSize forKey:@"pageSize"];
    [params setObject:anchorId forKey:@"anchorId"];
    
    [network request:BRSchoolEspeciallyList requestType:JKRequestTypePOST parameters:params showLoading:YES success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

//  school check
+(void)requestSchoolcheckWithType:(NSString *)type
                       materialId:(NSString *)materialId
                          success:(SuccessHandler)success
                          failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:type forKey:@"type"];
    [params setObject:materialId forKey:@"materialId"];
    
    [network request:BRVedioCheck
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

//

// MoneyInfo
+(void)requestMoneyInfoWithSuccess:(SuccessHandler)success
                           failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    
    [network request:BRMoneyInfo requestType:JKRequestTypePOST parameters:params showLoading:YES success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}
// BRMoneyCardList
+(void)requestBRMoneyCardList:(NSString *)userID
                      success:(SuccessHandler)success
                      failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:userID forKey:@"userId"];
    
    [network request:BRMoneyCardList requestType:JKRequestTypePOST parameters:params showLoading:YES success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *array = [JKModelConvert dataModelWithClass:[BankCardModel class] andSource:responseObject[@"data"]];
            success(array);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}
// BRMoneyCardAdd
+(void)requestMoneyCardAdd:(NSString *)cardOwner
                cardNumber:(NSString *)cardNumber
                  bankName:(NSString *)bankName
              reservePhone:(NSString *)reservePhone
                 isDefault:(NSString *)isDefault
                   success:(SuccessHandler)success
                   failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:cardOwner forKey:@"cardOwner"];
    [params setObject:cardNumber forKey:@"bankCardNumber"];
    [params setObject:bankName forKey:@"bankName"];
    [params setObject:reservePhone forKey:@"reservePhone"];
    [params setObject:isDefault forKey:@"isDefault"];
    
    [network request:BRMoneyCardAdd requestType:JKRequestTypePOST parameters:params showLoading:YES success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

// DeleteCard
+(void)requestMoneyCardDelete:(NSString *)cardId
                      success:(SuccessHandler)success
                      failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:cardId forKey:@"bId"];
    
    [network request:BRMoneyCardDelete requestType:JKRequestTypePOST parameters:params showLoading:YES success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                success(responseObject);
            }
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}
// MoneyAdd
+(void)requestMoneyAdd:(NSString *)cardId
            drawAmount:(NSString *)drawAmount
               success:(SuccessHandler)success
               failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:drawAmount forKey:@"drawAmount"];
    [params setObject:cardId forKey:@"bankCard"];
    
    [network request:BRMoneyAdd requestType:JKRequestTypePOST parameters:params showLoading:YES success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}
// BRFriendsList 暂时还不分页
+(void)requestFriendsListWithPage:(NSNumber *)page
                         pageSize:(NSNumber *)pageSize
                             type:(NSNumber *)type
                          success:(SuccessHandler)success
                          failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    NSMutableDictionary *params =[NSMutableDictionary new];
    [network request:BRFriendsList
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

// messages
+(void)requestMessageListWithPage:(NSString *)page
                         pageSize:(NSString *)pageSize
                          success:(SuccessHandler)success
                          failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:page forKey:@"pageNo"];
    [params setObject:pageSize forKey:@"pageSize"];
    [network request:BRMessageList requestType:JKRequestTypePOST parameters:params showLoading:YES success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

// update inviteCode
+(void)requestUpdateInviteCodeSuccess:(SuccessHandler)success
                              failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    NSMutableDictionary *params =[NSMutableDictionary new];
    [network request:BRUpdateInviteCode
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

// 修改个人信息
+ (void)requestUserInfoUpdate:(NSString *)nickName
                          sex:(NSString *)sex
                         name:(NSString *)name
                 headPortrait:(NSString *)headPortrait
                           id:(NSString *)u_id
                      success:(SuccessHandler)success
                      failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:u_id forKey:@"id"];
    if (nickName && nickName.length > 0) {
        [params setObject:nickName forKey:@"nickName"];
    }
    if (sex && sex.length > 0) {
        [params setObject:sex forKey:@"sex"];
    }
    if (headPortrait && headPortrait.length > 0) {
        [params setObject:headPortrait forKey:@"headPortrait"];
    }
    if (name && name.length > 0) {
        [params setObject:name forKey:@"name"];
    }

    [network request:BRUserRevise
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

// Upload
+(void)requestUploadWithKey:(NSString *)key
                       data:(NSData *)data
                    success:(SuccessHandler)success
                    failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:key forKey:@"key"];
    [network requestPost:BRUpload
          BodyDictionary:params
                fileData:data
                 success:^(id responseObject) {
                     NSLog(@"the backStr == %@",responseObject);
                     if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                         success(responseObject);
                     }
                 }
                 failure:^(NSString *errorMessage, id responseObject) {
                     failure(errorMessage,responseObject);
                 }];
}


#pragma mark --- StockList
+ (void)requestGetStockListWithType:(NSString *)type
                          PageIndex:(NSString *)pageIndex
                           pageSize:(NSString *)pageSize
                           classify:(NSString *)classify
                            success:(SuccessHandler)success
                            failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:type forKey:@"shareType"];
    [params setObject:pageIndex forKey:@"pageNo"];
    [params setObject:pageSize forKey:@"pageSize"];
    [params setObject:classify forKey:@"classify"];
    
    [network request:BRStockList
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject[@"data"]);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

#pragma mark --- StockPlay
+ (void)requestGetStockPlayWithType:(NSString *)type
                          pageIndex:(NSString *)pageIndex
                           pageSize:(NSString *)pageSize
                           anchorId:(NSString *)anchorId
                            success:(SuccessHandler)success
                            failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:type forKey:@"shareType"];
    [params setObject:pageIndex forKey:@"pageNo"];
    [params setObject:pageSize forKey:@"pageSize"];
    [params setObject:anchorId forKey:@"anchorId"];
    
    [network request:BRStockplay requestType:JKRequestTypePOST parameters:params showLoading:YES success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject[@"data"]);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

//Report
+ (void)requestReportPersonListsuccess:(SuccessHandler)success
                               failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    NSMutableDictionary *params =[NSMutableDictionary new];
    [network request:BRReportPerson requestType:JKRequestTypePOST parameters:params showLoading:YES success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

//ReportCheck
+ (void)requestReportCheckwithId:(NSString *)r_id
                         success:(SuccessHandler)success
                         failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setValue:r_id forKey:@"reportId"];
    [network request:BRReportcheck
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

//ReportList
+(void)requestReportListWithPageIndex:(NSNumber *)pageIndex
                             PageSize:(NSNumber *)pageSize
                               userId:(NSString *)userId
                               status:(NSString *)status
                                grade:(NSString *)grade
                              success:(SuccessHandler)success
                              failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    NSMutableDictionary *params =[NSMutableDictionary new];
    if (userId.length > 0) {
        [params setObject:userId forKey:@"userId"];
    }
    [params setObject:status forKey:@"status"];
    [params setObject:pageSize forKey:@"pageSize"];
    [params setObject:pageIndex forKey:@"pageNo"];
//    [params setObject:grade forKey:@"grade"];

    [network request:BRReportList
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

// Comment
+(void)requestCommentAddWithContent:(NSString *)content
                         materialId:(NSString *)materialId
                            success:(SuccessHandler)success
                            failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:content forKey:@"content"];
    [params setObject:materialId forKey:@"materialId"];
    
    [network request:BRCommentAdd requestType:JKRequestTypePOST parameters:params showLoading:YES success:^(id responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

+(void)requestCommentListWithPageIndex:(NSString *)pageIndex
                              pageSize:(NSString *)pageSize
                            materialId:(NSString *)materialId
                               success:(SuccessHandler)success
                               failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:pageIndex forKey:@"pageNo"];
    [params setObject:pageSize forKey:@"pageSize"];
    [params setObject:materialId forKey:@"materialId"];
    
    [network request:BRCommentList requestType:JKRequestTypePOST parameters:params showLoading:YES success:^(id responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject[@"data"]);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

//Pay
+(void)requestPayWithRechargeLevel:(NSString *)rechargeLevel
                            userId:(NSString *)userId
                             grade:(NSString *)grade
                            mobile:(NSString *)mobile
                            success:(SuccessHandler)success
                           failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:rechargeLevel forKey:@"rechargeLevel"];
    [params setObject:userId forKey:@"userId"];
    [params setObject:grade forKey:@"grade"];
    [params setObject:mobile forKey:@"mobile"];
    
    [network request:BRPay
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

//Pay
+(void)requestPayWithVXRechargeLevel:(NSString *)rechargeLevel
                            userId:(NSString *)userId
                             grade:(NSString *)grade
                            mobile:(NSString *)mobile
                            success:(SuccessHandler)success
                             failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:rechargeLevel forKey:@"rechargeLevel"];
    [params setObject:userId forKey:@"userId"];
    [params setObject:grade forKey:@"grade"];
    [params setObject:mobile forKey:@"mobile"];
    
    [network request:BRPayVX
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}


//Pay
+(void)requestPayListPageNumber:(NSString *)pageNumber
                        PageSize:(NSString *)PageSize
                        success:(SuccessHandler)success
                        failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:pageNumber forKey:@"pageNo"];
    [params setObject:PageSize forKey:@"pageSize"];
    
    [network request:BRPayList
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

//Pay
+(void)requestPaySearchOutTradeNo:(NSString *)outTradeNo
                          success:(SuccessHandler)success
                          failure:(FailureHandler)failure{
    JKNetwork *network =[JKNetwork new];
    
    NSMutableDictionary *params =[NSMutableDictionary new];
    [params setObject:outTradeNo forKey:@"outTradeNo"];
    
    [network request:BRPaySearch
         requestType:JKRequestTypePOST
          parameters:params
         showLoading:YES
             success:^(id responseObject) {
        
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSString *errorMessage,id responseObject) {
        failure(errorMessage,nil);
    }];
}

#pragma mark - end

@end
