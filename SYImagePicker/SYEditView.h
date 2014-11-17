//
//  SYEditView.h
//  SYImagePicker
//
//  Created by sy on 14-11-17.
//  Copyright (c) 2014年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYEditView : UIView
{
    UIView *_rectView;
    CGRect _defaultRect;
    UIPinchGestureRecognizer *_pin;
    UIPanGestureRecognizer *_pan;
    CGFloat _lastScale;
}
@property (nonatomic,assign)Rect editRect;
-(instancetype)initWithFrame:(CGRect)frame WithDefaultRect:(CGRect)defaultRect;
@end
