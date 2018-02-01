//
//  UserModel.h
//  Envoy_App
//
//  Created by Nguyen Xuan Tho on 3/7/17.
//  Copyright © 2017 Keaz. All rights reserved.
//

#import "JsonBaseModel.h"

static NSString *const kUserId = @"user_id";
static NSString *const kUserEmail = @"user_email";
static NSString *const kUserRoleId = @"user_role_id";
static NSString *const kUserFirstName = @"user_first_name";
static NSString *const kUserLastName = @"user_last_name";
static NSString *const kUserToken = @"user_token";
static NSString *const kUserPhone = @"user_phone";

@interface UserModel : JsonBaseModel

@property (nonatomic) NSString <Optional> *userId;
@property (nonatomic) NSString <Optional> *role_id;
@property (nonatomic) NSString <Optional> *email;
@property (nonatomic) NSString <Optional> *token;
@property (nonatomic) NSString <Optional> *first_name;
@property (nonatomic) NSString <Optional> *last_name;
@property (nonatomic) NSString <Optional> *phone;

@end

