//
//  RequestApi+Dictionary.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/29.
//  Copyright © 2019 ping. All rights reserved.
//

#import "RequestApi+Dictionary.h"

@implementation RequestApi (Dictionary)
/**
 查询所有省
 */
+(void)requestProvinceWithDelegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/zhongcheyun/dict/containerarea/1/1/list" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 根据区查询所有镇
 */
+(void)requestCityWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity)};
    [self getUrl:@"/zhongcheyun/dict/containerarea/1/2/list/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 根据市查询所有区
 */
+(void)requestAreaWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity)};
    [self getUrl:@"/zhongcheyun/dict/containerarea/1/3/list/{id}" delegate:delegate parameters:dic success:success failure:failure];
}




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
                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"better":RequestStrKey(better),
                          @"bad":RequestStrKey(bad),
                          @"app":@"2",
                          @"terminalType":@1,
                          @"userId":NSNumber.dou(userId)};
    [self postUrl:@"/zhongcheyun/feedback" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 箱型下拉列表
 */
+(void)requestPackageTypeWithDelegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{};
    [self getUrl:@"/zhongcheyun/dict/containertype/list/option" delegate:delegate parameters:dic success:^(NSDictionary * response, id mark){
        NSMutableArray * aryModels = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelPackageType"];
        [GlobalMethod writeAry:aryModels key:LOCAL_PACKAGE_TYPE];
    } failure:failure];
}

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
                     failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"src":NSNumber.dou(src),
                          @"state":NSNumber.dou(state),
                          @"type":NSNumber.dou(type),
                          @"content":RequestStrKey(content),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
//                          @"isRead":NSNumber.dou(isRead),
                          @"entId":NSNumber.dou(entId)};
    [self getUrl:@"/zhongcheyun/messagelog/ent/list" delegate:delegate parameters:dic success:success failure:failure];
}
@end
