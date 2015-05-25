//
//  CLHintControl.h
//  cbountyLib
//
//  Created by Leo Chang on 5/21/15.
//  Copyright (c) 2015 Ceylon Innovation Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  kCLHintControlWidth (CGRectGetWidth([UIScreen mainScreen].bounds) - 100)
const static CGFloat CLHintControlHeight = 230.f;

@interface CLHintControl : UIControl

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIView *maskView;

- (id)initWithFrame:(CGRect)frame title:(NSString*)title message:(NSString*)message hintImage:(UIImage*)image;

- (void)showInView:(UIView*)InView;
- (void)dismiss;

@end
