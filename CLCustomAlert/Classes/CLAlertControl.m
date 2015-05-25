//
//  CLAlertControl.m
//  cbountyLib
//
//  Created by Leo Chang on 5/21/15.
//  Copyright (c) 2015 Ceylon Innovation Co., Ltd. All rights reserved.
//

#import "CLAlertControl.h"
#import "ControlDefine.h"

const static CGFloat startY = 20.f;
const static CGFloat animationDuration = 0.3f;
const static CGFloat secondAnimationDuration = 0.1f;
const static CGFloat animationOffset = 15.f;

@implementation CLAlertControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView*)maskView
{
    if (!_maskView)
    {
        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBehind:)];
        
        [_maskView addGestureRecognizer:gesture];
    }
    
    return _maskView;
}

- (void)setupLayer
{
    self.backgroundColor = [UIColor grayColor];
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 3.f;
    
    //shadow
    CALayer *layer = self.layer;
    layer.shadowOffset = CGSizeMake(0, 3);
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowOpacity = 10.00f;
    layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
    layer.masksToBounds = NO;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:layer.bounds];
    layer.shadowPath = path.CGPath;
}

- (void)setupGesture
{
    //add UIPanGesture
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [self addGestureRecognizer:panRecognizer];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapSelf:)];
    [self addGestureRecognizer:gesture];
}

- (id)initWithFrame:(CGRect)frame title:(NSString*)title message:(NSString*)message targetName:(NSString*)targetName image:(UIImage*)image;
{
    if (self = [super initWithFrame:frame])
    {
        self.finalHeight = CGRectGetHeight(frame);
        self.frame = frame;
        self.title = title;
        self.message = message;
        self.targetName = targetName;
        self.image = image;
        
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    CGFloat currentY = startY;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, currentY, CGRectGetWidth(self.frame), 25)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:defaultFontBold size:16];
    titleLabel.text = self.title;
    
    currentY += titleLabel.frame.size.height;
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, currentY, CGRectGetWidth(self.frame), 100)];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.numberOfLines = 2;
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:defaultFontLight size:14];
    messageLabel.text = [NSString stringWithFormat:self.message, self.targetName];
    
    currentY += messageLabel.frame.size.height;
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(3, currentY, CGRectGetWidth(self.frame) - 6, self.finalHeight - 145)];
    imgv.contentMode = UIViewContentModeScaleToFill;
    imgv.image = self.image;
    
    currentY += imgv.frame.size.height;
    
    [self setupLayer];
    [self setupGesture];
    
    [self addSubview:titleLabel];
    [self addSubview:messageLabel];
    [self addSubview:imgv];
}

- (void)showInView:(UIView*)InView
{
    self.targetView = InView;
    self.alpha = 0;
    //self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.maskView.alpha = 0;
    [InView addSubview:self.maskView];
    [InView addSubview:self];
    self.frame = CGRectMake(InView.center.x - CGRectGetWidth(self.frame) / 2, -self.finalHeight, CGRectGetWidth(self.frame), self.finalHeight);
    [UIView animateWithDuration:animationDuration animations:^{
        
        self.maskView.alpha = 0.5;
        self.frame = CGRectMake(InView.center.x - CGRectGetWidth(self.frame) / 2, InView.center.y - CGRectGetHeight(self.frame) / 2 + animationOffset, CGRectGetWidth(self.frame), self.finalHeight);
        self.alpha = 1;
    } completion:^(BOOL success){
        
        [UIView animateWithDuration:secondAnimationDuration animations:^{
            
            self.frame = CGRectMake(InView.center.x - CGRectGetWidth(self.frame) / 2, InView.center.y - CGRectGetHeight(self.frame) / 2, CGRectGetWidth(self.frame), self.finalHeight);
        } completion:nil];
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:secondAnimationDuration animations:^{
        
        self.frame = CGRectMake(self.targetView.center.x - CGRectGetWidth(self.frame) / 2, self.targetView.center.y - CGRectGetHeight(self.frame) / 2 + animationOffset, CGRectGetWidth(self.frame), self.finalHeight);
    } completion:^(BOOL success){
        
        [UIView animateWithDuration:animationDuration animations:^{
            
            self.maskView.alpha = 0;
            self.frame = CGRectMake(self.targetView.center.x - CGRectGetWidth(self.frame) / 2, -self.finalHeight, CGRectGetWidth(self.frame), self.finalHeight);
            self.alpha = 0;
        } completion:^(BOOL success){
            
            [self.maskView removeFromSuperview];
            [self removeFromSuperview];
        }];
    }];
}

- (void)jump
{
    [UIView animateWithDuration:secondAnimationDuration animations:^{
        
        self.transform = CGAffineTransformMakeScale(1.05, 1.05);
    } completion:^(BOOL success){
        [UIView animateWithDuration:animationDuration animations:^{
            
            self.transform = CGAffineTransformMakeScale(1, 1);
        } completion:nil];
    }];
}

- (void)moveBackWithAnimationOffset:(CGFloat)offset
{
    /*
     計算需要動畫的時間系數，並且最小為0.1sec，讓動畫更順暢
     */
    CGFloat ratio = offset / (self.targetView.center.y - CGRectGetHeight(self.frame) / 2);
    [UIView animateWithDuration:MAX(animationDuration * ratio, secondAnimationDuration) animations:^{
        
        self.maskView.alpha = 0.5;
        self.frame = CGRectMake(self.targetView.center.x - CGRectGetWidth(self.frame) / 2, self.targetView.center.y - CGRectGetHeight(self.frame) / 2 - animationOffset, CGRectGetWidth(self.frame), self.finalHeight);
        self.alpha = 1;
    } completion:^(BOOL success){
        
        [UIView animateWithDuration:MAX(secondAnimationDuration * ratio, secondAnimationDuration) animations:^{
            
            self.frame = CGRectMake(self.targetView.center.x - CGRectGetWidth(self.frame) / 2, self.targetView.center.y - CGRectGetHeight(self.frame) / 2, CGRectGetWidth(self.frame), self.finalHeight);
        } completion:nil];
    }];
}

- (void)handleTapBehind:(UIGestureRecognizer*)recognize
{
    [self dismiss];
}

- (void)handleTapSelf:(UIGestureRecognizer*)recognize
{
    [self jump];
}

- (void)move:(UIPanGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan)
    {
        self.beginDragingPosition = gestureRecognizer.view.center;
        
    }
    CGPoint translation = [gestureRecognizer translationInView:self];
    
    
    CGPoint translatedCenter = CGPointMake([self center].x, [self center].y + translation.y);
    [self setCenter:translatedCenter];
    [gestureRecognizer setTranslation:CGPointZero inView:self];
    
    if(translation.y < 0)
    {
        
    }
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateEnded)
    {
        NSLog(@" height--> %f y--> %f ", [UIScreen mainScreen].bounds.size.height , self.frame.origin.y);
        if(gestureRecognizer.view.center.y < self.beginDragingPosition.y)
        {
            [UIView animateWithDuration:animationDuration animations:^{
                
                self.maskView.alpha = 0;
                self.frame = CGRectMake(self.targetView.center.x - CGRectGetWidth(self.frame) / 2, -self.finalHeight, CGRectGetWidth(self.frame), self.finalHeight);
                self.alpha = 0;
            } completion:^(BOOL success){
                
                [self.maskView removeFromSuperview];
                [self removeFromSuperview];
            }];
        }
        else
        {
            [self moveBackWithAnimationOffset:(gestureRecognizer.view.center.y - self.beginDragingPosition.y)];
        }
    }
}

@end
