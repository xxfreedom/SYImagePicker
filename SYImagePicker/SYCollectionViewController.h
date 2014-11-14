//
//  SYCollectionViewController.h
//  SYImagePicker
//
//  Created by sy on 14-11-14.
//  Copyright (c) 2014年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface SYCollectionViewController : UICollectionViewController
@property (nonatomic,strong)ALAssetsGroup *assetsGroup;
@end
