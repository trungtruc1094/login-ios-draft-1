//
//  ConnectionManager.m
//  Envoy_App
//
//  Created by Nguyen Xuan Tho on 3/2/17.
//  Copyright © 2017 Keaz. All rights reserved.
//

#import "ConnectionManager.h"
#import "AFHTTPSessionManager.h"

//Link API
static NSString *const kLogin = @"authenticate/login";
static NSString *const kLogout = @"authenticate/logout";
static NSString *const kRegister = @"user";

//Header
static NSString *kHeaderSourceHostKey = @"X-SOURCE-HOST";
static NSString *kHeaderTokenKey = @"Token";
static NSString *kHeaderAppVersion = @"version";
static NSString *kHeaderAppName = @"app_name";
static NSString *kHeaderDeviceType = @"device_type";

//Parameter


//Error
static NSString *const kErrorResponseData = @"com.alamofire.serialization.response.error.data";
static NSString *const kErrorResponse = @"com.alamofire.serialization.response.error.response";
static NSString *const kErrorDescription = @"description";
static NSString *const kErrorCode = @"code";
static NSString *const kErrorTitle = @"title";
static NSString *const kErrorData = @"data";
static NSString *const kErrorAccount = @"user_account";
static NSString *const kErrorPending = @"user_pending";
static NSString *const kErrorToken = @"token_required";
static NSString *const kErrorPassword = @"user_password";
static NSString *const kErrorUserExist = @"user_exist";
static NSString *const kErrorInThePast = @"in_the_past";
static NSString *const kErrorOutUpdate = @"booking_out_update";
static NSString *const kErrorUserId = @"id";
static NSString *const kErrorBookingIsTooShort = @"booking_too_short";
static NSString *const kErrorBookingDriverExpired = @"booking_driver_expired";
static NSString *const kErrorBookingDriverEmpty = @"booking_driver_empty";
static NSString *const kErrorBookingPaymentEmpty = @"booking_payment_empty";
static NSString * const kErrorSSOLogin = @"sso_login";
static NSString *const kErrorSSORegister = @"sso_register";
static NSString *const kErrorCompanyNotExist = @"company_not_exist";
//Others
static NSString *const kEndPointLink = @"End point link";
static NSString *const kXSourceHost = @"X source host";

NSString *linkService(NSString *subLink) {
    NSString *endPointLink = @"https://iteccyle8.herokuapp.com/"; //[[NSBundle mainBundle] objectForInfoDictionaryKey:kEndPointLink];
    
    return [endPointLink stringByAppendingString:subLink];
}

@interface ConnectionManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation ConnectionManager

+ (instancetype)connectionDefault {
    static ConnectionManager *connection = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        connection = [[self alloc] initPrivate];
    });
    return connection;
}

- (instancetype)initPrivate {
    self = [self init];
    if (self) {
        self.sessionManager = [AFHTTPSessionManager manager];
        self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.sessionManager.requestSerializer.timeoutInterval = 20.0f;
        
//        [self.sessionManager.requestSerializer setValue:kXSourceHost forHTTPHeaderField:kHeaderSourceHostKey];
        
//        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//        [self.sessionManager.requestSerializer setValue:version forHTTPHeaderField:kHeaderAppVersion];
//
//        [self.sessionManager.requestSerializer setValue:kAppName forHTTPHeaderField:kHeaderAppName];
//        [self.sessionManager.requestSerializer setValue:kDeviceType forHTTPHeaderField:kHeaderDeviceType];
    }
    
    return self;
}

- (void)setSourceHost:(NSString *)host {
    NSLog(@"source host : %@",host);
    if(host.length == 0)
        host = [[NSBundle mainBundle] objectForInfoDictionaryKey:kXSourceHost];
    [self.sessionManager.requestSerializer setValue:host forHTTPHeaderField:kHeaderSourceHostKey];
}

- (void)handleResponseData:(id)responseObject
                andSuccess:(ConnectionComplete)success {
    //#if DEBUG
    //    NSError *error = nil;
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject
    //                                                       options:NSJSONWritingPrettyPrinted
    //                                                         error:&error];
    //    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSLog(@"Sucess ---- %@", jsonString);
    //#endif
    if (success) {
        success(responseObject);
    }
}

