//
//  NSData+Base64.h
//  HaveCreditCardWallet
//
//  Created by PasserMontanus on 2017/10/27.
//  Copyright © 2017年 PasserMontanus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;

@end
