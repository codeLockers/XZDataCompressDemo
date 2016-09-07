//
//  XZZipCompressViewController.m
//  XZDataCompressDemo
//
//  Created by 徐章 on 16/9/7.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZZipCompressViewController.h"
#import <SSZipArchive/SSZipArchive.h>
#import <Godzippa/Godzippa.h>

@interface XZZipCompressViewController ()
@property (weak, nonatomic) IBOutlet UILabel *originSizeLab;
@property (weak, nonatomic) IBOutlet UILabel *ssZipArchiveSizeLab;
@property (weak, nonatomic) IBOutlet UILabel *godzippaSizeLab;

@end

@implementation XZZipCompressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
    NSData *originData = [NSData dataWithContentsOfFile:path];
    self.originSizeLab.text = [NSString stringWithFormat:@"%0.2fKB",originData.length/1024.0f];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)compressBtn_Pressed:(id)sender {
    
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [array lastObject];
    
    //SSZipArchive
    NSString *sszipPath =[path stringByAppendingPathComponent:@"sszip.zip"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:sszipPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:sszipPath error:nil];
    }
    
    [SSZipArchive createZipFileAtPath:sszipPath withFilesAtPaths:@[[[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"]]];
    NSData *sszipData = [[NSData alloc] initWithContentsOfFile:sszipPath];
    self.ssZipArchiveSizeLab.text = [NSString stringWithFormat:@"%0.2fKB",sszipData.length/1024.0f];
    
    //GodZippa
    NSString *godzipPath = [path stringByAppendingPathComponent:@"godzip.zip"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:godzipPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:godzipPath error:nil];
    }
    
    NSError *error;
    [[NSFileManager defaultManager] GZipCompressFile:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"]] writingContentsToFile:[NSURL URLWithString:godzipPath] error:&error];
    if (error) {
        NSLog(@"%@",error.description);
        return;
    }
    NSData *godzipData = [[NSData alloc] initWithContentsOfFile:godzipPath];
    self.godzippaSizeLab.text = [NSString stringWithFormat:@"%0.2fKB",godzipData.length/1024.0f];
}

@end
