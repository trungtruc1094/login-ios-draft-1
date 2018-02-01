//
//  MenuViewController.m
//  AttendanceSystem
//
//  Created by TrungTruc on 1/24/18.
//  Copyright © 2018 TrungTruc. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuItemModel.h"
#import <REFrostedViewController.h>
#import "UIColor+Categories.h"

static CGFloat const kCellHeightRatio = 60.0f/667.0f;
static CGFloat kCellHeight;

@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *btnProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblProfileName;
@property (weak, nonatomic) IBOutlet UITableView *tableMenu;

@property (nonatomic) NSArray *items;
@property (nonatomic) NSInteger itemIndexSelected;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kCellHeight;
}

- (void)initUserInterface {
    
    kCellHeight = SCREEN_HEIGHT * kCellHeightRatio;
    
    self.lblProfileName.text = @"";
    self.tableMenu.rowHeight = UITableViewAutomaticDimension;
    self.tableMenu.estimatedRowHeight = 100;
    self.tableMenu.backgroundColor = [UIColor colorWithHexString:MAIN_BLUE_COLOR];
    self.tableMenu.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableMenu.delegate = self;
    self.tableMenu.dataSource = self;
    
    MenuItemModel *courselist = [[MenuItemModel alloc] initWithName:@"Course List"
                                                                 type:MenuItemType_CourseList
                                                    imageNameSelected:@"icon_nav_menu"
                                                  imageNameUnselected:@"icon_nav_menu"];
    MenuItemModel *sendFeeback = [[MenuItemModel alloc] initWithName:@"Send Feedback"
                                                                    type:MenuItemType_SendFeedback
                                                       imageNameSelected:@"icon_nav_menu"
                                                     imageNameUnselected:@"icon_nav_menu"];
    MenuItemModel *schedules = [[MenuItemModel alloc] initWithName:@"Schedules"
                                                              type:MenuItemType_Schedules
                                                 imageNameSelected:@"icon_nav_menu"
                                               imageNameUnselected:@"icon_nav_menu"];
    MenuItemModel *account = [[MenuItemModel alloc] initWithName:@"Account"
                                                            type:MenuItemType_Account
                                               imageNameSelected:@"icon_nav_menu"
                                             imageNameUnselected:@"icon_nav_menu"];
    MenuItemModel *about = [[MenuItemModel alloc] initWithName:@"About"
                                                                   type:MenuItemType_About
                                                      imageNameSelected:@"icon_nav_menu"
                                                    imageNameUnselected:@"icon_nav_menu"];
    MenuItemModel *logout = [[MenuItemModel alloc] initWithName:@"Logout"
                                                                   type:MenuItemType_Logout
                                                      imageNameSelected:@"icon_nav_menu"
                                                    imageNameUnselected:@"icon_nav_menu"];
    
    self.items = @[courselist,
                   sendFeeback,
                   schedules,
                   account,
                   about,
                   logout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTouchProfileIcon:(id)sender {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"menuItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        cell.backgroundColor = [UIColor clearColor];
    }
    MenuItemModel *item = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    if (indexPath.row == self.itemIndexSelected) {
        cell.textLabel.textColor = [UIColor whiteColor]; //[UIColor colorWithHexString:MAIN_BLUE_COLOR];
        [cell.imageView setImage:[UIImage imageNamed:item.imageNameSelected]];
    } else {
        cell.textLabel.textColor = [UIColor whiteColor];
        [cell.imageView setImage:[UIImage imageNamed:item.imageNameUnselected]];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.frostedViewController hideMenuViewController];
    self.itemIndexSelected = indexPath.row;
    [tableView reloadData];
    MenuItemModel *item = [self.items objectAtIndex:indexPath.row];
    switch (item.type) {
        case MenuItemType_CourseList:
            
            break;
            
        case MenuItemType_SendFeedback:
           
            break;
            
        case MenuItemType_Schedules:
            break;
            
        case MenuItemType_Account:
            break;
        case MenuItemType_About:
            break ;
        case MenuItemType_Logout:
            break;
        default:
            break;
    }
    self.itemIndexSelected = 0;
}

@end
