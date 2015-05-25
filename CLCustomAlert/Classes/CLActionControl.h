//
//  CLActionControl.h
//  cbountyLib
//
//  Created by Leo Chang on 5/21/15.
//  Copyright (c) 2015 Ceylon Innovation Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlDefine.h"

const static CGFloat CLActionControlHeight = 220.f;

@interface CLActionControl : UIControl

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *targetView;

@property (nonatomic, copy) CLActionHandler actionBlock;

- (id)initWithFrame:(CGRect)frame title:(NSString*)title message:(NSString*)message hintImage:(UIImage*)image;

- (void)showInView:(UIView*)InView;
- (void)dismiss;

@end
