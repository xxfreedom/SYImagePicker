//
//  PhotoDetailsViewController.h
//  SYImagePicker
//
//  Created by sy on 14-11-17.
//  Copyright (c) 2014年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface PhotoDetailsViewController : UIViewController
@property (nonatomic,weak)IBOutlet UIImageView *photoDetails;
@property (nonatomic,strong)ALAsset *photoALAsset;
@property (nonatomic,assign)CGRect defaultRect;
@end
