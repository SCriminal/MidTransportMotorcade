//
//  RequestApi+Dictionary.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/29.
//  Copyright © 2019 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Dictionary)

/**
 查询所有省
 */
+(void)requestProvinceWithDelegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 根据区查询所有镇
 */
+(void)requestCityWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 根据市查询所有区
 */
+(void)requestAreaWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure;



/**
 添加反馈
 */
+(void)requestAddFeedbackWithBetter:(NSString *)better
                                bad:(NSString *)bad
                                app:(NSString *)app
                        teminalType:(double)teminalType
                             userId:(double)userId
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 箱型下拉列表
 */
+(void)requestPackageTypeWithDelegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 消息列表(企业)
 */
+(void)requestMsgListWithSrc:(double)src
                       state:(double)state
                        type:(double)type
                     content:(NSString *)content
                        page:(double)page
                       count:(double)count
                      isRead:(double)isRead
                       entId:(double)entId
                    delegate:(id <RequestDelegate>)delegate
                     success:(void (^)(NSDictionary * response, id mark))success
                     failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