- (void)handleResponseError:(NSError *)error
                 andFailure:(ConnectionFailure)failure {
    if (failure) {
        ErrorType errorType = ErrorType_Other;
        NSString *errorMessage = @"";
        id responseObject = nil;
        
        if (error.code == kCFURLErrorNotConnectedToInternet) {
            errorType = ErrorType_NoNetwork;
        } else if (error.code == kCFURLErrorTimedOut) {
            errorType = ErrorType_TimeOut;
        } else {
            NSData *data = error.userInfo[kErrorResponseData];
            if (data) {
                //#if DEBUG
                //                NSString *errorString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                //                NSLog(@"Error ---- %@", errorString);
                //#endif
                NSError *jsonError;
                NSDictionary *dataResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:kNilOptions
                                                                               error:&jsonError];
                if (jsonError) {
                    errorType = ErrorType_InternalServerError;
                } else {
                    if ([dataResponse objectForKey:kErrorCode]) {
                        NSString *errorCode = dataResponse[kErrorCode];
                        if ([errorCode isEqualToString:kErrorAccount]) {
                            errorType = ErrorType_UserNotFound;
                        } else if ([errorCode isEqualToString:kErrorPending]) {
                            errorType = ErrorType_NotActive;
                        } else if([errorCode isEqualToString:kErrorToken]) {
                            errorType  = ErrorType_TokenFail;
                        } else if ([errorCode isEqualToString:kErrorPassword]) {
                            errorType = ErrorType_Password;
                        } else if ([errorCode isEqualToString:kErrorInThePast]) {
                            errorType = ErrorType_InThePast;
                        } else if ([errorCode isEqualToString:kErrorOutUpdate]) {
                            errorType = ErrorType_OutUpdate;
                        } else if ([errorCode isEqualToString:kErrorBookingIsTooShort]) {
                            errorType = ErrorType_BookingIsTooShort;
                        } else if([errorCode isEqualToString:kErrorUserExist]) {
                            errorType = ErrorType_UserExist;
                        } else if([errorCode isEqualToString:kErrorBookingDriverExpired]) {
                            errorType = ErrorType_BookingDriverExpired;
                        } else if([errorCode isEqualToString:kErrorBookingDriverEmpty]) {
                            errorType = ErrorType_BookingDriverEmpty;
                        } else if([errorCode isEqualToString:kErrorBookingPaymentEmpty]) {
                            errorType = ErrorType_BookingPaymentEmpty;
                        } else if([errorCode isEqualToString:kErrorSSOLogin]) {
                            errorType = ErrorType_SSOLogin;
                        } else if([errorCode isEqualToString:kErrorSSORegister]) {
                            errorType = ErrorType_SSORegister;
                        } else if([errorCode isEqualToString:kErrorCompanyNotExist]) {
                            errorType = ErrorType_CompanyNotExist;
                        }
                        else {
                            errorType = ErrorType_Other;
                        }
                    }
                    if ([dataResponse objectForKey:kErrorDescription]) {
                        errorMessage = dataResponse[kErrorDescription];
                    }
                    // Special message for kErrorInThePast
                    if (errorType == ErrorType_InThePast) {
                        errorMessage = SERVER_ERROR_MSG; //NSLocalizedString(@"bookingScreen.inThePast", nil);
                    }
                    
                    if ([dataResponse objectForKey:kErrorData]) {
                        responseObject = dataResponse[kErrorData];
                    }
                }
            }
        }
        if (errorType == ErrorType_InternalServerError ||
            errorType == ErrorType_TokenFail ||
            errorType == ErrorType_NoNetwork ||
            errorType == ErrorType_TimeOut) {
            [self cancelAllRequest];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:NOTIFICATION_CONECTION_ERROR
             object:nil
             userInfo:@{USER_INFO_ERROR_TYPE:[NSNumber numberWithUnsignedInteger:errorType]}];
            
        }
        
        if(errorMessage.length == 0)
            errorMessage = SERVER_ERROR_MSG;
        
        failure(errorType, errorMessage, responseObject);
    }
}

- (void)setTokenHeaderWithValue:(NSString *)token {
    NSLog(@"Connection Manager => token : %@", token);
    [self.sessionManager.requestSerializer setValue:token forHTTPHeaderField:kHeaderTokenKey];
}

- (void)cancelAllRequest {
    NSArray *allTask = [self.sessionManager tasks];
    if ([allTask count] > 0) {
        for (NSURLSessionDataTask *task in allTask) {
            [task cancel];
        }
    }
}

- (void)login:(NSString *)username password:(NSString *)password andSuccess:(ConnectionComplete)success andFailure:(ConnectionFailure)failure {
    NSDictionary *parameter = @{@"username": username, @"password" : password};
    
    NSString* url = linkService(kLogin);
    NSLog(@"url : %@" ,url);
    NSLog(@"parameter : %@" , parameter);
    
    [self.sessionManager POST:url
                   parameters:parameter
                     progress:nil
                      success:
     ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [self handleResponseData:responseObject andSuccess:success];
     }
                      failure:
     ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self handleResponseError:error andFailure:failure];
     }];
}

@end
