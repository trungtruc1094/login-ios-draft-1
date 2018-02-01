//
//  LoadingManager.m
//  Envoy_App
//
//  Created by Nguyen Xuan Tho on 3/7/17.
//  Copyright © 2017 Keaz. All rights reserved.
//

#import "LoadingManager.h"
#import "DGActivityIndicatorView.h"
#import "MBProgressHUD.h"

@interface LoadingManager ()

@property (nonatomic) DGActivityIndicatorView *activityIndicatorView;

@end

@implementation LoadingManager

+ (LoadingManager *)showLoadingViewInView:(UIView *)view {
    LoadingManager *loadingManager = [[LoadingManager alloc] initWithView:view];
    if (loadingManager) {
        
    }
    
    return loadingManager;
}

+ (BOOL)hideLoadingViewForView:(UIView *)view {
    MBProgressHUD *hub = [MBProgressHUD HUDForView:view.window];
    hub.mode = MBProgressHUDModeCustomView;
    
    if (hub) {
        if ([hub.customView isKindOfClass:[DGActivityIndicatorView class]]) {
            DGActivityIndicatorView *indicator = (DGActivityIndicatorView *)hub.customView;
            [indicator stopAnimating];
//            dispatch_sync(dispatch_get_main_queue(), ^{
                [indicator removeFromSuperview];
//            });
        }
        hub.removeFromSuperViewOnHide = YES;
        [hub hideAnimated:YES];
        [hub removeFromSuperview];
        
        return YES;
    }
    
    return NO;
}

+ (BOOL) hideLoadingViewForView:(UIView *)view withCompletion:(LoadingComplete)completion {
    [self hideLoadingViewForView:view];
    if(completion)
        completion();
    return TRUE;
}

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        self.activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotatePulse tintColor:[UIColor whiteColor] size:37.0f];
        [self.activityIndicatorView startAnimating];
        
        MBProgressHUD *hub = [[MBProgressHUD alloc] initWithView:view.window];
        hub.mode = MBProgressHUDModeCustomView;
        [hub setCustomView:self.activityIndicatorView];
        hub.bezelView.color = [UIColor darkGrayColor];
        hub.contentColor = [UIColor whiteColor];
        
        [hub showAnimated:YES];
        [view.window addSubview:hub];
    }
    
    return self;
}

@end
