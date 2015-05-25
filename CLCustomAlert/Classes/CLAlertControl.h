//
//  CLAlertControl.h
//  cbountyLib
//
//  Created by Leo Chang on 5/21/15.
//  Copyright (c) 2015 Ceylon Innovation Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  kCLAlertControlWidth (CGRectGetWidth([UIScreen mainScreen].bounds) - 40)
const static CGFloat CLAlertControlHeight = 280.f;

@interface CLAlertControl : UIControl

@property (assign) CGFloat finalHeight;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *targetName;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *targetView;
@property (nonatomic, assign) CGPoint beginDragingPosition;

- (id)initWithFrame:(CGRect)frame title:(NSString*)title message:(NSString*)message targetName:(NSString*)targetName image:(UIImage*)image;

- (void)showInView:(UIView*)InView;
- (void)dismiss;

@end
