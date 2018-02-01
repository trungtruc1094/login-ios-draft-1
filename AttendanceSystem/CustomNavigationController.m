//
//  CustomNavigationController.m
//  AttendanceSystem
//
//  Created by TrungTruc on 1/25/18.
//  Copyright © 2018 TrungTruc. All rights reserved.
//

#import "CustomNavigationController.h"
#import <REFrostedViewController.h>

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(panGestureRecognized:)];
    [pan setEdges:UIRectEdgeLeft];
    [pan setDelegate:self];
    [self.view addGestureRecognizer:pan];
}

#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIScreenEdgePanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

@end
