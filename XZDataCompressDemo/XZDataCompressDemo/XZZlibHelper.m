//
//  XZZlibHelper.m
//  XZDataCompressDemo
//
//  Created by 徐章 on 16/9/7.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZZlibHelper.h"
#import "zlib.h"
@implementation XZZlibHelper

+ (NSData *)zlibCompressData:(NSData *)sourceData{
    
    NSUInteger sourceDataLength = [sourceData length];
    
    if (sourceDataLength == 0) {
        return sourceData;
    }
    
    z_stream stream;
    memset(&stream, 0, sizeof(z_stream));
    
    stream.next_in = (Bytef *)[sourceData bytes];
    stream.avail_in = (uInt)sourceDataLength;
    stream.total_out = 0;
    stream.zalloc = Z_NULL;
    stream.zfree = Z_NULL;
    
    if (deflateInit(&stream, Z_DEFAULT_COMPRESSION) != Z_OK) {
        return nil;
    }
    
    const int KBufLen = 1024;
    Byte buf[KBufLen];
    memset(buf, 0, KBufLen * sizeof(Byte));
    
    BOOL isCompressOK = NO;
    
    NSMutableData *compressedData =
    [NSMutableData dataWithLength:sourceDataLength];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    [compressedData setData:nil]; //必须得加
#pragma clang diagnostic pop
    
    int res = 0;
    
    while (stream.avail_out == 0) {
        
        memset(buf, 0, KBufLen * sizeof(Byte));
        stream.avail_out = KBufLen;
        stream.next_out = buf;
        
        res = deflate(&stream, Z_FINISH);
        ;
        
        switch (res) {
            case Z_NEED_DICT:
            case Z_DATA_ERROR:
            case Z_MEM_ERROR:
            case Z_STREAM_ERROR:
            case Z_BUF_ERROR: {
                isCompressOK = NO;
                break;
            }
                
            default: {
                if (res == Z_OK || res == Z_STREAM_END) {
                    const int dataLen = KBufLen - stream.avail_out;
                    isCompressOK = YES;
                    
                    if (dataLen > 0) {
                        [compressedData appendBytes:buf length:dataLen];
                    }
                }
                
                break;
            }
        }
        
        if (!isCompressOK) {
            break;
        }
    }
    
    res = deflateEnd(&stream);
    if (res != Z_OK) {
        return nil;
    }
    
    if (isCompressOK) {
        return compressedData;
    } else {
        return nil;
    }
}

+ (NSData *)zlibUncompressData:(NSData *)sourceData {
    
    NSUInteger sourceDataLength = [sourceData length];
    
    if (sourceDataLength == 0) {
        return sourceData;
    }
    
    z_stream stream;
    memset(&stream, 0, sizeof(z_stream));
    
    stream.next_in = (Bytef *)[sourceData bytes];
    stream.avail_in = (uInt)sourceDataLength;
    stream.total_out = 0;
    stream.zalloc = Z_NULL;
    stream.zfree = Z_NULL;
    
    int res = inflateInit(&stream);
    // inflateInit2(&strm, (15+32))
    
    if (res != Z_OK) {
        return nil;
    }
    
    const int KBufLen = 1024;
    Byte buf[KBufLen];
    memset(buf, 0, KBufLen * sizeof(Byte));
    
    BOOL isUncompressOK = NO;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength:sourceDataLength];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    [decompressed setData:nil]; //必须得加
#pragma clang diagnostic pop
    
    
    while (stream.avail_out == 0) {
        
        memset(buf, 0, KBufLen * sizeof(Byte));
        stream.avail_out = KBufLen;
        stream.next_out = buf;
        
        res = inflate(&stream, Z_NO_FLUSH);
        
        switch (res) {
            case Z_NEED_DICT:
            case Z_DATA_ERROR:
            case Z_MEM_ERROR:
            case Z_STREAM_ERROR:
            case Z_BUF_ERROR: {
                isUncompressOK = NO;
                break;
            }
                
            default: {
                if (res == Z_OK || res == Z_STREAM_END) {
                    const int dataLen = KBufLen - stream.avail_out;
                    isUncompressOK = YES;
                    
                    if (dataLen > 0) {
                        [decompressed appendBytes:buf length:dataLen];
                    }
                }
                
                break;
            }
        }
        
        if (!isUncompressOK) {
            break;
        }
    }
    
    if (inflateEnd(&stream) != Z_OK) {
        return nil;
    }
    
    if (isUncompressOK) {
        return decompressed;
    } else {
        return nil;
    }
}


@end
