//
//  UserModel.m
//  Envoy_App
//
//  Created by Nguyen Xuan Tho on 3/7/17.
//  Copyright © 2017 Keaz. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (JSONKeyMapper *)keyMapper {
    
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"userId": @"id"
                                                                 }];
}

+ (BOOL)propertyIsIgnored:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"timezoneOffset"]) {
        
        return YES;
    }
    
    return NO;
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.userId forKey:kUserId];
    [encoder encodeObject:self.role_id forKey:kUserRoleId];
    [encoder encodeObject:self.token forKey:kUserToken];
    [encoder encodeObject:self.first_name forKey:kUserFirstName];
    [encoder encodeObject:self.last_name forKey:kUserLastName];
    [encoder encodeObject:self.phone forKey:kUserPhone];
    [encoder encodeObject:self.email forKey:kUserEmail];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        self.userId = [decoder decodeObjectForKey:kUserId];
        self.email = [decoder decodeObjectForKey:kUserEmail];
        self.role_id = [decoder decodeObjectForKey:kUserRoleId];
        self.first_name = [decoder decodeObjectForKey:kUserFirstName];
        self.last_name = [decoder decodeObjectForKey:kUserLastName];
        self.phone = [decoder decodeObjectForKey:kUserPhone];
        self.token = [decoder decodeObjectForKey:kUserToken];
    }
    return self;
}

@end

