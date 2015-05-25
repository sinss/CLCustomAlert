//
//  CLActionAlertControl.h
//  cbountyLib
//
//  Created by Leo Chang on 5/21/15.
//  Copyright (c) 2015 Ceylon Innovation Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlDefine.h"

#define  kCLActionAlertControlWidth (CGRectGetWidth([UIScreen mainScreen].bounds) - 40)
const static CGFloat CLExchangeActionAlertControlHeight = 280.f;
const static CGFloat CLInviteActionAlertHeight = 335.f;
const static CGFloat CLUpdateActionAlertHeight = 210.f;
const static CGFloat CLRewardPointsAlertHeight = 250.f;
const static CGFloat CLInputAlertHeight = 250.f;

@interface CLActionAlertControl : UIControl <UITextFieldDelegate>

@property (assign) CGFloat finalHeight;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *hint;
@property (nonatomic, strong) NSString *inviteCode;
@property (nonatomic, strong) NSNumber *points;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, strong) UIImage *cpImage;

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *targetView;
@property (nonatomic, assign) CGPoint beginDragingPosition;

@property (nonatomic, strong) UITextField *reservedField;

@property (nonatomic, copy) CLActionHandler actionBlock;

- (id)initExchangeWithFrame:(CGRect)frame title:(NSString*)title message:(NSString*)message image:(UIImage*)image;
- (id)initUpdateWithFrame:(CGRect)frame title:(NSString*)title message:(NSString*)message image:(UIImage*)image;
- (id)initInviteRewardWithFrame:(CGRect)frame title:(NSString*)title message:(NSString*)message points:(NSNumber*)points image:(UIImage*)image;
- (id)initInviteWithFrame:(CGRect)frame title:(NSString*)title inviteHint:(NSString*)hint inviteCode:(NSString*)code image:(UIImage*)image shareImage:(UIImage*)shareImage copyImage:(UIImage*)copyImage;
- (id)initInputActionWithFrame:(CGRect)frame title:(NSString*)title hint:(NSString*)hint  image:(UIImage*)image;


- (void)showInView:(UIView*)InView;
- (void)dismiss;

@end
