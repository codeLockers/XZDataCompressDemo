//
//  XZZlibHelper.h
//  XZDataCompressDemo
//
//  Created by 徐章 on 16/9/7.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZZlibHelper : NSObject

+ (NSData *)zlibCompressData:(NSData *)sourceData;
+ (NSData *)zlibUncompressData:(NSData *)sourceData;

@end
