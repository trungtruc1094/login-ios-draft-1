//
//  CourseListViewController.m
//  AttendanceSystem
//
//  Created by TrungTruc on 1/24/18.
//  Copyright © 2018 TrungTruc. All rights reserved.
//

#import "CourseListViewController.h"
#import <REFrostedViewController.h>

@interface CourseListViewController ()

@end

@implementation CourseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tappedAtLeftButton:(id)sender {
    [self.frostedViewController presentMenuViewController];
}

@end
