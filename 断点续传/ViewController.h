//
//  ViewController.h
//  断点续传
//
//  Created by 码农 on 15/12/31.
//  Copyright © 2015年 码农. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownLoadOperation.h"
@interface ViewController : UIViewController
{
    IBOutlet UIImageView *_imageView;
    IBOutlet UIProgressView *_progress;
    IBOutlet UILabel *textLable;
    DownLoadOperation *_downLoadOperation;
}
-(IBAction)downLoad:(id)sender;
-(IBAction)pause:(id)sender;
-(IBAction)continuebtn:(id)sender;
@end

