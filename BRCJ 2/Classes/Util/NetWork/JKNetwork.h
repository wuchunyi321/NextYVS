
#import <Foundation/Foundation.h>
//#import "AFNetworking.h"
#import "AFHTTPSessionManager+AddMethod.h"

typedef void (^SuccessHandler) (id responseObject);
typedef void (^FailureHandler)(NSString *errorMessage,id responseObject);
typedef void (^PrepareDataHandler)(id <AFMultipartFormData> formData);


typedef NS_ENUM(NSInteger, JKRequestType) {
    JKRequestTypePOST = 0,
    JKRequestTypeGET  = 1
};

@interface JKNetwork : NSObject

/** 超时时间（默认5秒），下载或者上传文件时，根据需要设置该值 */
@property (nonatomic, assign) NSTimeInterval timeoutSeconds;

#pragma mark - POST && GET
/** 普通用的 **/
- (void)request:(NSString *)URLString
    requestType:(JKRequestType)requestType
     parameters:(NSMutableDictionary *)parameters
    showLoading:(BOOL)isShowLoading
        success:(SuccessHandler)success
        failure:(FailureHandler)failure;
//带二进制文件的请求
- (void)requestPost:(NSString*)urlString
    BodyDictionary:(NSMutableDictionary *)dictionary
          fileData:(NSData *)fileData
           success:(SuccessHandler)success
           failure:(FailureHandler)failure;
- (void)request:(NSString *)URLString
     parameters:(NSMutableDictionary *)parameters
        success:(SuccessHandler)success
        failure:(FailureHandler)failure;
/** 健康账户登陆 **/
- (void)requestTest:(NSString *)URLString
     parameters:(NSMutableDictionary *)parameters
        success:(SuccessHandler)success
        failure:(FailureHandler)failure;



@end
