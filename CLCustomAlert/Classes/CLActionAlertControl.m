//
//  CLActionAlertControl.m
//  cbountyLib
//
//  Created by Leo Chang on 5/21/15.
//  Copyright (c) 2015 Ceylon Innovation Co., Ltd. All rights reserved.
//

#import "CLActionAlertControl.h"
#import "CLTextField.h"

const static CGFloat startY = 20.f;
const static CGFloat animationDuration = 0.3f;
const static CGFloat secondAnimationDuration = 0.1f;
const static CGFloat animationOffset = 15.f;

@implementation CLActionAlertControl

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

#pragma mark - 兌換UI
- (id)initExchangeWithFrame:(CGRect)frame title:(NSString*)title message:(NSString*)message image:(UIImage*)image
{
    if (self = [super initWithFrame:frame])
    {
        self.finalHeight = CGRectGetHeight(frame);
        
        self.frame = frame;
        self.title = title;
        self.message = message;
        self.image = image;
        
        [self initializeExchangeUI];
    }
    return self;
}

- (void)initializeExchangeUI
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
    messageLabel.text = self.message;
    
    currentY += messageLabel.frame.size.height;
    
    
    CGFloat spacing = 10.f;
    CGFloat buttonWidth = (CGRectGetWidth(self.frame) - spacing * 3) / 2;
    CGFloat buttonHeight = 40.f;
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(spacing, currentY, buttonWidth, buttonHeight);
    cancelButton.backgroundColor = [UIColor grayColor];
    cancelButton.layer.cornerRadius = 5.f;
    cancelButton.tag = CLActionCancel;
    [cancelButton setTintColor:[UIColor whiteColor]];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancelButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *earnButton = [UIButton buttonWithType:UIButtonTypeSystem];
    earnButton.frame = CGRectMake(spacing * 2+ buttonWidth, currentY, buttonWidth, buttonHeight);
    earnButton.backgroundColor = [UIColor orangeColor];
    earnButton.layer.cornerRadius = 5.f;
    earnButton.tag = CLActionEarnPoints;
    [earnButton setTintColor:[UIColor whiteColor]];
    [earnButton setTitle:@"賺點數" forState:UIControlStateNormal];
    
    [earnButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    currentY += 50;
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(3, currentY, CGRectGetWidth(self.frame) - 6, self.finalHeight - 195)];
    imgv.contentMode = UIViewContentModeScaleToFill;
    imgv.image = self.image;
    
    currentY += imgv.frame.size.height;
    
    [self setupLayer];
    [self setupGesture];
    
    [self addSubview:titleLabel];
    [self addSubview:messageLabel];
    [self addSubview:imgv];
    [self addSubview:cancelButton];
    [self addSubview:earnButton];
}

#pragma mark - 更新
- (id)initUpdateWithFrame:(CGRect)frame title:(NSString*)title message:(NSString*)message image:(UIImage*)image
{
    if (self = [super initWithFrame:frame])
    {
        self.finalHeight = CGRectGetHeight(frame);
        
        self.frame = frame;
        self.title = title;
        self.message = message;
        self.image = image;
        
        [self initializeUpdateUI];
    }
    return self;
}

- (void)initializeUpdateUI
{
    CGFloat currentY = startY;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, currentY, CGRectGetWidth(self.frame), 25)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:defaultFontBold size:16];
    titleLabel.text = self.title;
    
    currentY += titleLabel.frame.size.height;
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, currentY, CGRectGetWidth(self.frame), 60)];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.numberOfLines = 2;
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:defaultFontLight size:14];
    messageLabel.text = self.message;
    
    currentY += messageLabel.frame.size.height;
    
    
    CGFloat spacing = 10.f;
    CGFloat buttonWidth = (CGRectGetWidth(self.frame) - spacing * 3) / 2;
    CGFloat buttonHeight = 40.f;
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.frame = CGRectMake(spacing, currentY, buttonWidth, buttonHeight);
    cancelButton.backgroundColor = [UIColor grayColor];
    cancelButton.layer.cornerRadius = 5.f;
    cancelButton.tag = CLActionCancel;
    [cancelButton setTintColor:[UIColor whiteColor]];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancelButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *earnButton = [UIButton buttonWithType:UIButtonTypeSystem];
    earnButton.frame = CGRectMake(spacing * 2+ buttonWidth, currentY, buttonWidth, buttonHeight);
    earnButton.backgroundColor = [UIColor orangeColor];
    earnButton.layer.cornerRadius = 5.f;
    earnButton.tag = CLActionUpdate;
    [earnButton setTintColor:[UIColor whiteColor]];
    [earnButton setTitle:@"更新" forState:UIControlStateNormal];
    
    [earnButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    currentY += 50;
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(3, currentY, CGRectGetWidth(self.frame) - 6, self.finalHeight - 155)];
    imgv.contentMode = UIViewContentModeScaleToFill;
    imgv.image = self.image;
    
    currentY += imgv.frame.size.height;
    
    [self setupLayer];
    [self setupGesture];
    
    [self addSubview:titleLabel];
    [self addSubview:messageLabel];
    [self addSubview:imgv];
    [self addSubview:cancelButton];
    [self addSubview:earnButton];
}

