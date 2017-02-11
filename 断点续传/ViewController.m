//
//  ViewController.m
//  断点续传
//
//  Created by 码农 on 15/12/31.
//  Copyright © 2015年 码农. All rights reserved.
//

#import "ViewController.h"
#import "DownLoadOperation.h"
//下载的地址
#define Picture_Url @"http://map.onegreen.net/%E4%B8%AD%E5%9B%BD%E6%94%BF%E5%8C%BA2500.jpg"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(IBAction)downLoad:(id)sender{
    //确定下载文件要存放的目录
    //NSHomeDirectory()获取沙盒目录
    NSString *path=[NSHomeDirectory() stringByAppendingString:@"/Documents/temp0"];
    //初始化类的对象 并分配内存空间
    _downLoadOperation=[[DownLoadOperation alloc]init];
    //开始下载
    //
    [_downLoadOperation downloadWithUrl:Picture_Url cachePath:^NSString *{
        //文件要存放的路径
        NSLog(@"图片文件存放的路径%@",path);
        return path;
        //bytesRead 已读字节数 当前下载的已读字节数
        //totalBytesRead 总已读字节数
        //totalBytesExpectedToRead 要下载的文件大小(字节数)
    } progressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead){
        NSLog(@"正在下载%ld %llu %llu",bytesRead,totalBytesRead,totalBytesExpectedToRead);
        //当前的下载进度
        float progress=(float)totalBytesRead/(float)totalBytesExpectedToRead;
        [_progress setProgress:progress animated:YES];
        textLable.text=[NSString stringWithFormat:@"%.2f",progress];
        //将正在下载的图片显示出来
        UIImage *iamge=[UIImage imageWithData:_downLoadOperation.requestOperation.responseData];
        [_imageView setImage:iamge];
    } success:^(AFHTTPRequestOperation *operation,id responseObject){
        //成功的话
        //将正在下载的图片显示出来
        UIImage *iamge=[UIImage imageWithData:_downLoadOperation.requestOperation.responseData];
        [_imageView setImage:iamge];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        NSLog(@"下载失败error%@",error);
    }];
    
}
-(IBAction)pause:(id)sender{
    [_downLoadOperation.requestOperation pause];
}
-(IBAction)continuebtn:(id)sender{
    [_downLoadOperation.requestOperation resume];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
