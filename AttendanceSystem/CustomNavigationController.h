//
//  CustomNavigationController.h
//  AttendanceSystem
//
//  Created by TrungTruc on 1/25/18.
//  Copyright © 2018 TrungTruc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationController : UINavigationController<UIGestureRecognizerDelegate>

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender;

@end
