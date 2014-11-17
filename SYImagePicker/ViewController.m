//
//  ViewController.m
//  SYImagePicker
//
//  Created by sy on 14-11-14.
//  Copyright (c) 2014年 SY. All rights reserved.
//

#import "ViewController.h"
#import "SYImagePickerViewController.h"
#import "SYNavigationController.h"
@interface ViewController ()<UIActionSheetDelegate,SYImagePickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showImagePicker:(id)sender
{
    
    UIActionSheet *sheet=({
        sheet=[[UIActionSheet alloc]initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册中选取" otherButtonTitles:@"照相", nil];
    });
    [sheet showInView:self.view];
}
#pragma mark ---UIActionSheetDelegate----
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==actionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }else if(buttonIndex==actionSheet.destructiveButtonIndex)
    {
        
        SYImagePickerViewController *picker=[[SYImagePickerViewController alloc]init];
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate=self;
        SYNavigationController *nav=[[SYNavigationController alloc]initWithRootViewController:picker];
        [self presentViewController:nav animated:YES completion:^{
            ;
        }];
    }else
    {
        
    }
}

-(void)syImagePickerController:(SYImagePickerViewController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
}
-(void)syImagePickerControllerDidCancel:(SYImagePickerViewController *)picker
{
    
}
@end
