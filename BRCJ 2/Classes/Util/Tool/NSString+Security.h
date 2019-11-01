//
//  NSString+Security.h
//  workstation
//
//  Created by 贾侦修 on 14-7-7.
//  Copyright (c) 2014年 贾侦修. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSString(Security)
/**
 *	@brief	对字符串取md5值，通常用于对url取md5
 *
 *	@param 	url 	字符串
 *
 *	@return	返回小写md5字符串
 */
+(NSString *)md5HexWithString:(NSString *)url;

+(NSString *)md5HexLowerWithString:(NSString *)url;

+(NSString *)decodeFromPercentEscapeString:(NSString *)input;

+(NSString *)encodeToPercentEscapeString:(NSString *)input;
+(NSString*)URLDecodedString:(NSString *)input;
+(NSString*)getUUID;

+(NSString *)getWSAppPath;
+(NSString*)getShortVersion;
+(NSString*)getDateVersion;
+(NSString *)base64Encoding:(NSData*)data;

/**
 *  判断一个字符串是否包含emoji4表情
 *
 *  @param string 要校验的字符串
 *
 *  @return 是否包含emoji4表情
 */
+(NSString*)replaceEmoji:(NSString*)string;
+(NSString*)deleteEmoji:(NSString*)string;
+(NSString*)getCurrentStartImageUrl;
+(void)setCurrentStartImageUrl:(NSString*)imageUrl;



/** trime空格 */
- (NSString *)trime;
@end
