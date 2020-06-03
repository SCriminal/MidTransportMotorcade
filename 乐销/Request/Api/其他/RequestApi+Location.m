//
//  RequestApi+Location.m
//  Driver
//
//  Created by 隋林栋 on 2019/6/5.
//  Copyright © 2019 ping. All rights reserved.
//

#import "RequestApi+Location.h"

@implementation RequestApi (Location)

/**
 查询车辆地理位置
 */
+(void)requestCarTrickWithuploaderId:(double)uploaderId
                              startTime:(double)startTime
                                endTime:(double)endTime
                          vehicleNumber:(NSString *)vehicleNumber
                              delegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"uploaderId":NSNumber.dou(uploaderId),
                          @"startTime":NSNumber.lon(startTime),
                          @"endTime":NSNumber.lon(endTime),
                          @"vehicleNumber":RequestStrKey(vehicleNumber),
                          @"sortCreateTime":@3
                          };
    [self getUrl:@"/location/location/list/sort" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 添加车辆地理位置
 */
+(void)requestAddLocationsWithData:(NSString *)data
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"data":RequestStrKey(data)};
    [self postUrl:@"/location/location/list" delegate:delegate parameters:dic success:success failure:failure];
}

@end
