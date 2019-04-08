//
//  NSString+SHA.h
//  dfgg
//
//  Created by PasserMontanus on 2017/3/31.
//  Copyright © 2017年 麻雀. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SHA)

-(NSString *) sha1;
-(NSString *) sha224;
-(NSString *) sha256;
-(NSString *) sha384;
-(NSString *) sha512;

@end
