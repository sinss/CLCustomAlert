//
//  ViewController.m
//  CLCustomAlert
//
//  Created by Leo Chang on 5/25/15.
//  Copyright (c) 2015 Ceylon Innovation Co., Ltd. All rights reserved.
//

#import "ViewController.h"
#import "CLAlertControl.h"
#import "CLActionAlertControl.h"
#import "CLHintControl.h"
#import "CLActionControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Test UI
- (IBAction)showAlertControl:(id)sender
{
    CLAlertControl *control = [[CLAlertControl alloc] initWithFrame:CGRectMake(self.view.center.x - kCLAlertControlWidth / 2, -CLActionControlHeight, kCLAlertControlWidth, CLAlertControlHeight) title:@"Title" message:@"Message With %@ \n subMessage" targetName:@"Target Name" image:[UIImage imageNamed:@"dota_bg"]];
    
    [control showInView:self.view];
    
    return;
}

- (IBAction)showActionControl:(id)sender
{
    CLActionControl *control = [[CLActionControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), CLActionControlHeight) title:@"Title" message:@"mssage\nmessage2" hintImage:nil];
    
    [control setActionBlock:^(CLAction action, id sender){
        
        if (action == CLActionCancel)
        {
            NSLog(@"Cancel !!");
        }
        else if (action == CLActionConfirm)
        {
            NSLog(@"Confirm !!");
        }
    }];
    
    [control showInView:self.view];
}

- (IBAction)showHintControl:(id)sender
{
    CLHintControl *control = [[CLHintControl alloc] initWithFrame:CGRectMake(self.view.center.x - kCLHintControlWidth / 2, self.view.center.y - CLHintControlHeight / 2, kCLHintControlWidth, CLHintControlHeight) title:@"Title" message:@"Message" hintImage:[UIImage imageNamed:@"dota"]];
    
    [control showInView:self.view];
}

- (IBAction)showActionAlertControl:(id)sender
{
    CLActionAlertControl *control = [[CLActionAlertControl alloc] initExchangeWithFrame:CGRectMake(self.view.center.x - kCLActionAlertControlWidth, self.view.center.y - CLExchangeActionAlertControlHeight / 2, kCLActionAlertControlWidth, CLExchangeActionAlertControlHeight) title:@"Title" message:@"Message\nSubMEssage" image:[UIImage imageNamed:@"dota_bg"]];
    
    [control setActionBlock:^(CLAction action, id sender){
        
        if (action == CLActionCancel)
        {
            NSLog(@"Cancel !!");
        }
        else if (action == CLActionEarnPoints)
        {
            NSLog(@"Earns Points !!");
        }
    }];
    
    [control showInView:self.view];
}

- (IBAction)showInviteActionAlertControl:(id)sender
{
    CLActionAlertControl *control = [[CLActionAlertControl alloc] initInviteWithFrame:CGRectMake(self.view.center.x - kCLActionAlertControlWidth, self.view.center.y - CLInviteActionAlertHeight / 2, kCLActionAlertControlWidth, CLInviteActionAlertHeight) title:@"Title \n subtitle" inviteHint:@"hint Message" inviteCode:@"1234567" image:[UIImage imageNamed:@""] shareImage:[UIImage imageNamed:@""] copyImage:[UIImage imageNamed:@""]];
    
    [control setActionBlock:^(CLAction action, id sender){
        
        if (action == CLActionCopy)
        {
            NSLog(@"Copy !!");
        }
        else if (action == CLActionShare)
        {
            NSLog(@"Share !!");
        }
    }];
    
    [control showInView:self.view];
}

- (IBAction)showUpdateActionAlertControl:(id)sender
{
    CLActionAlertControl *control = [[CLActionAlertControl alloc] initUpdateWithFrame:CGRectMake(self.view.center.x - kCLActionAlertControlWidth, self.view.center.y - CLUpdateActionAlertHeight / 2, kCLActionAlertControlWidth, CLUpdateActionAlertHeight) title:@"Title" message:@"There is a new version \n Update ?" image:[UIImage imageNamed:@"dota_bg"]];
    
    [control setActionBlock:^(CLAction action, id sender){
        
        if (action == CLActionCancel)
        {
            NSLog(@"Cancel !!");
        }
        else if (action == CLActionUpdate)
        {
            NSLog(@"Update !!");
        }
    }];
    
    [control showInView:self.view];
}

- (IBAction)showRewardActionAlertControl:(id)sender
{
    //CLRewardPointsAlertHeight
    CLActionAlertControl *control = [[CLActionAlertControl alloc] initInviteRewardWithFrame:CGRectMake(self.view.center.x - kCLActionAlertControlWidth, self.view.center.y - CLRewardPointsAlertHeight / 2, kCLActionAlertControlWidth, CLRewardPointsAlertHeight) title:@"Congrats" message:@"Message" points:@999 image:[UIImage imageNamed:@""]];
    
    [control setActionBlock:^(CLAction action, id sender){
        
        if (action == CLActionTakeALook)
        {
            NSLog(@"Take a look !!");
        }
        else if (action == CLActionInvite)
        {
            NSLog(@"Invite !!");
        }
    }];
    
    [control showInView:self.view];
}

- (IBAction)showInputActionControl:(id)sender
{
    CLActionAlertControl *control = [[CLActionAlertControl alloc] initInputActionWithFrame:CGRectMake(self.view.center.x - kCLActionAlertControlWidth / 2, self.view.center.y - CLInputAlertHeight / 2, kCLActionAlertControlWidth, CLInputAlertHeight) title:@"Title \n subtitle" hint:@"Input here" image:[UIImage imageNamed:@""]];
    
    [control setActionBlock:^(CLAction action, id sender) {
        if (action == CLActionOK)
        {
            UITextField *input = (UITextField*)sender;
            
            NSLog(@"user input : %@", input.text);
        }
    }];
    
    [control showInView:self.view];
}

@end
