//
//  UserManager.h
//  Envoy_App
//
//  Created by Nguyen Xuan Tho on 3/2/17.
//  Copyright © 2017 Keaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

typedef enum
{
LOGIN_BY_NO_SSO,
LOGIN_BY_SSO
    
}LOGIN_TYPE;

typedef enum
{
    SSO_LOGIN,
    SSO_REGISTER
    
}SSO_TYPE;

typedef enum
{
     LOGIN_BY_DOMAIN,
    LOGIN_BY_NO_DOMAIN
   
    
}LOGIN_DOMAIN_TYPE;

typedef enum
{
    PERSONAL_ACCOUNT,
    BUSINESS_ACCOUNT
  
}ACCOUNT_TYPE;

@interface UserManager : NSObject

+ (instancetype)userCenter;

- (void)setCurrentUserToken:(NSString *)token;
- (NSString *)getCurrentUserToken;

- (void)setLoginStatus:(BOOL)status;
- (BOOL)isLogin;

- (void)setStaySignedIn:(BOOL)isStay;
- (BOOL)isStaySignedIn;

- (void)setForceLogout:(BOOL)isLogout;
- (BOOL)isForceLogout;

- (void)setCurrentUser:(UserModel *)userModel;
- (UserModel *)getCurrentUser;

- (void)setIsNewUser:(BOOL)isNew;
- (BOOL)getIsNewUser;

- (void)setFirstUpdateProfile:(BOOL)type ;
- (BOOL)getFirstUpdateProfile;

@end
