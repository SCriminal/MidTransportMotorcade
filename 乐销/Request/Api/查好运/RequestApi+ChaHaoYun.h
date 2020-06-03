//
//  RequestApi+ChaHaoYun.h
//中车运
//
//  Created by 隋林栋 on 2018/11/20.
//  Copyright © 2018 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (ChaHaoYun)
/**
 - 车辆定位
 */
+(void)requestCarLocationWithTruck_no:(NSString *)truck_no//车牌号码
                             delegate:(_Nullable id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;



/**
 - 提单号查询
 */
+(void)requestBillNumInquireWithBl_no:(NSString *)bl_no//提单号
                           station_id:(NSString *)station_id//场站id
                                 code:(NSString *)code//验证码
                             delegate:(_Nullable id <RequestDelegate>)delegate
                                     success:(void (^)(NSDictionary * response, id mark))success
                                     failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 - 获取场站验证码
 */
+(void)requestStationCodeWithStation_Id:(NSString *)station_id//场站id
                               delegate:(_Nullable id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 - 获取场站列表
 */
+(void)requestChaStationListWithDelegate:(_Nullable id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure;

@end

NS_ASSUME_NONNULL_END

