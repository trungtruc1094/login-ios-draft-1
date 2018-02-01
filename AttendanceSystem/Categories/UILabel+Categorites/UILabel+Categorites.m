//
//  UILabel+Categorites.m
//  Envoy_App
//
//  Created by TamTran on 13/03/2017.
//  Copyright © 2017 KaneNguyen. All rights reserved.
//

#import "UILabel+Categorites.h"

@implementation UILabel (Categorites)

- (CGFloat)widthOfLabelWithHeight:(CGFloat)height {
    CGSize size = [self sizeThatFits:CGSizeMake(CGFLOAT_MAX, height)];
    
    return size.width;
}

- (CGFloat)heightOfLabelWithWidth:(CGFloat)width {
    CGSize size = [self sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
    
    return size.height;
}

@end
