
#import "JKNetwork.h"

#import "NSString+Security.h"
#import "Reachability.h"

#import "UserInfoModel.h"

#import "NewUser.h"

NSString *const BRTimeoutTip = @"请求超时，请您稍后再试";
NSString *const BRServerNoTip = @"服务器异常，请您稍后再试";
NSString *const BRNetworkNoneNetTip = @"您的网络不给力，请稍候再试";

@implementation JKNetwork

#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        self.timeoutSeconds = 10.0f;
    }
    return self;
}

#pragma mark - POST && GET

- (void)requestTest:(NSString *)URLString
         parameters:(NSMutableDictionary *)parameters
            success:(SuccessHandler)success
            failure:(FailureHandler)failure{
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    if (netStatus == NotReachable) {
        failure (BRNetworkNoneNetTip,nil);
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer  *request = [AFHTTPRequestSerializer serializer];
    request.timeoutInterval = self.timeoutSeconds;
    manager.requestSerializer = request;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *absoluteURLString = URLString;
    if (!parameters) {
        parameters = [NSMutableDictionary new];
    }
    
    [manager POST:absoluteURLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"请求失败，请稍后再试",nil);
    }];
}


- (void)request:(NSString *)URLString
     parameters:(NSMutableDictionary *)parameters
        success:(SuccessHandler)success
        failure:(FailureHandler)failure{
        
        // check network state
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    if (netStatus == NotReachable) {
        failure (BRNetworkNoneNetTip,nil);
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer  *request = [AFHTTPRequestSerializer serializer];
    request.timeoutInterval = self.timeoutSeconds;
    manager.requestSerializer = request;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *absoluteURLString = URLString;
    if (!parameters) {
        parameters = [NSMutableDictionary new];
    }
    
    [manager POST:absoluteURLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSString *retStr = [[NSString alloc] initWithData:responseObject encoding:enc];
        success(retStr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"请求失败，请稍后再试",nil);
    }];
}

- (void)request:(NSString *)URLString
    requestType:(JKRequestType)requestType
     parameters:(NSMutableDictionary *)parameters
    showLoading:(BOOL)isShowLoading
        success:(SuccessHandler)success
        failure:(FailureHandler)failure {

    // check network state
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus netStatus = [reach currentReachabilityStatus];

    if (netStatus == NotReachable) {
        failure (BRNetworkNoneNetTip,nil);
        return;
    }

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer  *request = [AFHTTPRequestSerializer serializer];
    request.timeoutInterval = self.timeoutSeconds;
    UserInfoModel  *info = [UserInfoModel readFromFile];
    if (info) {
        [request setValue:[UserContext getAccessToken] forHTTPHeaderField:@"Authorization"];
    }
    manager.requestSerializer = request;
    NSString *absoluteURLString = [BRBaseURL stringByAppendingString:URLString];
    /*
     避免不需要的字符
     */
    absoluteURLString =  [absoluteURLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    if (!parameters)
        parameters =[NSMutableDictionary new];
    
    /**
     在这里传入基础参数，如果有基础参数的话
     **/

    
    NSLog(@"=====requestURL is =====  %@",absoluteURLString);

    NSError* error = nil;
    NSData* body = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
    NSString* tests = [[NSString alloc]initWithData:body encoding:NSUTF8StringEncoding];

    NSLog(@"=====json params  are ===== %@",tests);

    if (requestType == JKRequestTypePOST) {
        [manager NewPOST:absoluteURLString
              parameters:parameters
                progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = responseObject;
            NSLog(@"adict == %@",dic);
            if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                NSNumber *code =dic[@"code"];
                if (code.integerValue == 10000) // 请求成功
                    success (dic);
                else { // 请求失败
                    if (dic[@"msg"])
                        failure (dic[@"msg"],nil);
                    else
                        failure (BRServerNoTip,nil);
                }
            } else
                failure(BRServerNoTip,nil);

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error,id responseObject) {
            NSLog(@"======== 失败结果 %@",error);
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                NSString *code = responseObject[@"code"];
                if (code.integerValue == 10004) { //token过期
                    [[NSNotificationCenter defaultCenter] postNotificationName:LogOutNotification object:nil];
                }
                
            }else if (error.code == NSURLErrorTimedOut){
                failure(BRTimeoutTip,nil);
            }else{
                failure(BRServerNoTip,nil);
            }
        }];
    }
}

//带二进制文件的请求
-(void)requestPost:(NSString*)urlString
    BodyDictionary:(NSMutableDictionary *)dictionary
          fileData:(NSData *)fileData
           success:(SuccessHandler)success
           failure:(FailureHandler)failure{
    
    // check network state
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    
    if (netStatus == NotReachable) {
        failure (BRNetworkNoneNetTip,nil);
        return ;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPRequestSerializer  *request = [AFHTTPRequestSerializer serializer];
    request.timeoutInterval = self.timeoutSeconds;
    [request setValue:[UserContext getAccessToken] forHTTPHeaderField:@"Authorization"];
    manager.requestSerializer = request;
    NSString *absoluteURLString = [BRBaseURL stringByAppendingString:BRUpload];

    NSError* error = nil;
    NSData* body = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString* tests = [[NSString alloc]initWithData:body encoding:NSUTF8StringEncoding];
    
    NSLog(@"=====json params  are ===== %@",tests);
    [manager POST:absoluteURLString
       parameters:dictionary
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
    [formData appendPartWithFileData:fileData name:@"file" fileName:@"test.jpg" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error,nil);
    }];
}

#pragma mark - return the chinese style json
- (NSString *)getChineseJsonWithResponseObj:(NSDictionary *)responseObj{
    NSData *jsonData =[NSJSONSerialization dataWithJSONObject:responseObj options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

@end
