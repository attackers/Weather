//
//  EncryptorManager.m
//  LoanIterationDemo
//
//  Created by PasserMontanus on 2018/5/10.
//  Copyright © 2018年 Passer Montanus. All rights reserved.
//

#import "EncryptorManager.h"
//AES
#import "SecurityUtil.h"

//RSA
#import "RSAEncryptor.h"
#import "NSData+Base64.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
#import <Security/SecBase.h>
//MD5
#import "NSString+MD5.h"



#define PUBLIC_KEY  @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAm/Mo8LHDV+t24KsJj3uHZsSLgsU23yxlT20k/                  xUQKXxIaaedeRhYXod0cC4iAhnk5UNFT7caDw0jCTyD7Y4vPq05+jgpqlUiexNZTZNQ/09lPXneD1Y132W5osUMFi30/izGe3MKOoB2Ooe1RHuD8hYc36r01oQHn8D72Z4BI9pVo+sk+jisHgNvd8gviLKTNtPSwOuKkrYXZDvuaIQfOMWDVia3UvMNMB2cW/puBwL5jyxFqDJ1bUYSdnB9hnMNcGD4PbWE4PzOwEyPKBAeTVqx98NbPdW4p/i6PuVR///Tq/ZcNssILZih6TWvKxLclAfhTp2+dtonG1np1CdFUwIDAQAB"

#define kChosenDigestLength CC_SHA1_DIGEST_LENGTH


@implementation EncryptorManager

#pragma mark -----  AES --------------

// AES 把字符串加密后返回
+ (NSString *)encryptWithAESString:(NSString *)originalStr {
    return [SecurityUtil encryptAESData:originalStr app_key:SECURITY_AES_KEY];
}

// AES 解密 返回解密后的字符串
+ (NSString *)decryptWithAESString:(NSString *)decryptionStr {
    return [SecurityUtil decryptAESString:decryptionStr app_key:SECURITY_AES_KEY];
}

#pragma mark ---- RSA  ------

+ (NSString *)encryptWithRSAString:(NSString *)str {
    return [RSAEncryptor encryptString:str publicKey:PUBLIC_KEY];
}

+ (NSString *)decryptWithRSAString:(NSString *)str {
    NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];
    return [RSAEncryptor decryptString:str privateKeyWithContentsOfFile:private_key_path password:@"Zzcm123"];
}

+ (NSString*)signTheDataSHA1WithRSA:(NSString*)plainText {
    uint8_t* signedBytes =NULL;
    
    size_t signedBytesSize =0;
    
    OSStatus sanityCheck =noErr;
    
    NSData* signedHash =nil;
    
    NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];
    
    NSData* data = [NSData dataWithContentsOfFile:private_key_path];
    
    NSMutableDictionary* options = [[NSMutableDictionary alloc]init];
    
    [options setObject:@"Zzcm123"forKey:(id)kSecImportExportPassphrase];
    
    CFArrayRef items =CFArrayCreate(NULL,0,0,NULL);
    
    OSStatus securityError =SecPKCS12Import((CFDataRef) data, (CFDictionaryRef)options, &items);
    
    if(securityError!=noErr) {
        
        return nil;
        
    }
    
    CFDictionaryRef identityDict =CFArrayGetValueAtIndex(items,0);
    
    SecIdentityRef identityApp =(SecIdentityRef)CFDictionaryGetValue(identityDict,kSecImportItemIdentity);
    
    SecKeyRef privateKeyRef=nil;
    
    SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
    
    signedBytesSize =SecKeyGetBlockSize(privateKeyRef);
    
    NSData*plainTextBytes = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    
    signedBytes =malloc( signedBytesSize *sizeof(uint8_t) );// Malloc a buffer to hold signature.
    
    memset((void*)signedBytes,0x0, signedBytesSize);
    
    sanityCheck =SecKeyRawSign(privateKeyRef,
                               
                               kSecPaddingPKCS1SHA1,
                               
                               (const uint8_t*)[[self getHashBytes:plainTextBytes]bytes],
                               
                               kChosenDigestLength,
                               
                               (uint8_t*)signedBytes,
                               
                               &signedBytesSize);
    
    if(sanityCheck ==noErr)  {
        signedHash = [NSData dataWithBytes:(const void*)signedBytes length:(NSUInteger)signedBytesSize];
    } else {
        return nil;
    }
    
    if(signedBytes) {
        free(signedBytes);
    }
    NSString*signatureResult = [[NSString alloc]initWithData:[signedHash base64EncodedDataWithOptions:0]encoding:NSASCIIStringEncoding];
    return signatureResult;
}

+ (NSData*)getHashBytes:(NSData*)plainText {
    CC_SHA1_CTX ctx;
    uint8_t* hashBytes =NULL;
    NSData* hash =nil;
    hashBytes =malloc(kChosenDigestLength*sizeof(uint8_t) );
    memset((void*)hashBytes,0x0,kChosenDigestLength);
    CC_SHA1_Init(&ctx);
    CC_SHA1_Update(&ctx, (void*)[plainText bytes], (CC_LONG)[plainText length]);
    CC_SHA1_Final(hashBytes, &ctx);
    hash = [NSData dataWithBytes:(const void*)hashBytes length:(NSUInteger)kChosenDigestLength];
    if(hashBytes)free(hashBytes);
    return hash;
}


#pragma Mark   ------------------   MD5 -----------

+ (NSString *)md5WithString:(NSString *)str {
    return [NSString md5:str];
}
@end
