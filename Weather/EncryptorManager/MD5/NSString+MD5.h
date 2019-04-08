//
//  NSString+MD5.h
//  DMIntegration
//
//  Created by Ko Lee on 2018/4/8.
//  Copyright © 2018年 lgl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

/**
 md5加密的字符串

 @param str str
 @return return value
 */
+ (NSString *) md5:(NSString *) str;


@end
