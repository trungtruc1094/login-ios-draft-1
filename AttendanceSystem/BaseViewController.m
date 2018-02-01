//
//  ViewController.m
//  AttendanceSystem
//
//  Created by TrungTruc on 1/24/18.
//  Copyright © 2018 TrungTruc. All rights reserved.
//

#import "BaseViewController.h"
#import "CourseListViewController.h"
#import "LoadingManager.h"
#import "UIColor+Categories.h"
#import "CustomAlertView.h"

static BOOL isAlertDisplayed = NO;

@interface BaseViewController ()

@property (nonatomic) UIButton *_Nullable btnRight;
@property (nonatomic) UIButton *_Nullable btnLeft;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpView];
    [self initUserInterface];
    [self initDelegate];
    [self initService];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowAlertView:) name:NOTIFICATION_CONECTION_ERROR object:nil];
    
    //    [self showHideNavigationBar];
    //    [self addBottomLineToNavigationBar];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_CONECTION_ERROR object:nil];
}

- (void)willShowAlertView:(NSNotification *)noti {
    NSDictionary *userInfo = noti.userInfo;
    if (userInfo && !isAlertDisplayed) {
        NSNumber *errorType = userInfo[USER_INFO_ERROR_TYPE];
        NSUInteger type = errorType.unsignedIntegerValue;
        NSString *message = @"";
        switch (type) {
            case ErrorType_NoNetwork:
                message = NO_NETWORK_MSG;
                
                break;
            case ErrorType_TimeOut:
                message = TIME_OUT_MSG;
                
                break;
            case ErrorType_TokenFail: {
//                [[UserManager userCenter] setLoginStatus:NO];
                [[ConnectionManager connectionDefault] setTokenHeaderWithValue:@""];
                message = TOKEN_INVALIE_MSG;
            }
                break;
            case ErrorType_InternalServerError:
                message = SERVER_ERROR_MSG;
                
                break;
                
            default:
                break;
        }
        [self showAlertNoticeWithMessage:message
                              completion:
         ^(NSInteger buttonIndex) {
             if (type == ErrorType_TokenFail) {
                 UIStoryboard *mainSTB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                 UIViewController *signInVC = [mainSTB instantiateInitialViewController];
                 [self presentViewController:signInVC animated:YES completion:nil];
             }
         }];
    }
}

- (void)showAlertNoticeWithMessage:(NSString *)message completion:(AlertCompletion)completion {
    isAlertDisplayed = YES;
    if(!message || message.length == 0)
        return;
    [CustomAlertView showCustomAlertViewWithTitle:@""
                                          message:message
                                cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                 otherButtonTitle:nil
                                       completion:
     ^(CustomAlertView *alertView, NSInteger buttonIndex) {
         isAlertDisplayed = NO;
         if (completion) {
             completion(buttonIndex);
         }
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpView {
    if (self.navigationController) {
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.backBarButtonItem = nil;
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:MAIN_BLUE_COLOR];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
        [self.navigationController.navigationBar setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//           ,
//           NSFontAttributeName:[UIFont fontWithName:
//                                               size:fontSize]}];
        
        self.btnLeft = [UIButton buttonWithType:UIButtonTypeSystem];
        self.btnLeft.frame = CGRectMake(0, 0, 44, 44);
        [self.btnLeft addTarget:self action:@selector(tappedAtLeftButton:) forControlEvents:UIControlEventTouchUpInside];
        NSString *leftImageName = @"";
        if ([self isKindOfClass:[CourseListViewController class]]) {
            leftImageName = @"icon_nav_menu";
        }
        else
            leftImageName = @"icon_nav_back";
        [self.btnLeft setImage:[[UIImage imageNamed:leftImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        self.btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.btnLeft];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

#pragma mark - Action Methods

- (void)tappedAtRightButton:(id)sender {
    
}

- (void)tappedAtLeftButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUserInterface {
    
}

- (void)initDelegate {
    
}

-(void)initService {
    
}

- (void)showLoadingView {
    if(self.navigationController)
        [LoadingManager showLoadingViewInView:self.navigationController.view];
    else
        [LoadingManager showLoadingViewInView:self.view];
}

- (void)hideLoadingView {
    if(self.navigationController)
        [LoadingManager hideLoadingViewForView:self.navigationController.view];
    else
        [LoadingManager hideLoadingViewForView:self.view];
}

- (void)showAlertQuestionWithMessage:(NSString *)message completion:(AlertCompletion)completion {
    [CustomAlertView showCustomAlertViewWithTitle:@""
                                          message:message
                                cancelButtonTitle:@"No"
                                 otherButtonTitle:@[@"Yes"]
                                       completion:
     ^(CustomAlertView *alertView, NSInteger buttonIndex) {
         if (completion) {
             completion(buttonIndex);
         }
     }];
}

- (void)showAlertQuestionWithMessage:(NSString * _Nonnull)message
                          completion:(AlertCompletion _Nullable)completion
                   cancelButtonTitle:(NSString* _Nullable)cancelTitle
                    otherButtonTitle:(NSString* _Nullable)otherTitle {
    [CustomAlertView showCustomAlertViewWithTitle:@""
                                          message:message
                                cancelButtonTitle:cancelTitle
                                 otherButtonTitle:@[otherTitle]
                                       completion:
     ^(CustomAlertView *alertView, NSInteger buttonIndex) {
         if (completion) {
             completion(buttonIndex);
         }
     }];
}

@end
