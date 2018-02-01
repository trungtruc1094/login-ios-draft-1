//
//  HomeViewController.m
//  AttendanceSystem
//
//  Created by TrungTruc on 1/24/18.
//  Copyright © 2018 TrungTruc. All rights reserved.
//

#import "HomeViewController.h"
#import "CustomNavigationController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib {
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomNavigationController"];
    
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    self.menuViewSize = CGSizeMake(SCREEN_WIDTH* 2 / 3, SCREEN_HEIGHT);
    
    [super awakeFromNib];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
