//
//  ViewController.h
//  SYImagePicker
//
//  Created by sy on 14-11-14.
//  Copyright (c) 2014年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic,weak)IBOutlet UIImageView *selectImageView;
-(IBAction)showImagePicker:(id)sender;
@end

