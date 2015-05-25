![Platform](https://img.shields.io/badge/platform-iOS-green.svg)
![License](https://img.shields.io/badge/License-MIT%20License-orange.svg)


# CLCustomAlert
It's custom alert that used in our product at Ceylon Innovation Co., Ltd

#How to use

．HintAlert

```objective-c
#import "CLHintControl.h"

    CLHintControl *control = [[CLHintControl alloc] initWithFrame:CGRectMake(self.view.center.x - kCLHintControlWidth / 2, self.view.center.y - CLHintControlHeight / 2, kCLHintControlWidth, CLHintControlHeight) title:@"Title" message:@"Message" hintImage:[UIImage imageNamed:@"dota"]];
    
    [control showInView:self.view];


```

．ActionSheet like

```objective-c
#import "CLActionControl.h"

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

```

．Alert like

```objective-c
#import "CLActionAlertControl.h"

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

```
