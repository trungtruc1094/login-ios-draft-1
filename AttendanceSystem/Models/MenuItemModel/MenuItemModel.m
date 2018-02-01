//
//  MenuItemModel.m
//  tomycar
//
//  Created by Tho  on 7/14/17.
//  Copyright © 2017 KEAZ. All rights reserved.
//

#import "MenuItemModel.h"

@implementation MenuItemModel

- (instancetype)initWithName:(NSString *)name type:(MenuItemType)type imageNameSelected:(NSString *)imageNameSelected imageNameUnselected:(NSString *)imageNameUnselected {
    self = [self init];
    if (self) {
        self.name = name;
        self.type = type;
        self.imageNameSelected = imageNameSelected;
        self.imageNameUnselected = imageNameUnselected;
    }
    
    return self;
}

@end
