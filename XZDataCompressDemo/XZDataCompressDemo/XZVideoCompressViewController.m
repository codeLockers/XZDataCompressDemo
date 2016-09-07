//
//  XZVideoCompressViewController.m
//  XZDataCompressDemo
//
//  Created by 徐章 on 16/9/7.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZVideoCompressViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface XZVideoCompressViewController ()
@property (weak, nonatomic) IBOutlet UILabel *originSizeLab;
@property (weak, nonatomic) IBOutlet UILabel *filePathLab;
@property (weak, nonatomic) IBOutlet UILabel *compressSizeLab;
@property (weak, nonatomic) IBOutlet UILabel *compressVideoPathLab;

@end

@implementation XZVideoCompressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
    self.filePathLab.text = path;
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    self.originSizeLab.text = [NSString stringWithFormat:@"%0.2fKB",data.length/1024.0f];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)compressBtn_Pressed:(UIButton *)sender {
    
    [sender setTitle:@"压缩中..." forState:UIControlStateNormal];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"video" withExtension:@"mp4"];
    
    
    //转码配置
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
    AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetLowQuality];
    exportSession.shouldOptimizeForNetworkUse = YES;
    
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [array lastObject];
    path =[path stringByAppendingPathComponent:@"newVideo.mp4"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    
    
    exportSession.outputURL = [NSURL fileURLWithPath:path];
    exportSession.outputFileType = AVFileTypeMPEG4;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        int exportStatus = exportSession.status;
        NSLog(@"%d",exportStatus);
        switch (exportStatus)
        {
            case AVAssetExportSessionStatusFailed:
            {
                // log error to text view
                NSError *exportError = exportSession.error;
                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
                break;
            }
            case AVAssetExportSessionStatusCompleted:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [sender setTitle:@"压缩" forState:UIControlStateNormal];
                    NSData *data = [NSData dataWithContentsOfFile:path];
                    self.compressSizeLab.text = [NSString stringWithFormat:@"%0.2fKB",data.length/1024.0f];
                    self.compressVideoPathLab.text = path;
                });
            }
        }
    }];
}

@end
