//
//  NSString+Security.m
//  workstation
//
//  Created by 贾侦修 on 14-7-7.
//  Copyright (c) 2014年 贾侦修. All rights reserved.
//

#import "NSString+Security.h"

@implementation NSString(Security)
+(NSString *)md5HexWithString:(NSString *)url
{
    if (url.length == 0) {
        return nil;
    }
    const char *original_str = [url UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str,(CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i =0; i <16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash uppercaseString];
}

+(NSString *)md5HexLowerWithString:(NSString *)url
{
    const char *original_str = [url UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str,(CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i =0; i <16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

+(NSString *)decodeFromPercentEscapeString:(NSString *)input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+(NSString *)encodeToPercentEscapeString:(NSString *)input
{
    NSString *outputStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)input, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    return outputStr;
}

+(NSString*)URLDecodedString:(NSString *)input
{
    NSString*result = (NSString*)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)input, CFSTR(""), kCFStringEncodingUTF8));

    return result;
}

+(NSString*)getUUID
{
//    KeychainItemWrapper * item = [[KeychainItemWrapper alloc]initWithIdentifier:@"UUID" accessGroup:nil];
//    NSString * uuid = [item objectForKey:(__bridge id)(kSecValueData)];
//    if(uuid.length == 0){
//        CFUUIDRef uuidObj = CFUUIDCreate(nil);
//        uuid = (NSString *)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
//        [item setObject:uuid forKey:(__bridge id)(kSecValueData)];
//    }
    return nil;
}

+(NSString *)getWSAppPath
{
    NSArray* userPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* libraryPath = [userPaths objectAtIndex:0];
    NSString* appPath = [libraryPath stringByAppendingString:@"/db"];
    return appPath;
}

+(NSString*)getShortVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return version;
}

+(NSString*)getDateVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDic objectForKey:@"CFBundleVersion"];
    return version;
}

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

+(NSString *)base64Encoding:(NSData*)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSUTF8StringEncoding freeWhenDone:YES];
}

/**
 *  判断两个字符是否为emoji4的控制位
 *
 *  @param c1 第一个字符
 *  @param c2 第二个字符
 *
 *  @return 是否为emoji4控制字符
 */
+(BOOL)isEmojiCharacter:(const unichar)c1 character2:(const unichar)c2
{
    BOOL returnValue = NO;
    
    if (0xd800 <= c1 && c1 <= 0xdbff) {
        const int uc = ((c1 - 0xd800) * 0x400) + (c2 - 0xdc00) + 0x10000;
        
        if (0x1d000 <= uc && uc <= 0x1f77f) {
            returnValue = YES;
        }
    }
    else{
        if (c2 == 0x20e3) {
            returnValue = YES;
        }
    }
    
    return returnValue;
}

/**
 *  判断一个字符串是否包含emoji4表情
 *
 *  @param string 要校验的字符串
 *
 *  @return 是否包含emoji4表情
 */
+(NSString*)replaceEmoji:(NSString*)string
{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    NSRange range;
    //emoji4每个表情4个字节，判断控制位是否是emoji4的表情控制位
    for (int i = 0; i < string.length - 1; i++) {
        const unichar c1 = [string characterAtIndex:i];
        const unichar c2 = [string characterAtIndex:i+1];
        
        if ([self isEmojiCharacter:c1 character2:c2]) {
            range.location = i;
            range.length = 2;
            NSString* emoji = [string substringWithRange:range];
            [array addObject:emoji];
        }
    }
    
    NSString* outString = string.copy;
    
    for (NSString* emojiString in array) {
        outString = [outString stringByReplacingOccurrencesOfString:emojiString withString:@"[表情]"];
    }
    
    return outString;
}

/**
 *  判断一个字符串是否包含emoji4表情
 *
 *  @param string 要校验的字符串
 *
 *  @return 是否包含emoji4表情
 */
+(NSString*)deleteEmoji:(NSString*)string
{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    NSRange range;
    //emoji4每个表情4个字节，判断控制位是否是emoji4的表情控制位
    for (int i = 0; i < string.length - 1; i++) {
        const unichar c1 = [string characterAtIndex:i];
        const unichar c2 = [string characterAtIndex:i+1];
        
        if ([self isEmojiCharacter:c1 character2:c2]) {
            range.location = i;
            range.length = 2;
            NSString* emoji = [string substringWithRange:range];
            [array addObject:emoji];
        }
    }
    
    NSString* outString = string.copy;
    
    for (NSString* emojiString in array) {
        outString = [outString stringByReplacingOccurrencesOfString:emojiString withString:@""];
    }
    
    return outString;
}

+(NSString*)getCurrentStartImageUrl
{
    NSString *filePath = [[NSString getWSAppPath] stringByAppendingPathComponent:@"StartUrl"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    
    if (data.length == 0) {
        return nil;
    }
    else{
        return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
}

+(void)setCurrentStartImageUrl:(NSString*)imageUrl
{
    if (imageUrl.length == 0) {
        return;
    }
    NSString *filePath = [[NSString getWSAppPath] stringByAppendingPathComponent:@"StartUrl"];
    NSData* data = [NSData dataWithBytes:[imageUrl UTF8String] length:[imageUrl lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    [data writeToFile:filePath atomically:YES];
}





- (NSString *)trime
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
@end
