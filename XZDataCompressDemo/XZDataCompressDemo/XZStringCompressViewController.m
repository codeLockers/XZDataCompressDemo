//
//  XZStringCompressViewController.m
//  XZDataCompressDemo
//
//  Created by 徐章 on 16/9/7.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZStringCompressViewController.h"
#import "XZZlibHelper.h"
#import "XZGzipHelper.h"
#import <Godzippa/Godzippa.h>

@interface XZStringCompressViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *zlibSizeLab;
@property (weak, nonatomic) IBOutlet UILabel *gzipSizeLab;
@property (weak, nonatomic) IBOutlet UILabel *godzippaSizeLab;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *originSizeLab;

@end

@implementation XZStringCompressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate =self;
    //Gesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture_Method)];
    [self.view addGestureRecognizer:tapGesture];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)compressBtn_Pressed:(id)sender {
    
    NSString* hello = self.textView.text;
    NSData *helloData = [NSData dataWithBytes:hello.UTF8String length:[hello lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    self.originSizeLab.text = [NSString stringWithFormat:@"%ld字节",(long)helloData.length];

    NSData *zlibcompressData = [XZZlibHelper zlibCompressData:helloData];
    self.zlibSizeLab.text = [NSString stringWithFormat:@"%ld字节",(long)zlibcompressData.length];

    NSData *gzipCompressData = [XZGzipHelper gzipCompress:helloData];
    self.gzipSizeLab.text = [NSString stringWithFormat:@"%ld字节",(long)gzipCompressData.length];

    NSData *godzippaCompressedData = [helloData dataByGZipCompressingWithError:nil];
    self.godzippaSizeLab.text = [NSString stringWithFormat:@"%ld字节",(long)godzippaCompressedData.length];
    
}
- (void)tapGesture_Method{
    
    [self.textView resignFirstResponder];
}

@end
