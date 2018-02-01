//
//  CustomAlertView.h
//  Envoy_App
//
//  Created by Nguyen Xuan Tho on 3/24/17.
//  Copyright © 2017 Keaz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomAlertView;

typedef void(^CustomAlertViewCompletion)(CustomAlertView *alertView, NSInteger buttonIndex);

@interface CustomAlertView : UIViewController

+ (CustomAlertView *)showCustomAlertViewWithTitle:(NSString *)title
                                          message:(NSString *)message
                                cancelButtonTitle:(NSString *)cancleButtonTitle
                                 otherButtonTitle:(NSArray *)otherButtonTitles
                                       completion:(CustomAlertViewCompletion)completion;

@end
