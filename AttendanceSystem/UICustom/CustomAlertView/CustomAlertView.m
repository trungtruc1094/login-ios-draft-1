//
//  CustomAlertView.m
//  Envoy_App
//
//  Created by Nguyen Xuan Tho on 3/24/17.
//  Copyright © 2017 Keaz. All rights reserved.
//

#import "CustomAlertView.h"
#import "UILabel+Categorites.h"
#import "UIColor+Categories.h"

static CGFloat const kWidthDefaultOfContentView = 300.0f;
static CGFloat const kSpacing = 10.0f;
static CGFloat const kHeightDefaultOfButton = 40.0f;

@interface CustomAlertView ()

@property (nonatomic) UIWindow *alertWindow;
@property (nonatomic) UIWindow *mainWindow;
@property (nonatomic) UIView *backgroundView;
@property (nonatomic) UIView *contentView;
@property (nonatomic) UILabel *lblTitle;
@property (nonatomic) UILabel *lblMessage;
@property (nonatomic) UIButton *btnCancel;

@property (nonatomic) NSString *alertTitle;
@property (nonatomic) NSString *message;
@property (nonatomic) NSString *cancleButtonTitle;
@property (nonatomic) NSArray *otherButtonTitles;
@property (nonatomic) NSMutableArray *otherButtons;
@property (nonatomic, copy) CustomAlertViewCompletion completion;

@end

@implementation CustomAlertView

+ (CustomAlertView *)showCustomAlertViewWithTitle:(NSString *)title
                                          message:(NSString *)message
                                cancelButtonTitle:(NSString *)cancleButtonTitle
                                 otherButtonTitle:(NSArray *)otherButtonTitles
                                       completion:(CustomAlertViewCompletion)completion {
    CustomAlertView *alertView = [[CustomAlertView alloc] init];
    alertView.alertTitle = title;
    alertView.message = message;
    alertView.cancleButtonTitle = cancleButtonTitle;
    alertView.otherButtonTitles = otherButtonTitles;
    if (completion) {
        alertView.completion = completion;
    }
    
    [alertView setUp];
    
    return alertView;
}

- (void)setUp {
    self.mainWindow = [UIApplication sharedApplication].keyWindow;
    
    self.alertWindow = [[UIWindow alloc] initWithFrame:self.mainWindow.bounds];
    self.alertWindow.windowLevel = UIWindowLevelAlert;
    self.alertWindow.backgroundColor = [UIColor clearColor];
    
    self.alertWindow.rootViewController = self;
    
    [self.alertWindow makeKeyAndVisible];
}

