//
//  CLTextField.m
//  cbountyLib
//
//  Created by Leo Chang on 5/21/15.
//  Copyright (c) 2015 Ceylon Innovation Co., Ltd. All rights reserved.
//

#import "CLTextField.h"
#import "ControlDefine.h"

@implementation CLTextField

- (void)drawPlaceholderInRect:(CGRect)rect
{
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont fontWithName:defaultFontLight size:14],
                                  NSParagraphStyleAttributeName: paragraphStyle,
                                  NSForegroundColorAttributeName:[UIColor grayColor]};
    
    //Redraw the postion of placeholder
    CGRect boundingRect = [self.placeholder boundingRectWithSize:rect.size options:0 attributes:attributes context:nil];
    rect.origin.y = (rect.size.height/2)-boundingRect.size.height/2;
    
    [self.placeholder drawInRect:rect withAttributes:attributes];
}

@end
