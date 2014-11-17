//
//  SYEditView.m
//  SYImagePicker
//
//  Created by sy on 14-11-17.
//  Copyright (c) 2014年 SY. All rights reserved.
//

#import "SYEditView.h"
typedef NS_ENUM(NSInteger, EditType) {
    EditTypePinUp = 0,
    EditTypePinDown,
    EditTypePinLeft,
    EditTypePinRight,
    EditTypePinPoint,
    EditTypePan,
    EditTypeNone,
};
#define PanArc 10
@implementation SYEditView

-(instancetype)initWithFrame:(CGRect)frame WithDefaultRect:(CGRect)defaultRect
{
    self=[super initWithFrame:frame];
    
    if(self)
    {
        _defaultRect=defaultRect;;
        CGRect rect=CGRectMake(([UIScreen mainScreen].bounds.size.width-defaultRect.size.width)/2, ([UIScreen mainScreen].bounds.size.height-defaultRect.size.height)/2, defaultRect.size.width, defaultRect.size.height);
        _rectView=[[UIView alloc]initWithFrame:rect];
        [_rectView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_rectView];
        
        _pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pangesture:)];
        _pan.minimumNumberOfTouches=1;
        [_rectView addGestureRecognizer:_pan];
        
        _pin=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pingetsure:)];
        [self addGestureRecognizer:_pin];
        _lastScale=1.0;
        
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    }
    return self;
}

-(void)pangesture:(UIPanGestureRecognizer *)gesture
{
    CGPoint point = [gesture translationInView:self];
    
    gesture.view.center = CGPointMake(gesture.view.center.x + point.x, gesture.view.center.y + point.y);
    [gesture setTranslation:CGPointMake(0, 0) inView:self];
    [self setNeedsDisplay];
    NSLog(@"editFrame:%@",NSStringFromCGRect(_rectView.frame));
}
-(void)pingetsure:(UIPinchGestureRecognizer *)gesture
{
    
    if([gesture state] == UIGestureRecognizerStateEnded) {
        _lastScale = 1.0;
        return;
    }
    CGFloat scale = 1.0 - (_lastScale - [gesture scale]);
    if(scale<1.0&&_rectView.frame.size.width<_defaultRect.size.width)
        return;
    CGAffineTransform currentTransform = _rectView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);
    [_rectView setTransform:newTransform];
    [self setNeedsDisplay];
    _lastScale = [gesture scale];
}
-(EditType)editActionFromPoint:(CGPoint)point
{
    
    EditType type;
    CGPoint a,b,c,d;
    a=CGPointMake(_rectView.frame.origin.x, _rectView.frame.origin.y);
    b=CGPointMake(_rectView.frame.origin.x+_rectView.frame.size.width, _rectView.frame.origin.y);
    c=CGPointMake(_rectView.frame.origin.x, _rectView.frame.origin.y+_rectView.frame.size.height);
    d=CGPointMake(_rectView.frame.origin.x+_rectView.frame.size.width,  _rectView.frame.origin.y+_rectView.frame.size.height);
    CGFloat width=_rectView.frame.size.width;
    CGFloat height=_rectView.frame.size.height;
    
    CGFloat x=point.x;
    CGFloat y=point.y;


    return type;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 0, 0,1);//线条颜色
    CGContextSetLineWidth(context,1.0);
    CGContextAddRect(context, CGRectMake(_rectView.frame.origin.x-1,_rectView.frame.origin.y-1,_rectView.frame.size.width+2,_rectView.frame.size.height+2));
    CGContextSetRGBStrokeColor(context, 1,1,1,1);//线条颜色
    CGContextSetLineWidth(context,0.5);
    CGContextAddRect(context, CGRectMake(_rectView.frame.origin.x-1.5,_rectView.frame.origin.y-1.5,_rectView.frame.size.width+3,_rectView.frame.size.height+3));
    CGContextAddRect(context, CGRectMake(_rectView.frame.origin.x-0.5,_rectView.frame.origin.y-0.5,_rectView.frame.size.width+1,_rectView.frame.size.height+1));
    CGContextStrokePath(context);
}
-(void)dealloc
{
    [_rectView removeGestureRecognizer:_pan];
    [self removeGestureRecognizer:_pin];
}
@end
