//
//  RequestApi+Location.h
//  Driver
//
//  Created by 隋林栋 on 2019/6/5.
//  Copyright © 2019 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Location)

/**
 查询车辆地理位置
 */
+(void)requestCarTrickWithuploaderId:(double)uploaderId
                              startTime:(double)startTime
                                endTime:(double)endTime
                          vehicleNumber:(NSString *)vehicleNumber
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 添加车辆地理位置
 */
+(void)requestAddLocationsWithData:(NSString *)data
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;

@end

NS_ASSUME_NONNULL_END
