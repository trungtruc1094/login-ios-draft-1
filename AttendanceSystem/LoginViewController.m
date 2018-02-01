//
//  LoginViewController.m
//  AttendanceSystem
//
//  Created by TrungTruc on 1/24/18.
//  Copyright © 2018 TrungTruc. All rights reserved.
//

#import "LoginViewController.h"
#import <MaterialControls/MDTextField.h>
#import "LoadingManager.h"
#import "HomeViewController.h"
#import "ConnectionManager.h"

@interface LoginViewController ()<MDTextFieldDelegate>
@property (weak, nonatomic) IBOutlet MDTextField *tfEmail;
@property (weak, nonatomic) IBOutlet MDTextField *tfPassword;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    MDTextField *textField = [[MDTextField alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
//    textField.delegate = self;
//    textField.singleLine = true;
//    textField.maxCharacterCount = 30;
//    textField.errorMessage = @"Wrong password";
//    textField.errorColor = [UIColor redColor];
//    textField.secureTextEntry = true;
//    textField.label = @"Email";
//    textField.floatingLabel = true;
//    [self.tfEmail addSubview:textField];
//    [self.tfEmail layoutIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTouchLogin:(id)sender {
    [self.view endEditing:TRUE];
    [LoadingManager showLoadingViewInView:self.view];
    
    NSString* userName = self.tfEmail.text;
    NSString* password = self.tfPassword.text;
    
    [[ConnectionManager connectionDefault] login:userName password:password andSuccess:^(id  _Nonnull responseObject) {
        [LoadingManager hideLoadingViewForView:self.view];
        
        UserModel* user = [[UserModel alloc] initWithDictionary:responseObject error:nil];
        [[UserManager userCenter] setCurrentUser:user];
        
        [_tfEmail setErrorMessage:@"Email is empty"];
        [_tfPassword setErrorMessage:@"Password is empty"];
        [_tfEmail setErrorColor:[UIColor redColor]];
        [_tfPassword setErrorColor:[UIColor redColor]];
        ////////////////////////
        HomeViewController* homeController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [self presentViewController:homeController animated:TRUE completion:nil];
    } andFailure:^(ErrorType errorType, NSString * _Nonnull errorMessage, id  _Nullable responseObject) {
         [LoadingManager hideLoadingViewForView:self.view];
        [self showAlertNoticeWithMessage:errorMessage completion:nil];
    }];
 
}


- (IBAction)didTouchForgotPassword:(id)sender {
    
    
}


@end
