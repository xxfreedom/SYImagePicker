//
//  SYCollectionViewController.m
//  SYImagePicker
//
//  Created by sy on 14-11-14.
//  Copyright (c) 2014年 SY. All rights reserved.
//

#import "SYCollectionViewController.h"
#import "SYCollectionViewCell.h"
#import "PhotoDetailsViewController.h"
@interface SYCollectionViewController ()

@property(strong,nonatomic)NSMutableArray *photos;
@end

@implementation SYCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
     self.clearsSelectionOnViewWillAppear = NO;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    _photos=[[NSMutableArray alloc]init];
    if(_assetsGroup)
    {
        [self getPhotos];
    }else
    {
        NSLog(@"group 为空");
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getPhotos
{
    __weak typeof(self)wself=self;
    [_assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result)
        {
            [wself.photos addObject:result];
        }else
        {
            [wself.collectionView reloadData];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ALAsset *asset=_photos[indexPath.row];
    [cell.imageContemt setImage:[UIImage imageWithCGImage:asset.thumbnail]];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>


// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}



// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoDetailsViewController*photoDetails=[[PhotoDetailsViewController alloc]initWithNibName:@"PhotoDetailsViewController" bundle:nil];
    photoDetails.photoALAsset=_photos[indexPath.row];
    photoDetails.defaultRect=CGRectMake(0, 0, 100, 100);
    
    [self.navigationController pushViewController:photoDetails animated:YES];
}
//- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
//	
//}


@end
