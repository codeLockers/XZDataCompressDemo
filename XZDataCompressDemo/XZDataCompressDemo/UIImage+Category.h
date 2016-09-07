//
//  UIImage+Category.h
//  XZDataCompressDemo
//
//  Created by 徐章 on 16/9/6.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

- (UIImage *)imageScaletoProportion:(CGFloat)proportion;
/**
 *  保持图片比例,短边＝targerSize,另外一边可能超出
 *
 *  @param targetSize 目标尺寸
 *
 *  @return New Image
 */
- (UIImage *)imageByScalingAspectToMinSize:(CGSize)targetSize;
/**
 *  保持图片比例,长边＝targerSize,另外一边可能小于targetSize
 *
 *  @param targetSize 目标尺寸
 *
 *  @return New Image
 */
- (UIImage *)imageByScalingAspectToMaxSize:(CGSize)targetSize;

/**
 *  图片不保持比例缩放
 *
 *  @param targetSize 目标size
 *
 *  @return UIImage
 */
- (UIImage *)imageByScalingToSize:(CGSize)targetSize scale:(CGFloat)scale;

@end
