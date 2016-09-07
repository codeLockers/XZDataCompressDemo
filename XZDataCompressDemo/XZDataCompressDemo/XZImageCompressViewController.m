//
//  XZImageCompressViewController.m
//  XZDataCompressDemo
//
//  Created by 徐章 on 16/9/6.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZImageCompressViewController.h"
#import "UIImage+Category.h"

@interface XZImageCompressViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *compressImageView;
@property (weak, nonatomic) IBOutlet UIImageView *originImageView;
@property (weak, nonatomic) IBOutlet UILabel *originSizeLab;
@property (weak, nonatomic) IBOutlet UILabel *compressSizeLab;
@property (weak, nonatomic) IBOutlet UILabel *zipPathLab;


@property (weak, nonatomic) IBOutlet UITextField *jpgTF;
@property (weak, nonatomic) IBOutlet UITextField *cropWidthTF;
@property (weak, nonatomic) IBOutlet UITextField *cropHeightTF;
@property (weak, nonatomic) IBOutlet UITextField *cropScaleTF;




@end

@implementation XZImageCompressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    //Gesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture_Method)];
    [self.view addGestureRecognizer:tapGesture];
    
    //originSizeLab
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];

    self.originSizeLab.text = [NSString stringWithFormat:@"%0.2fKB",imageData.length/1024.0f];
    
    //jpgTF
    self.jpgTF.delegate = self;
    self.cropWidthTF.delegate = self;
    self.cropHeightTF.delegate = self;
    self.cropScaleTF.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIButton_Action
- (IBAction)jpgCompressBtn_Pressed:(id)sender {
    
    if (self.jpgTF.text.floatValue <0 || self.jpgTF.text.floatValue>1) {
        return;
    }
    
    NSData *data = UIImageJPEGRepresentation(self.originImageView.image, self.jpgTF.text.floatValue);
    self.compressImageView.image = [UIImage imageWithData:data];
    self.compressSizeLab.text = [NSString stringWithFormat:@"%0.2fKB",data.length/1024.0f];
    
}

- (IBAction)cropCompressBtn_Pressed:(id)sender {
    
    if (self.cropWidthTF.text.floatValue <= 0 || self.cropHeightTF.text.floatValue <= 0 || self.cropScaleTF.text.floatValue <= 0) {
        return;
    }
    
    UIImage *image = [self.originImageView.image imageByScalingToSize:CGSizeMake(self.cropWidthTF.text.floatValue, self.cropHeightTF.text.floatValue) scale:self.cropScaleTF.text.floatValue];
    self.compressImageView.image = image;
    self.compressSizeLab.text = [NSString stringWithFormat:@"%0.2fKB",UIImagePNGRepresentation(image).length/1024.0f];
}


- (void)tapGesture_Method{

    [self.jpgTF resignFirstResponder];
    [self.cropHeightTF resignFirstResponder];
    [self.cropWidthTF resignFirstResponder];
    [self.cropScaleTF resignFirstResponder];
}

#pragma mark - UITextField_Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}

@end
