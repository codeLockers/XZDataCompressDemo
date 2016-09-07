//
//  XZGzipHelper.h
//  XZDataCompressDemo
//
//  Created by 徐章 on 16/9/6.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZGzipHelper : NSObject

+ (NSData *)gzipCompress:(NSData *)sourceData;
+ (NSData *)gzipUncompress:(NSData *)sourceData;
@end
