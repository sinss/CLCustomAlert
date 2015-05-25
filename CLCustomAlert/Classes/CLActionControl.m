//
//  CLActionControl.m
//  cbountyLib
//
//  Created by Leo Chang on 5/21/15.
//  Copyright (c) 2015 Ceylon Innovation Co., Ltd. All rights reserved.
//

#import "CLActionControl.h"

const static CGFloat startY = 00.f;
const static CGFloat animationDuration = 0.3f;
const static CGFloat secondAnimationDuration = 0.1f;
const static CGFloat animationOffset = 15.f;

@implementation CLActionControl

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
        frame.size.height += animationOffset;
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
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, currentY, CGRectGetWidth(self.frame), 60)];
    titleLabel.backgroundColor = [UIColor blueColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:defaultFontBold size:16];
    titleLabel.text = self.title;
    
    currentY += titleLabel.frame.size.height;
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, currentY, CGRectGetWidth(self.frame), 110)];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.numberOfLines = 2;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:defaultFontLight size:14];
    messageLabel.text = self.message;
    
    currentY += messageLabel.frame.size.height;
    
    //Confirm Button and Cacnel Button
    CGFloat spacing = 5.f;
    CGFloat buttonWidth = (CGRectGetWidth(self.frame) - spacing * 3) / 2;
    CGFloat buttonHeight = 40.f;
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(spacing, currentY, buttonWidth, buttonHeight);
    cancelButton.backgroundColor = [UIColor grayColor];
    cancelButton.layer.cornerRadius = 5.f;
    cancelButton.tag = CLActionCancel;
    [cancelButton setTintColor:[UIColor whiteColor]];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    
    [cancelButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    confirmButton.frame = CGRectMake(spacing * 2+ buttonWidth, currentY, buttonWidth, buttonHeight);
    confirmButton.backgroundColor = [UIColor orangeColor];
    confirmButton.layer.cornerRadius = 5.f;
    confirmButton.tag = CLActionConfirm;
    [confirmButton setTintColor:[UIColor whiteColor]];
    [confirmButton setTitle:@"Confirm" forState:UIControlStateNormal];
    
    [confirmButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    
    [self addSubview:titleLabel];
    [self addSubview:messageLabel];
    [self addSubview:cancelButton];
    [self addSubview:confirmButton];
}

- (void)showInView:(UIView*)InView
{
    self.targetView = InView;
    self.alpha = 0;
    //self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.maskView.alpha = 0;
    [InView addSubview:self.maskView];
    [InView addSubview:self];
    
    [UIView animateWithDuration:animationDuration animations:^{
        
        self.maskView.alpha = 0.5;
        self.frame = CGRectMake(0, CGRectGetHeight(InView.frame) - CLActionControlHeight - animationOffset, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        self.alpha = 1;
    } completion:^(BOOL success){
        
        [UIView animateWithDuration:secondAnimationDuration animations:^{
            
            self.frame = CGRectMake(0, CGRectGetHeight(InView.frame) - CLActionControlHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        } completion:nil];
        
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:secondAnimationDuration animations:^{
        
        self.frame = CGRectMake(0, CGRectGetHeight(self.targetView.frame) - CLActionControlHeight - animationOffset, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    } completion:^(BOOL finish){
        
        [UIView animateWithDuration:animationDuration animations:^{
            
            self.maskView.alpha = 0;
            self.frame = CGRectMake(0, CGRectGetHeight(self.targetView.frame) , CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
            self.alpha = 0;
        } completion:^(BOOL success){
            
            [self.maskView removeFromSuperview];
            [self removeFromSuperview];
        }];
        
    }];
}

- (void)handleTapBehind:(UIGestureRecognizer*)recognize
{
    [self dismiss];
}

- (void)buttonPress:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    CLAction action = btn.tag;
    if (self.actionBlock)
    {
        self.actionBlock (action, sender);
    }
    
    [self dismiss];
}

@end
