//
//  SYImagePickerViewController.h
//  SYImagePicker
//
//  Created by sy on 14-11-14.
//  Copyright (c) 2014年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYImagePickerViewController;
@protocol SYImagePickerDelegate <NSObject>
- (void)syImagePickerController:(SYImagePickerViewController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo;
- (void)syImagePickerControllerDidCancel:(SYImagePickerViewController *)picker;
@end
@interface SYImagePickerViewController : UIViewController
@property (nonatomic,assign)UIImagePickerControllerSourceType sourceType;
@property (nonatomic,weak)id<SYImagePickerDelegate> delegate;
@end