#pragma mark - Reward UI

- (id)initInviteRewardWithFrame:(CGRect)frame title:(NSString*)title message:(NSString*)message points:(NSNumber*)points image:(UIImage*)image
{
    if (self = [super initWithFrame:frame])
    {
        self.finalHeight = CGRectGetHeight(frame);
        
        self.frame = frame;
        self.title = title;
        self.message = message;
        self.points = points;
        self.image = image;
        
        [self initializeRewardUI];
    }
    return self;
}

- (void)initializeRewardUI
{
    CGFloat currentY = startY + 30;
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(3, 0, CGRectGetWidth(self.frame) - 6, 130)];
    imgv.contentMode = UIViewContentModeScaleToFill;
    imgv.alpha = 0.3;
    imgv.image = self.image;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, currentY, CGRectGetWidth(self.frame), 35)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:defaultFontLight size:15];
    titleLabel.text = self.title;
    
    currentY += titleLabel.frame.size.height;
    
    UILabel *pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, currentY, CGRectGetWidth(self.frame), 50)];
    pointLabel.backgroundColor = [UIColor clearColor];
    pointLabel.textColor = [UIColor orangeColor];
    pointLabel.textAlignment = NSTextAlignmentCenter;
    pointLabel.font = [UIFont fontWithName:defaultFontCondensedBold size:25];
    pointLabel.text = [NSString stringWithFormat:@"%@ 點", self.points];
    
    currentY = imgv.frame.size.height;
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, currentY, CGRectGetWidth(self.frame), 32)];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.numberOfLines = 1;
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:defaultFontLight size:15];
    messageLabel.text = self.message;
    
    currentY += messageLabel.frame.size.height;
    
    CGFloat spacing = 10.f;
    CGFloat buttonWidth = (CGRectGetWidth(self.frame) - spacing * 3) / 2;
    CGFloat buttonHeight = 40.f;
    
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    copyButton.frame = CGRectMake(spacing, currentY, buttonWidth, buttonHeight);
    copyButton.backgroundColor = [UIColor blueColor];
    copyButton.layer.cornerRadius = 5.f;
    copyButton.tag = CLActionTakeALook;
    [copyButton setTintColor:[UIColor whiteColor]];
    [copyButton setImage:self.cpImage forState:UIControlStateNormal];
    [copyButton setTitle:@"逛逛去" forState:UIControlStateNormal];
    
    [copyButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    shareButton.frame = CGRectMake(spacing * 2+ buttonWidth, currentY, buttonWidth, buttonHeight);
    shareButton.backgroundColor = [UIColor orangeColor];
    shareButton.layer.cornerRadius = 5.f;
    shareButton.tag = CLActionInvite;
    [shareButton setTintColor:[UIColor whiteColor]];
    [shareButton setImage:self.shareImage forState:UIControlStateNormal];
    [shareButton setTitle:@"邀請朋友" forState:UIControlStateNormal];
    
    [shareButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    currentY += 50;
    
    currentY += imgv.frame.size.height;
    
    [self setupLayer];
    [self setupGesture];
    
    [self addSubview:titleLabel];
    [self addSubview:pointLabel];
    [self addSubview:imgv];
    [self addSubview:messageLabel];
    [self addSubview:copyButton];
    [self addSubview:shareButton];
}

#pragma mark - 邀請朋友
- (id)initInviteWithFrame:(CGRect)frame title:(NSString*)title inviteHint:(NSString*)hint inviteCode:(NSString *)code image:(UIImage *)image shareImage:(UIImage *)shareImage copyImage:(UIImage *)copyImage
{
    if (self = [super initWithFrame:frame])
    {
        self.finalHeight = CGRectGetHeight(frame);
        
        self.frame = frame;
        self.title = title;
        self.hint = hint;
        self.inviteCode = code;
        self.image = image;
        self.shareImage = shareImage;
        self.cpImage = copyImage;
        
        [self initializeInviteUI];
    }
    return self;
}

- (void)initializeInviteUI
{
    CGFloat currentY = startY;
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(3, 0, CGRectGetWidth(self.frame) - 6, 200)];
    imgv.contentMode = UIViewContentModeScaleToFill;
    imgv.alpha = 0.3;
    imgv.image = self.image;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, currentY, CGRectGetWidth(self.frame)- 20, 150)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.layer.cornerRadius = 5;
    titleLabel.font = [UIFont fontWithName:defaultFontLight size:15];
    titleLabel.text = self.title;
    titleLabel.clipsToBounds = YES;
    
    currentY = imgv.frame.size.height;
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, currentY, CGRectGetWidth(self.frame), 32)];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.numberOfLines = 1;
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:defaultFontLight size:15];
    messageLabel.text = self.hint;
    
    currentY += messageLabel.frame.size.height;
    
    UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, currentY, CGRectGetWidth(self.frame) - 20, 40)];
    codeLabel.backgroundColor = [UIColor whiteColor];
    codeLabel.textColor = [UIColor blackColor];
    codeLabel.numberOfLines = 1;
    codeLabel.textAlignment = NSTextAlignmentCenter;
    codeLabel.layer.cornerRadius = 5;
    codeLabel.font = [UIFont fontWithName:defaultFontBold size:18];
    codeLabel.text = self.inviteCode;
    codeLabel.clipsToBounds = YES;
    
    currentY += codeLabel.frame.size.height + 10;
    
    CGFloat spacing = 10.f;
    CGFloat buttonWidth = (CGRectGetWidth(self.frame) - spacing * 3) / 2;
    CGFloat buttonHeight = 40.f;
    
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    copyButton.frame = CGRectMake(spacing, currentY, buttonWidth, buttonHeight);
    copyButton.backgroundColor = [UIColor grayColor];
    copyButton.layer.cornerRadius = 5.f;
    copyButton.tag = CLActionCopy;
    [copyButton setTintColor:[UIColor whiteColor]];
    [copyButton setImage:self.cpImage forState:UIControlStateNormal];
    [copyButton setTitle:@"複製" forState:UIControlStateNormal];
    
    [copyButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    shareButton.frame = CGRectMake(spacing * 2+ buttonWidth, currentY, buttonWidth, buttonHeight);
    shareButton.backgroundColor = [UIColor orangeColor];
    shareButton.layer.cornerRadius = 5.f;
    shareButton.tag = CLActionShare;
    [shareButton setTintColor:[UIColor whiteColor]];
    [shareButton setImage:self.shareImage forState:UIControlStateNormal];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    
    [shareButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    currentY += 50;
    
    currentY += imgv.frame.size.height;
    
    [self setupLayer];
    [self setupGesture];
    
    [self addSubview:titleLabel];
    [self addSubview:imgv];
    [self addSubview:messageLabel];
    [self addSubview:codeLabel];
    [self addSubview:copyButton];
    [self addSubview:shareButton];
}

- (id)initInputActionWithFrame:(CGRect)frame title:(NSString*)title hint:(NSString*)hint  image:(UIImage*)image
{
    if (self = [super initWithFrame:frame])
    {
        self.finalHeight = CGRectGetHeight(frame);
        
        self.frame = frame;
        self.title = title;
        self.hint = hint;
        self.image = image;
        
        [self initializeInputUI];
    }
    return self;
}

- (void)initializeInputUI
{
    CGFloat currentY = startY + 30;
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(3, currentY, CGRectGetWidth(self.frame) - 6, self.finalHeight - 6)];
    imgv.contentMode = UIViewContentModeScaleToFill;
    imgv.image = self.image;
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, currentY, CGRectGetWidth(self.frame), 70)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont fontWithName:defaultFontLight size:15];
    titleLabel.text = self.title;
    
    currentY += titleLabel.frame.size.height;
    
    CLTextField *inputField = [[CLTextField alloc] initWithFrame:CGRectMake(10, currentY, CGRectGetWidth(self.frame) - 20, 35)];
    inputField.placeholder = self.hint;
    inputField.backgroundColor = [UIColor whiteColor];
    inputField.layer.cornerRadius = 5.f;
    inputField.delegate = self;
    
    self.reservedField = inputField;
    
    currentY += inputField.frame.size.height + 10;
    
    CGFloat spacing = 10.f;
    CGFloat buttonWidth = (CGRectGetWidth(self.frame) - spacing * 2);
    CGFloat buttonHeight = 40.f;
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeSystem];
    okButton.frame = CGRectMake(spacing, currentY, buttonWidth, buttonHeight);
    okButton.backgroundColor = [UIColor orangeColor];
    okButton.layer.cornerRadius = 5.f;
    okButton.tag = CLActionOK;
    [okButton setTintColor:[UIColor whiteColor]];
    [okButton setTitle:@"OK" forState:UIControlStateNormal];
    
    [okButton addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    currentY += 50;
    
    currentY += imgv.frame.size.height;
    
    [self setupLayer];
    [self setupGesture];
    
    [self addSubview:imgv];
    [self addSubview:titleLabel];
    [self addSubview:inputField];
    [self addSubview:okButton];
    
    
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


- (void)buttonPress:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    CLAction action = btn.tag;
    if (self.actionBlock)
    {
        if (action == CLActionOK)
        {
            self.actionBlock (action, self.reservedField);
        }
        else
        {
            self.actionBlock (action, sender);
        }
    }
    
    [self dismiss];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
