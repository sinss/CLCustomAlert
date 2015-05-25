//
//  ControlDefine.h
//  cbountyLib
//
//  Created by Leo Chang on 5/22/15.
//  Copyright (c) 2015 Ceylon Innovation Co., Ltd. All rights reserved.
//

#ifndef cbountyLib_ControlDefine_h
#define cbountyLib_ControlDefine_h

#define kGreenColor @"009688"
#define defaultFontBold @"HelveticaNeue-Bold"
#define defaultFontLight @"HelveticaNeue-Light"
#define defaultFontCondensedBold @"HelveticaNeue-CondensedBold"

typedef NS_ENUM(NSUInteger, CLAction)
{
    CLActionCancel,
    CLActionConfirm,
    CLActionEarnPoints,
    CLActionUpdate,
    CLActionCopy,
    CLActionShare,
    CLActionOK,
    CLActionTakeALook,
    CLActionInvite,
};

typedef void (^CLActionHandler) (CLAction action, id sender);

#endif
