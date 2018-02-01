//
//  Enums.h
//  Envoy_App
//
//  Created by Nguyen Xuan Tho on 2/27/17.
//  Copyright © 2017 Keaz. All rights reserved.
//

#ifndef Enums_h
#define Enums_h

typedef enum {
    ErrorType_NoNetwork,
    ErrorType_TimeOut,
    ErrorType_UserNotFound,
    ErrorType_NotActive,
    ErrorType_Other,
    ErrorType_TokenFail,
    ErrorType_Password,
    ErrorType_InternalServerError,
    ErrorType_InThePast,
    ErrorType_OutUpdate,
    ErrorType_BookingIsTooShort,
    ErrorType_UserExist,
    ErrorType_BookingDriverExpired,
    ErrorType_BookingDriverEmpty,
    ErrorType_BookingPaymentEmpty,
    ErrorType_SSOLogin,
    ErrorType_SSORegister,
    ErrorType_CompanyNotExist
} ErrorType;


#endif /* Enums_h */
