//
//  ConnectionManager.h
//  Envoy_App
//
//  Created by Nguyen Xuan Tho on 3/2/17.
//  Copyright © 2017 Keaz. All rights reserved.
//

#import <Foundation/Foundation.h>

OS_ASSUME_NONNULL_BEGIN

typedef void(^ConnectionProgress)(NSProgress * _Nullable uploadProgress);
typedef void(^ConnectionComplete)(id  _Nonnull responseObject);
typedef void(^ConnectionFailure)(ErrorType errorType, NSString * _Nonnull errorMessage, id  _Nullable responseObject);


@interface ConnectionManager : NSObject

+ (_Nonnull instancetype)connectionDefault;

- (void)setTokenHeaderWithValue:(NSString * _Nonnull)token;
- (void)setSourceHost:(NSString* _Nonnull)host;

- (void)login:(NSString * _Nullable)username
     password:(NSString * _Nonnull)password
   andSuccess:(ConnectionComplete _Nullable)success
   andFailure:(ConnectionFailure _Nullable)failure;

@end
OS_ASSUME_NONNULL_END
