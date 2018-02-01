//
//  LoadingManager.h
//  Envoy_App
//
//  Created by Nguyen Xuan Tho on 3/7/17.
//  Copyright © 2017 Keaz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LoadingComplete)();

@class UIView;

@interface LoadingManager : NSObject

+ (LoadingManager *)showLoadingViewInView:(UIView *)view;

+ (BOOL)hideLoadingViewForView:(UIView *)view;

+ (BOOL)hideLoadingViewForView:(UIView *)view withCompletion:(LoadingComplete)completion;

@end
