//
//  RequestApi+Order.m
//中车运
//
//  Created by 隋林栋 on 2018/11/6.
//  Copyright © 2018 ping. All rights reserved.
//

#import "RequestApi+Order.h"

@implementation RequestApi (Order)


/**
 列表：承运人端
 */
+(void)requestOrderListWithWaybillnumber:(NSString *)waybillNumber
                              categoryId:(double)categoryId
                                   state:(NSString *)state
                                blNumber:(NSString *)blNumber
                        shippingLineName:(NSString *)shippingLineName
                              oceanVesel:(NSString *)oceanVesel
                            voyageNumber:(NSString *)voyageNumber
                            startContact:(NSString *)startContact
                              startPhone:(NSString *)startPhone
                              endContact:(NSString *)endContact
                                endPhone:(NSString *)endPhone
                        closingStartTime:(double)closingStartTime
                          closingEndTime:(double)closingEndTime
                            placeEnvName:(NSString *)placeEnvName
                          placeStartTime:(double)placeStartTime
                            placeEndTime:(double)placeEndTime
                            placeContact:(NSString *)placeContact
                         createStartTime:(double)createStartTime
                           createEndTime:(double)createEndTime
                         acceptStartTime:(double)acceptStartTime
                           acceptEndTime:(double)acceptEndTime
                         finishStartTime:(double)finishStartTime
                           finishEndTime:(double)finishEndTime
                                    page:(double)page
                                   count:(double)count
                                   entId:(double)entId
                          sortAcceptTime:(int)sortAcceptTime
                          sortFinishTime:(int)sortFinishTime
                          sortCreateTime:(int)sortCreateTime
                                delegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"waybillNumber":RequestStrKey(waybillNumber),
                          @"categoryId":NSNumber.dou(categoryId),
                          @"states":RequestStrKey(state),
                          @"blNumber":RequestStrKey(blNumber),
                          @"shippingLineName":RequestStrKey(shippingLineName),
                          @"oceanVesel":RequestStrKey(oceanVesel),
                          @"voyageNumber":RequestStrKey(voyageNumber),
                          @"startContact":RequestStrKey(startContact),
                          @"startPhone":RequestStrKey(startPhone),
                          @"endContact":RequestStrKey(endContact),
                          @"endPhone":RequestStrKey(endPhone),
                          @"closingStartTime":NSNumber.lon(closingStartTime),
                          @"closingEndTime":NSNumber.lon(closingEndTime),
                          @"placeEnvName":RequestStrKey(placeEnvName),
                          @"placeStartTime":NSNumber.lon(placeStartTime),
                          @"placeEndTime":NSNumber.lon(placeEndTime),
                          @"placeContact":RequestStrKey(placeContact),
                          @"createStartTime":NSNumber.lon(createStartTime),
                          @"createEndTime":NSNumber.lon(createEndTime),
                          @"acceptStartTime":NSNumber.lon(acceptStartTime),
                          @"acceptEndTime":NSNumber.lon(acceptEndTime),
                          @"finishStartTime":NSNumber.lon(finishStartTime),
                          @"finishEndTime":NSNumber.lon(finishEndTime),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
                          @"entId":NSNumber.dou(entId),
                          @"sortAcceptTime":[NSNumber numberWithInt:sortAcceptTime],
                          @"sortFinishTime":[NSNumber numberWithInt:sortFinishTime],
                          @"sortCreateTime":[NSNumber numberWithInt:sortCreateTime]
                          };
    [self getUrl:@"/zhongcheyun/waybill/2/list/carrier/total/sort" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 车队接单
 */
+(void)requestAcceptOrderWithSelectids:(NSString *)selectIds
                                 entId:(double)entId
                                    id:(double)identity
                              delegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"selectIds":RequestStrKey(selectIds),
                          @"entId":NSNumber.dou(entId),
                          @"id":NSNumber.dou(identity)};
    [self patchUrl:@"/zhongcheyun/waybill/2/402/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 接单前取消
 */
+(void)requestRejectOrderWithEntid:(double)entId
                                id:(double)identity
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"entId":NSNumber.dou(entId),
                          @"id":NSNumber.dou(identity)};
    [self patchUrl:@"/zhongcheyun/waybill/2/499/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 撤单，退单
 */
+(void)requestReturnOrderWithSelectids:(NSString *)selectIds
                                 entId:(double)entId
                                  fees:(NSString *)fees
                                    id:(double)identity
                              delegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"selectIds":RequestStrKey(selectIds),
                          @"entId":NSNumber.dou(entId),
                          @"fees":RequestStrKey(fees),
                          @"id":NSNumber.dou(identity)};
    [self postUrl:@"/zhongcheyun/waybill/2/411421/1/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 派车（拆运输单或者直接下单）
 */
+(void)requestDispatchOrderWithWaybillcargos:(NSString *)waybillCargos
                                 transportId:(double)transportId
                                       entId:(double)entId
                                    carrierId:(double)carrierId
                                     truckId:(double)truckId
                                   placeTime:(double)placeTime
                                    delegate:(id <RequestDelegate>)delegate
                                     success:(void (^)(NSDictionary * response, id mark))success
                                     failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"waybillCargos":RequestStrKey(waybillCargos),
                          @"transportId":NSNumber.dou(transportId),
                          @"carrierId":NSNumber.dou(carrierId),
                          @"entId":NSNumber.dou(entId),
                          @"truckId":NSNumber.dou(truckId),
                          @"placeTime":NSNumber.lon(placeTime)
                          };
    [self postUrl:@"/zhongcheyun/waybill/3/601/1" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 详情
 */
+(void)requestOrderDetailWithId:(double)identity
                          entId:(double)entId
                       delegate:(id <RequestDelegate>)delegate
                        success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"entId":NSNumber.dou(entId)};
    [self getUrl:@"/zhongcheyun/waybill/detail/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 状态时间轨迹列表
 */
+(void)requestOrderTimeAxleWithFormid:(double)formId
                                entId:(double)entId
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"formId":NSNumber.dou(formId),
                          @"entId":NSNumber.dou(entId),
                          @"formType":@2
                          };
    [self getUrl:@"/zhongcheyun/waybill/state/time" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 状态时间轨迹列表（派车单）
 */
+(void)requestDriverOrderTimeAxleWithFormid:(double)formId
                                entId:(double)entId
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"formId":NSNumber.dou(formId),
                          @"entId":NSNumber.dou(entId),
                          };
    [self getUrl:@"/zhongcheyun/waybill/state/trajectory" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 运单货物列表
 */
+(void)requestGoosListWithId:(double)identity
                       entID:(double)entID
                    delegate:(id <RequestDelegate>)delegate
                     success:(void (^)(NSDictionary * response, id mark))success
                     failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"page":NSNumber.dou(1),
                          @"count":NSNumber.dou(100),
                          @"entId":NSNumber.dou(entID)};
    [self getUrl:@"/zhongcheyun/waybill/container/waybillCargo/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 费用统计
 */
+(void)requestStatisticWithAcceptstarttime:(double)acceptStartTime
                             acceptEndTime:(double)acceptEndTime
                           createStartTime:(double)createStartTime
                             createEndTime:(double)createEndTime
                           placeStartTime:(double)placeStartTime
                             placeEndTime:(double)placeEndTime
                                     entId:(double)entId
                                  delegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure{
    
    NSDictionary *dic = @{@"acceptStartTime":[NSNumber numberWithString:[NSString stringWithFormat:@"%.f",acceptStartTime]],
                          @"acceptEndTime":[NSNumber numberWithString:[NSString stringWithFormat:@"%.f",acceptEndTime]],
                          @"createStartTime":[NSNumber numberWithString:[NSString stringWithFormat:@"%.f",createStartTime]],
                          @"createEndTime":[NSNumber numberWithString:[NSString stringWithFormat:@"%.f",createEndTime]],
                          @"placeStartTime":[NSNumber numberWithString:[NSString stringWithFormat:@"%.f",placeStartTime]],
                          @"placeEndTime":[NSNumber numberWithString:[NSString stringWithFormat:@"%.f",placeEndTime]],
                          @"entId":NSNumber.dou(entId)};
    [self getUrl:@"/zhongcheyun/fee/statistics" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 列表
 */
+(void)requestAccessoryListWithFormid:(double)formId
                             formType:(double)formType
                                entId:(double)entId
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"formId":NSNumber.dou(formId),
                          @"formType":NSNumber.dou(formType),
                          @"entId":NSNumber.dou(entId)};
    [self getUrl:@"/zhongcheyun/waybill/attachment/list" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 录入箱号，铅封号
 */
+(void)requestInputPackageNumWithWaybillcargoid:(double)waybillCargoId
                                containerNumber:(NSString *)containerNumber
                                     sealNumber:(NSString *)sealNumber
                                          entId:(double)entId
                                       delegate:(id <RequestDelegate>)delegate
                                        success:(void (^)(NSDictionary * response, id mark))success
                                        failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"cargoId":NSNumber.dou(waybillCargoId),
                          @"containerNumber":UnPackStr(containerNumber),
                          @"sealNumber":UnPackStr(sealNumber),
                          @"entId":NSNumber.dou(entId)
                          };
    [self patchUrl:@"/zhongcheyun/waybill/container" delegate:delegate parameters:dic success:success failure:failure];
}

@end
