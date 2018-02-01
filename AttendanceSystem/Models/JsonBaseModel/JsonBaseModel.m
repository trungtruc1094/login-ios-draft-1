//
//  JsonBaseModel.m
//  Envoy_App
//
//  Created by Nguyen Xuan Tho on 3/8/17.
//  Copyright © 2017 Keaz. All rights reserved.
//

#import "JsonBaseModel.h"

@implementation JsonBaseModel

+ (JSONKeyMapper *)keyMapper
{
    return [JSONKeyMapper mapperForSnakeCase];
}

@end
