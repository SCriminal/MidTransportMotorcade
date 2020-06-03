//
//  RequestApi+Order.h
//中车运
//
//  Created by 隋林栋 on 2018/11/6.
//  Copyright © 2018 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Order)

typedef NS_ENUM(NSUInteger, ENUM_ORDER_OPERATE_TYPE) {
    ENUM_ORDER_OPERATE_COMPLETE = 0,
    ENUM_ORDER_OPERATE_WAIT_RECEIVE,//接单
    ENUM_ORDER_OPERATE_WAIT_TRANSPORT,//待运输
};//


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
                                 failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 车队接单
 */
+(void)requestAcceptOrderWithSelectids:(NSString *)selectIds
                                 entId:(double)entId
                                    id:(double)identity
                              delegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 接单前取消
 */
+(void)requestRejectOrderWithEntid:(double)entId
                                id:(double)identity
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 撤单，退单
 */
+(void)requestReturnOrderWithSelectids:(NSString *)selectIds
                                 entId:(double)entId
                                  fees:(NSString *)fees
                                    id:(double)identity
                              delegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure;

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
                                     failure:(void (^)(NSString * errorStr, id mark))failure;

//订单详情
+(void)requestOrderDetailWithId:(double)identity
                          entId:(double)entId
                       delegate:(id <RequestDelegate>)delegate
                        success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 状态时间轨迹列表（派车单）
 */
+(void)requestOrderTimeAxleWithFormid:(double)formId
                                entId:(double)entId
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 状态时间轨迹列表（派车单）
 */
+(void)requestDriverOrderTimeAxleWithFormid:(double)formId
                                      entId:(double)entId
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 运单货物列表
 */
+(void)requestGoosListWithId:(double)idp
                       entID:(double)entID
                    delegate:(id <RequestDelegate>)delegate
                     success:(void (^)(NSDictionary * response, id mark))success
                     failure:(void (^)(NSString * errorStr, id mark))failure;

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
                                   failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 列表
 */
+(void)requestAccessoryListWithFormid:(double)formId
                             formType:(double)formType
                                entId:(double)entId
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 录入箱号，铅封号
 */
+(void)requestInputPackageNumWithWaybillcargoid:(double)waybillCargoId
                                containerNumber:(NSString *)containerNumber
                                     sealNumber:(NSString *)sealNumber
                                          entId:(double)entId
                                       delegate:(id <RequestDelegate>)delegate
                                        success:(void (^)(NSDictionary * response, id mark))success
                                        failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