- (void)loadView {
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectZero];
    baseView.backgroundColor = [UIColor clearColor];
    
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [baseView addSubview:self.backgroundView];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectZero];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 5.0f;
    [baseView addSubview:self.contentView];
    
    if ([self.alertTitle length] > 0) {
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectZero];
        self.lblTitle.font = [UIFont systemFontOfSize:20.0f];
        self.lblTitle.textColor = [UIColor blackColor];
        self.lblTitle.textAlignment = NSTextAlignmentCenter;
        self.lblTitle.numberOfLines = 0;
        self.lblTitle.text = self.alertTitle;
        [self.contentView addSubview:self.lblTitle];
    }
    
    if ([self.message length] > 0) {
        self.lblMessage = [[UILabel alloc] initWithFrame:CGRectZero];
        self.lblMessage.font = [UIFont systemFontOfSize:17.0f];
        self.lblMessage.textColor = [UIColor blackColor];
        self.lblMessage.textAlignment = NSTextAlignmentCenter;
        self.lblMessage.numberOfLines = 0;
        self.lblMessage.text = self.message;
        [self.contentView addSubview:self.lblMessage];
    }
    
    if ([self.cancleButtonTitle length] > 0) {
        self.btnCancel = [UIButton buttonWithType:UIButtonTypeSystem];
        self.btnCancel.titleLabel.font = [UIFont systemFontOfSize:18.0f];;
        self.btnCancel.frame = CGRectZero;
        [self.btnCancel setTitle:self.cancleButtonTitle forState:UIControlStateNormal];
        [self.btnCancel setTitleColor:[UIColor colorWithHexString:MAIN_BLUE_COLOR] forState:UIControlStateNormal];
        self.btnCancel.layer.borderWidth = 1.0f;
        self.btnCancel.layer.cornerRadius = 2.0f;
        self.btnCancel.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0].CGColor;
        [self.btnCancel addTarget:self action:@selector(tappedAtCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.btnCancel];
    }
    if ([self.otherButtonTitles count] > 0) {
        self.otherButtons = [[NSMutableArray alloc] init];
        if ([self.otherButtonTitles count] > 1) {
            NSAssert(self.otherButtonTitles ,@"Implement later.");
        }
        NSString *buttonTitle = self.otherButtonTitles[0];
        if (buttonTitle.length > 0) {
            UIButton *btnOther = [UIButton buttonWithType:UIButtonTypeSystem];
            btnOther.titleLabel.font = [UIFont systemFontOfSize:18.0f];
            btnOther.titleLabel.numberOfLines = 0;
            btnOther.titleLabel.textAlignment = NSTextAlignmentCenter;
            btnOther.frame = CGRectZero;
            [btnOther setTitle:buttonTitle forState:UIControlStateNormal];
            [btnOther setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btnOther.layer.cornerRadius = 2.0f;
            btnOther.backgroundColor = [UIColor colorWithHexString:MAIN_BLUE_COLOR];
            [btnOther addTarget:self action:@selector(tappedAtOtherButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:btnOther];
            
            [self.otherButtons addObject:btnOther];
        }
    }
    
    [self setView:baseView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.backgroundView.frame = self.alertWindow.bounds;
    
    CGFloat widthOfLabel = kWidthDefaultOfContentView - kSpacing * 2;
    CGFloat heightOfContentView = 0.0f;
    if (self.lblTitle) {
        CGFloat heightOfTitleLabel = [self.lblTitle heightOfLabelWithWidth:widthOfLabel];
        self.lblTitle.frame = CGRectMake(kSpacing, kSpacing, widthOfLabel, heightOfTitleLabel);
        heightOfContentView = CGRectGetMaxY(self.lblTitle.frame) + kSpacing;
    }
    if (self.lblMessage) {
        CGFloat heightOfMessageLabel = [self.lblMessage heightOfLabelWithWidth:widthOfLabel];
        self.lblMessage.frame = CGRectMake(kSpacing, CGRectGetMaxY(self.lblTitle.frame) + kSpacing, widthOfLabel, heightOfMessageLabel);
        heightOfContentView = CGRectGetMaxY(self.lblMessage.frame) + kSpacing;
    }
    if ([self.otherButtons count] > 0) {
        UIButton *btnOther = self.otherButtons[0];
        CGFloat widthOfOtherButton = (widthOfLabel - 10) / 2;
        CGFloat heightOfOtherButton = kHeightDefaultOfButton;
        CGSize buttonSize = [btnOther sizeThatFits:CGSizeMake(CGFLOAT_MAX, heightOfOtherButton)];
        if (buttonSize.width > widthOfOtherButton) {
            if (self.btnCancel) {
                CGSize newButtonSize = [btnOther sizeThatFits:CGSizeMake(widthOfOtherButton, CGFLOAT_MAX)];
                heightOfOtherButton = newButtonSize.height + 10;
            } else {
                widthOfOtherButton = widthOfLabel;
            }
        }
        btnOther.frame = CGRectMake(kSpacing, CGRectGetMaxY(self.lblMessage.frame) + kSpacing, widthOfOtherButton, heightOfOtherButton);
        heightOfContentView = CGRectGetMaxY(btnOther.frame) + kSpacing;
    }
    if (self.btnCancel) {
        CGFloat widthOfCancelButton = widthOfLabel;
        CGFloat xOfCancelButton = kSpacing;
        CGFloat yOfCancelButton = CGRectGetMaxY(self.lblMessage.frame) + kSpacing;
        CGFloat heightOfCancelButton = kHeightDefaultOfButton;
        if ([self.otherButtons count] > 0) {
            UIButton *btnOther = self.otherButtons[0];
            if (btnOther.bounds.size.width == widthOfLabel) {
                yOfCancelButton = CGRectGetMaxY(btnOther.frame) + kSpacing;
            } else {
                xOfCancelButton = CGRectGetMaxX(btnOther.frame) + kSpacing;
                widthOfCancelButton = btnOther.bounds.size.width;
            }
            if (btnOther.bounds.size.height > heightOfCancelButton) {
                heightOfCancelButton = btnOther.bounds.size.height;
            }
        }
        self.btnCancel.frame = CGRectMake(xOfCancelButton, yOfCancelButton, widthOfCancelButton, heightOfCancelButton);
        heightOfContentView = CGRectGetMaxY(self.btnCancel.frame) + kSpacing;
    }
    self.contentView.frame = CGRectMake((self.alertWindow.bounds.size.width - kWidthDefaultOfContentView) / 2,
                                        (self.alertWindow.bounds.size.height - heightOfContentView) / 2,
                                        kWidthDefaultOfContentView,
                                        heightOfContentView);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (void)tappedAtCancelButton:(UIButton *)btn {
    [self hideAlertView];
    if (self.completion) {
        self.completion(self, 0);
    }
}

- (void)tappedAtOtherButton:(UIButton *)btn {
    [self hideAlertView];
    if (self.completion) {
        self.completion(self, 1);
    }
}

- (void)hideAlertView {
    [self.alertWindow setHidden:YES];
    self.alertWindow = nil;
    [self.mainWindow makeKeyAndVisible];
    self.mainWindow = nil;
}

@end
