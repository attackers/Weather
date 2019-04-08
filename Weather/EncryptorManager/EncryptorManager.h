//
//  EncryptorManager.h
//  LoanIterationDemo
//
//  Created by PasserMontanus on 2018/5/10.
//  Copyright © 2018年 Passer Montanus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Define.h"

@interface EncryptorManager : NSObject

#pragma mark ----------- AES 的加解密方法 ----------------------

/**
    把字符串加密后返回
 
 *  @pramas originalStr 需要加密的字符串
 **/

+ (NSString *)encryptWithAESString:(NSString *)originalStr;

/**
    AES 解密 返回解密后的字符串
 
 *  @pramas aesString 需要解密的密文字符串
 **/

+ (NSString *)decryptWithAESString:(NSString *)decryptionStr;



#pragma mark ----------- RSA 的加解密方法 ----------------------

/**
    RSA 加密方法
 
 *  @param str    需要加密的字符串
 */

+ (NSString *)encryptWithRSAString:(NSString *)str;


/**
    RSA 解密方法
 
 *  @param str   需要解密的字符串
 */

+ (NSString *)decryptWithRSAString:(NSString *)str;


/**
 RSA 签名 方法
 
 @param plainText 签名的字符串
 @return 返回签名后的字符串
 */
+ (NSString*)signTheDataSHA1WithRSA:(NSString*)plainText;


#pragma mark --- MD5 字符串处理
/** 字符串MD5处理 **/
+ (NSString *)md5WithString:(NSString *)str;

@end
