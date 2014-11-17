//
//  PhotoDetailsViewController.m
//  SYImagePicker
//
//  Created by sy on 14-11-17.
//  Copyright (c) 2014年 SY. All rights reserved.
//

#import "PhotoDetailsViewController.h"
#import "SYEditView.h"
static NSString *notification_imageEdit=@"notification_imageEdit";
@interface PhotoDetailsViewController ()
{
   

}
@property (nonatomic,strong) SYEditView *editView;
@end

@implementation PhotoDetailsViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishEdit)];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [_photoDetails setContentMode:UIViewContentModeScaleAspectFit];
    [_photoDetails setBackgroundColor:[UIColor blackColor]];
    
    CGRect rect=CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    _editView=[[SYEditView alloc]initWithFrame:rect WithDefaultRect:_defaultRect];
    [self.view addSubview:_editView];
    

    
    if(_photoALAsset)
    {
        [_photoDetails setImage:[UIImage imageWithCGImage:_photoALAsset.defaultRepresentation.fullScreenImage]];
    }
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   
}


-(void)finishEdit
{
    UIImage *editImage;
    CGRect editRect=_editView.frame;
    
    NSMutableDictionary *userinfo=[[NSMutableDictionary alloc]init];
    [userinfo setObject:_photoALAsset.defaultRepresentation forKey:@"Representation"];
    [userinfo setObject:editImage forKey:@"editImage"];
    [[NSNotificationCenter defaultCenter] postNotificationName:notification_imageEdit object:nil userInfo:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{

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
