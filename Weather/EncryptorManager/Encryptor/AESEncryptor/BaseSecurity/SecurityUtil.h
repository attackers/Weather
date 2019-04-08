//
//  SecurityUtil.h
//  Smile
//
//  Created by 蒲晓涛 on 12-11-24.
//  Copyright (c) 2012年 BOX. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <Foundation/Foundation.h>

@interface SecurityUtil : NSObject 

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;

+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;

#pragma mark - AES加密
/**
 *  加密   将string加密后返回字符串
 *  @pramas string 加密前的字符串
 *  @pramas key  加密用的key
 **/

+ (NSString*)encryptAESData:(NSString*)string app_key:(NSString*)key ;
/**
 *  解密    将加密的data解密成string
 *  @pramas data 加密后的data
 *  @pramas key  加密用的key
 **/
+(NSString*)decryptAESData:(NSData*)data app_key:(NSString*)key;

/**
 *  解密   将加密后的string解密原来的string
 *  @pramas string 加密后的字符串
 *  @pramas key  加密用的key
 **/
+(NSString*)decryptAESString:(NSString *)string app_key:(NSString*)key;
@end
