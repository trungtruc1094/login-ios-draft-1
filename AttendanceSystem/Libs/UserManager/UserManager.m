//
//  UserManager.m
//  Envoy_App
//
//  Created by Nguyen Xuan Tho on 3/2/17.
//  Copyright © 2017 Keaz. All rights reserved.
//

#import "UserManager.h"
#import "ConnectionManager.h"
#import "UserModel.h"

static NSString *kKeyChainStoreService = @"com.keaz.yoogo.dev";
static NSString *kEnvoyUserToken = @"EnvoyUserToken";
static NSString *kEnvoyUserId = @"EnvoyUserId";
static NSString *kEnvoyAppLoginStatus = @"EnvoyAppLoginStatus";
static NSString *kEnvoySettingStaySignedIn = @"EnvoySettingStaySignedIn";
static NSString *kEnvoySettingForceLogout = @"EnvoySettingForceLogout";
static NSString *kEnvoyCurrentUser = @"EnvoyCurrentUser";
static NSString *kSourceHost = @"XSourceHost";

@interface UserManager ()

@property (nonatomic) LOGIN_TYPE loginType;
@property (nonatomic) LOGIN_DOMAIN_TYPE domainType;
@property (nonatomic) ACCOUNT_TYPE accountType;
@property (nonatomic) SSO_TYPE ssoType;
@property (nonatomic) BOOL isNew;
@property (nonatomic) ErrorType userFlow;
@property (nonatomic) BOOL isFirstUpdateProfile;
@end

@implementation UserManager

+ (instancetype)userCenter {
    static UserManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserManager alloc] initPrivate];
        manager.isNew = FALSE;
    });
    return manager;
}

- (instancetype)initPrivate {
    self = [self init];
    
    return self;
}

- (NSString *)getCurrentUserToken {
    NSString *token = [self getCurrentUser].token;
    
    return token;
}

- (void)setCurrentUserToken:(NSString *)token {
    UserModel* user = [self getCurrentUser];
    user.token = token;
    [self setCurrentUser:user];
}

- (void)setLoginStatus:(BOOL)status {
    [[NSUserDefaults standardUserDefaults] setBool:status forKey:kEnvoyAppLoginStatus];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isLogin {
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:kEnvoyAppLoginStatus];
}

- (void)setStaySignedIn:(BOOL)isStay {
    [[NSUserDefaults standardUserDefaults] setBool:isStay forKey:kEnvoySettingStaySignedIn];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isStaySignedIn {
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:kEnvoySettingStaySignedIn];
}

- (void)setForceLogout:(BOOL)isLogout {
    [[NSUserDefaults standardUserDefaults] setBool:isLogout forKey:kEnvoySettingForceLogout];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isForceLogout {
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:kEnvoySettingForceLogout];
}

- (void)setCurrentUser:(UserModel *)userModel {
    if(userModel == nil)
        return;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:userModel.userId forKey:kUserId];
     [defaults setObject:userModel.role_id forKey:kUserRoleId];
     [defaults setObject:userModel.email forKey:kUserEmail];
     [defaults setObject:userModel.token forKey:kUserToken];
     [defaults setObject:userModel.first_name forKey:kUserFirstName];
     [defaults setObject:userModel.last_name forKey:kUserLastName];
     [defaults setObject:userModel.phone forKey:kUserPhone];
    
    [defaults synchronize];
}

- (UserModel *)getCurrentUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    UserModel* user = [[UserModel alloc] init];
    
    [user setUserId:[defaults objectForKey:kUserId]];
      [user setEmail:[defaults objectForKey:kUserEmail]];
      [user setToken:[defaults objectForKey:kUserToken]];
      [user setFirst_name:[defaults objectForKey:kUserFirstName]];
      [user setLast_name:[defaults objectForKey:kUserLastName]];
      [user setPhone:[defaults objectForKey:kUserPhone]];
      [user setRole_id:[defaults objectForKey:kUserRoleId]];
    
    return user;
}

- (void)setIsNewUser:(BOOL)isNew {
    self.isNew = isNew;
}

- (BOOL)getIsNewUser {
    return self.isNew;
}

- (ErrorType)getUserFlow {
    return self.userFlow;
}

- (BOOL)getFirstUpdateProfile {
    return self.isFirstUpdateProfile;
}

- (void)setFirstUpdateProfile:(BOOL)type {
    self.isFirstUpdateProfile = type;
}

@end
