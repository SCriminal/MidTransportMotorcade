//
//  RequestApi+ChaHaoYun.m
//中车运
//
//  Created by 隋林栋 on 2018/11/20.
//  Copyright © 2018 ping. All rights reserved.
//

#import "RequestApi+ChaHaoYun.h"

@implementation RequestApi (ChaHaoYun)
/**
 - 车辆定位
 */
+(void)requestCarLocationWithTruck_no:(NSString *)truck_no//车牌号码
                             delegate:(_Nullable id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{
                          @"service":@"Tool.Truck_Location.Search", @"access_token":@"XXQ5X9uW1Wlw5qBpOqh5QsoH4P7BY2xAG_hoaMbMwueteiZY_YrelZKh5SxDrh_-1AMDSVelu7CPwiUddH6e4BTDW2Mw2yh4xIXQGdT7UBEYdBVEzExvpCOW1jA5pEpG2HIqrHpCIhKf4wuJX87O_qH_V-i4MQ4PWo1cfH50d6RdecD5HEtHUl4-LWSAwU0gUNbPiZvqmUHDkZALSlAbcQ",
                          @"truck_no":UnPackStr(truck_no),
                          @"source":@"app"
                          };
    [self getUrl:@"https://api.chahaoyun.com/" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 - 提单号查询
 */
+(void)requestBillNumInquireWithBl_no:(NSString *)bl_no//提单号
                                  station_id:(NSString *)station_id//场站id
                           code:(NSString *)code//验证码
                                    delegate:(_Nullable id <RequestDelegate>)delegate
                                     success:(void (^)(NSDictionary * response, id mark))success
                                     failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"access_token":@"XXQ5X9uW1Wlw5qBpOqh5QsoH4P7BY2xAG_hoaMbMwueteiZY_YrelZKh5SxDrh_-1AMDSVelu7CPwiUddH6e4BTDW2Mw2yh4xIXQGdT7UBEYdBVEzExvpCOW1jA5pEpG2HIqrHpCIhKf4wuJX87O_qH_V-i4MQ4PWo1cfH50d6RdecD5HEtHUl4-LWSAwU0gUNbPiZvqmUHDkZALSlAbcQ",
                          @"bl_no":UnPackStr(bl_no),
                          @"station_id":UnPackStr(station_id),
                          @"source":@"app",
                          @"code":UnPackStr(code)};
    [self postUrl:@"https://api.chahaoyun.com/?service=Tool.Order_Index.Show" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 - 获取场站验证码
 */
+(void)requestStationCodeWithStation_Id:(NSString *)station_id//场站id
delegate:(_Nullable id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"station_id":UnPackStr(station_id)};
    [self postUrl:@"https://api.chahaoyun.com/?service=Tool.Order_Index.ShowCode" delegate:delegate parameters:dic success:success failure:failure];
}


/**
 - 获取场站列表
 */
+(void)requestChaStationListWithDelegate:(_Nullable id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"https://api.chahaoyun.com/?service=Tool.Station_Index.ListAll" delegate:delegate parameters:dic success:success failure:failure];
}


@end
