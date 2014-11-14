//
//  SYImagePickerViewController.m
//  SYImagePicker
//
//  Created by sy on 14-11-14.
//  Copyright (c) 2014年 SY. All rights reserved.
//

#import "SYImagePickerViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
@interface SYImagePickerViewController ()<UITableViewDataSource,UITableViewDelegate>
{

    ALAssetsLibrary *_assetsLibrary;
    
}
@property(strong,nonatomic)UITableView *photoTbaleView;
@property(strong,nonatomic)NSMutableArray *photoDataSource;
@end

@implementation SYImagePickerViewController

-(instancetype)init
{
    self=[super init];
    if(self)
    {
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    }
    return self;
}
-(IBAction)back:(id)sender
{
    @try {
        if(self.navigationController!=nil&&[self.navigationController.viewControllers indexOfObject:self]==0)
        {
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _photoTbaleView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _photoTbaleView.delegate=self;
    _photoTbaleView.dataSource=self;
    _photoTbaleView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_photoTbaleView];
    _photoDataSource=[[NSMutableArray alloc]init];
    _sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    _assetsLibrary=[[ALAssetsLibrary alloc]init];
    
    switch (_sourceType) {
        case UIImagePickerControllerSourceTypePhotoLibrary:
        case UIImagePickerControllerSourceTypeSavedPhotosAlbum:
        {
            [self loadAssetsGroups];
        }
            break;
        case UIImagePickerControllerSourceTypeCamera:
        {
            
        }
            break;
        default:
            NSLog(@"请选择picker 类型");
            assert(nil);
            break;
    }    // Do any additional setup after loading the view from its nib.
}
#pragma mark ---UICollectionViewDelegate----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _photoDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil)
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    ALAssetsGroup *group=_photoDataSource[indexPath.row];
    cell.textLabel.text=[group valueForProperty:ALAssetsGroupPropertyName];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%d",[group numberOfAssets]];
    [cell.imageView setImage:[UIImage imageWithCGImage:group.posterImage]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)loadAssetsGroups
{
    [_photoDataSource removeAllObjects];
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == AVAuthorizationStatusDenied)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"没有访问相册的权限" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        __weak typeof(self)wself=self;
        [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if(group)
            {
                [wself.photoDataSource addObject:group];
            }
            if(group==nil)
                [wself.photoTbaleView reloadData];
        } failureBlock:^(NSError *error) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"获取相册失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }];
        
    }
}
-(BOOL)getMediaIsPermissionFromSource:(UIImagePickerControllerSourceType)sourceType
{
    if (sourceType==UIImagePickerControllerSourceTypeCamera)
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusDenied)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == AVAuthorizationStatusDenied)
        {
            return NO;
        }
        else
        {
            return YES;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
