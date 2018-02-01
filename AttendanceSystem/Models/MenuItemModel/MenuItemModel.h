//
//  MenuItemModel.h
//  tomycar
//
//  Created by Tho  on 7/14/17.
//  Copyright © 2017 KEAZ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MenuItemType) {
    MenuItemType_CourseList,
    MenuItemType_SendFeedback,
    MenuItemType_Schedules,
    MenuItemType_Account,
    MenuItemType_About,
    MenuItemType_Logout
};

@interface MenuItemModel : NSObject

- (instancetype)initWithName:(NSString *)name type:(MenuItemType)type imageNameSelected:(NSString *)imageNameSelected imageNameUnselected:(NSString *)imageNameUnselected;

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *imageNameSelected;
@property (nonatomic) NSString *imageNameUnselected;
@property (nonatomic) MenuItemType type;

@end
