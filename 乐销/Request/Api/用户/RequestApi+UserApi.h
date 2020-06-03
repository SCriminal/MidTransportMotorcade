//
//  RequestApi+UserApi.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/16.
//  Copyright © 2019 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (UserApi)

/**
 用户注册
 */
+(void)requestRegisterWithApp:(NSString *)app
                    cellPhone:(NSString *)cellPhone
                     password:(NSString *)password
                         code:(NSString *)code
                     delegate:(id <RequestDelegate>)delegate
                      success:(void (^)(NSDictionary * response, id mark))success
                      failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 验证码登陆
 */
+(void)requestLoginCodeWithApp:(NSString *)app
                         scene:(NSString *)scene
                     cellPhone:(NSString *)cellPhone
                          code:(NSString *)code
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 修改基础信息
 */
+(void)requestChangeUserInfoWithNickname:(NSString *)nickname
                                 headUrl:(NSString *)headUrl
                                  gender:(NSString *)gender
                                birthday:(NSString *)birthday
                            contactPhone:(NSString *)contactPhone
                                  areaId:(NSString *)areaId
                                 address:(NSString *)address
                                   email:(NSString *)email
                                  weChat:(NSString *)weChat
                               introduce:(NSString *)introduce
                                delegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 获取基础信息
 */
+(void)requestUserInfoWithDelegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 获取验证码
 */
+(void)requestFetchCodeWithApp:(NSString *)app
                     cellPhone:(NSString *)cellPhone
                       smsType:(NSString *)smsType
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 - 绑定设备
 */
+(void)requestBindDeviceIdWithDeviceID:(NSString *)device_id
                              delegate:(_Nullable id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 版本升级
 */
+(void)requestVersionWithDelegate:(_Nullable id<RequestDelegate> )delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 添加版本信息
 */
+(void)requestAddVersionWithForceUpdate:(BOOL)ForceUpdate
                          versionNumber:(NSString *)versionNumber
                            description:(NSString *)description
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 token登录/时效延长
 */
+(void)requestExtendTokenSuccess:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
