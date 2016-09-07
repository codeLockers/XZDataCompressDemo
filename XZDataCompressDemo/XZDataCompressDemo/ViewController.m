//
//  ViewController.m
//  XZDataCompressDemo
//
//  Created by 徐章 on 16/9/6.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "ViewController.h"
#import "XZZLibHelper.h"
#import "XZGzipHelper.h"
#import "XZImageCompressViewController.h"
#import "XZVideoCompressViewController.h"
#import "XZStringCompressViewController.h"
#import "XZZipCompressViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{

    NSArray *_titleArray;
}
//http://blog.csdn.net/wy_2012/article/details/6304946
//http://ksnowlv.github.io/blog/2014/12/02/zlibyu-gzip-jie-ya-suo-dui-bi/
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _titleArray = @[@"图片压缩",@"视频压缩",@"文字压缩",@"第三方Zip压缩框架"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
        {
            XZImageCompressViewController *imageCompressVc = [[XZImageCompressViewController alloc] initWithNibName:NSStringFromClass([XZImageCompressViewController class]) bundle:[NSBundle mainBundle]];
            imageCompressVc.title = @"图片压缩";
            [self.navigationController pushViewController:imageCompressVc animated:YES];
        }
            break;
        case 1:
        {
            XZVideoCompressViewController *videoCompressVc = [[XZVideoCompressViewController alloc] initWithNibName:NSStringFromClass([XZVideoCompressViewController class]) bundle:[NSBundle mainBundle]];
            videoCompressVc.title = @"视屏压缩";
            [self.navigationController pushViewController:videoCompressVc animated:YES];
        }
            break;
        case 2:
        {
            XZStringCompressViewController *stringCompressVc =[[XZStringCompressViewController alloc] initWithNibName:NSStringFromClass([XZStringCompressViewController class]) bundle:[NSBundle mainBundle]];
            stringCompressVc.title = @"文字压缩";
            [self.navigationController pushViewController:stringCompressVc animated:YES];
        }
            break;
        case 3:
        {
            XZZipCompressViewController *zipCompressVc = [[XZZipCompressViewController alloc] initWithNibName:NSStringFromClass([XZZipCompressViewController class]) bundle:[NSBundle mainBundle]];
            zipCompressVc.title = @"zip压缩";
            [self.navigationController pushViewController:zipCompressVc animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
