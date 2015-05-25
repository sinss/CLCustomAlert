//
//  CLHintControl.m
//  cbountyLib
//
//  Created by Leo Chang on 5/21/15.
//  Copyright (c) 2015 Ceylon Innovation Co., Ltd. All rights reserved.
//

#import "CLHintControl.h"
#import "ControlDefine.h"

const static CGFloat startY = 30.f;
const static CGFloat animationDuration = 0.2f;
const static CGFloat secondAnimationDuration = 0.1f;

@implementation CLHintControl

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

- (id)initWithFrame:(CGRect)frame title:(NSString*)title message:(NSString*)message hintImage:(UIImage*)image
{
    if (self = [super initWithFrame:frame])
    {
        self.frame = frame;
        self.title = title;
        self.message = message;
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
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, currentY, CGRectGetWidth(self.frame), 20)];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:defaultFontLight size:14];
    messageLabel.text = self.message;
    
    currentY += messageLabel.frame.size.height;
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, currentY, CGRectGetWidth(self.frame), CLHintControlHeight - 75)];
    imgv.contentMode = UIViewContentModeScaleAspectFit;
    imgv.image = self.image;
    
    currentY += imgv.frame.size.height;
    
    self.backgroundColor = [UIColor blackColor];
    self.layer.cornerRadius = 5;
    
    [self addSubview:titleLabel];
    [self addSubview:messageLabel];
    [self addSubview:imgv];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapSelf:)];
    [self addGestureRecognizer:gesture];
}

- (void)showInView:(UIView*)InView
{
    self.alpha = 0;
    //self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.maskView.alpha = 0;
    [InView addSubview:self.maskView];
    [InView addSubview:self];
    
    [UIView animateWithDuration:animationDuration animations:^{
        
        self.maskView.alpha = 0.5;
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.alpha = 1;
    } completion:^(BOOL success){
        
        [UIView animateWithDuration:secondAnimationDuration animations:^{
           self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:nil];
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:secondAnimationDuration animations:^{
        
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL success){
        [UIView animateWithDuration:animationDuration animations:^{
            
            self.maskView.alpha = 0;
            self.transform = CGAffineTransformMakeScale(0.1, 0.1);
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

- (void)handleTapBehind:(UIGestureRecognizer*)recognize
{
    [self dismiss];
}

- (void)handleTapSelf:(UIGestureRecognizer*)recognize
{
    [self jump];
}

@end
