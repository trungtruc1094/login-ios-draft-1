//
//  ViewController.h
//  AttendanceSystem
//
//  Created by TrungTruc on 1/24/18.
//  Copyright © 2018 TrungTruc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertCompletion)(NSInteger buttonIndex);

@interface BaseViewController : UIViewController

-(void)initUserInterface;
-(void)initDelegate;
-(void)initService;
- (void)showAlertNoticeWithMessage:(NSString * _Nonnull)message completion:(AlertCompletion _Nullable)completion;
- (void)showAlertQuestionWithMessage:(NSString * _Nonnull)message completion:(AlertCompletion _Nullable)completion;
- (void)showAlertQuestionWithMessage:(NSString * _Nonnull)message
                          completion:(AlertCompletion _Nullable)completion
                   cancelButtonTitle:(NSString* _Nullable)cancelTitle
                    otherButtonTitle:(NSString* _Nullable)otherTitle;
@end

