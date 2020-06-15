//
//  RequestApi+Company.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/27.
//  Copyright © 2019 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Company)
/**
 企业列表（用户）
 */
+(void)requestCompanyListWithDelegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 企业详情
 */
+(void)requestCompanyDetailWithId:(double)identity
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 审核记录列表
 */
+(void)requestAuthorityRecordListWithEntid:(double)entId
                                  delegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 删除车辆
 */
+(void)requestDeleteCarWithId:(double)identity
                          entId:(double)entId
                       delegate:(id <RequestDelegate>)delegate
                        success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 车辆详情
 */
+(void)requestCarDetailWithId:(double)identity
                        entId:(double)entId
                     delegate:(id <RequestDelegate>)delegate
                      success:(void (^)(NSDictionary * response, id mark))success
                      failure:(void (^)(NSString * errorStr, id mark))failure;
/**
提交我的车辆
*/
+(void)requestAddCarWithVin:(NSString *)vin
                engineNumber:(NSString *)engineNumber
                vehicleNumber:(NSString *)vehicleNumber
                licenceType:(double)licenceType
                trailerNumber:(NSString *)trailerNumber
                vehicleLicense:(NSString *)vehicleLicense
                vehicleLength:(double)vehicleLength
                vehicleType:(double)vehicleType
                vehicleLoad:(double)vehicleLoad
                axle:(double)axle
                vehicleOwner:(NSString *)vehicleOwner
                drivingLicenseFrontUrl:(NSString *)drivingLicenseFrontUrl
                drivingLicenseNegativeUrl:(NSString *)drivingLicenseNegativeUrl
                vehicleInsuranceUrl:(NSString *)vehicleInsuranceUrl
                vehicleTripartiteInsuranceUrl:(NSString *)vehicleTripartiteInsuranceUrl
                trailerInsuranceUrl:(NSString *)trailerInsuranceUrl
                trailerTripartiteInsuranceUrl:(NSString *)trailerTripartiteInsuranceUrl
                trailerGoodsInsuranceUrl:(NSString *)trailerGoodsInsuranceUrl
                vehiclePhotoUrl:(NSString *)vehiclePhotoUrl
                managementLicenseUrl:(NSString *)managementLicenseUrl
                length:(double)length
                weight:(double)weight
                height:(double)height
                grossMass:(double)grossMass
                drivingNumber:(NSString *)drivingNumber
                model:(NSString *)model
                useCharacter:(NSString *)useCharacter
                energyType:(double)energyType
                roadTransportNumber:(NSString *)roadTransportNumber
                drivingAgency:(NSString *)drivingAgency
                drivingRegisterDate:(double)drivingRegisterDate
                drivingIssueDate:(double)drivingIssueDate
                drivingEndDate:(double)drivingEndDate
                driving2NegativeUrl:(NSString *)driving2NegativeUrl
                   identity:(double)identity
entId:(double)entId
   driverId:(double)driverId
driverPhone:(NSString *)driverPhone
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                    failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 车辆列表
 */
+(void)requestCarListWithDrivername:(NSString *)driverName
                        driverPhone:(NSString *)driverPhone
                      vehicleNumber:(NSString *)vehicleNumber
                               page:(double)page
                              count:(double)count
                              entId:(double)entId
                 qualificationState:(double)qualificationState
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 提交车辆
 */
+(void)requestResubmitCarWithId:(double)identity
                          entId:(double)entId
                       delegate:(id <RequestDelegate>)delegate
                        success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 司机列表
 */
+(void)requestDriverListWithEntid:(double)entId
                             page:(double)page
                            count:(double)count
                             name:(NSString *)name
                            phone:(NSString *)phone
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 司机列表（审核通过的）
 */
+(void)requestDriveListPassWithEntid:(double)entId
                                page:(double)page
                               count:(double)count
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 添加司机
 */
+(void)requestAddDriverWithPhone:(NSString *)phone
                             pwd:(NSString *)pwd
                            name:(NSString *)name
                          idCard:(NSString *)idCard
                           entId:(double)entId
                        bankName:(NSString *)bankName
                     bankAccount:(NSString *)bankAccount
                            addr:(NSString *)addr
                  idCardFrontUrl:(NSString *)idCardFrontUrl
                   idCardBackUrl:(NSString *)idCardBackUrl
                driverLicenseUrl:(NSString *)driverLicenseUrl
                 idCardHandelUrl:(NSString *)idCardHandelUrl
                        delegate:(id <RequestDelegate>)delegate
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 编辑司机
 */
+(void)requestEditDriverWithName:(NSString *)name
                          idCard:(NSString *)idCard
                           entId:(double)entId
                              id:(double)identity
                        bankName:(NSString *)bankName
                     bankAccount:(NSString *)bankAccount
                            addr:(NSString *)addr
                  idCardFrontUrl:(NSString *)idCardFrontUrl
                   idCardBackUrl:(NSString *)idCardBackUrl
                driverLicenseUrl:(NSString *)driverLicenseUrl
                 idCardHandelUrl:(NSString *)idCardHandelUrl
                        delegate:(id <RequestDelegate>)delegate
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 删除司机
 */
+(void)requestDeleteDriverWithId:(double)identity
                           entId:(double)entId
                        delegate:(id <RequestDelegate>)delegate
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 司机文件列表
 */
+(void)requestDriveFileListPassWithDriverId:(double)driverId
                                      entId:(double)entId
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 删除司机（取消挂靠）
 */
+(void)requestCancelAttachedDriverWithId:(double)identity
                                   entId:(double)entId
                                  reason:(NSString *)reason
                                delegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 同意挂靠（车队）（批量）
 */
+(void)requestAdmitAttachApplyWithEntid:(double)entId
                                    ids:(NSString *)ids
                                 reason:(NSString *)reason
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 拒绝挂靠（车队）（批量）
 */
+(void)requestRejectAttachApplyWithEntid:(double)entId
                                     ids:(NSString *)ids
                                  reason:(NSString *)reason
                                delegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 新增组织（运输公司）（认证文件参数化）
 */
+(void)requestAddTransportCompanyWithLogourl:(NSString *)logoUrl
                             businessLicense:(NSString *)businessLicense
                              identityNumber:(NSString *)identityNumber
                              officeCountyId:(double)officeCountyId
                                   legalName:(NSString *)legalName
                                 officeEmail:(NSString *)officeEmail
                                 officePhone:(NSString *)officePhone
                                        name:(NSString *)name
                            officeAddrDetail:(NSString *)officeAddrDetail
                           managementLicense:(NSString *)managementLicense
                          businessLicenseUrl:(NSString *)businessLicenseUrl
                              idCardFrontUrl:(NSString *)idCardFrontUrl
                           idCardNegativeUrl:(NSString *)idCardNegativeUrl
                        managementLicenseUrl:(NSString *)managementLicenseUrl
                                    delegate:(id <RequestDelegate>)delegate
                                     success:(void (^)(NSDictionary * response, id mark))success
                                     failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 新增组织（个体车主）（认证文件参数化）
 */
+(void)requestAddSelfCompanyWithBusinesslicense:(NSString *)businessLicense
                                           name:(NSString *)name
                                 idCardFrontUrl:(nullable NSString *)idCardFrontUrl
                              idCardNegativeUrl:(nullable NSString *)idCardNegativeUrl
                              idCardHandheldUrl:(nullable NSString *)idCardHandheldUrl
                               driverLicenseUrl:(NSString *)driverLicenseUrl
                                       delegate:(id <RequestDelegate>)delegate
                                        success:(void (^)(NSDictionary * response, id mark))success
                                        failure:(void (^)(NSString * errorStr, id mark))failure;


+(void)requestAuthorityImageWithEntid:(double)entId
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 审核失败重新提交（运输公司)
 */
+(void)requestReAddTransportCompanyWithLogourl:(NSString *)logoUrl
                               businessLicense:(NSString *)businessLicense
                                identityNumber:(NSString *)identityNumber
                                officeCountyId:(double)officeCountyId
                                     legalName:(NSString *)legalName
                                   officeEmail:(NSString *)officeEmail
                                   officePhone:(NSString *)officePhone
                                          name:(NSString *)name
                              officeAddrDetail:(NSString *)officeAddrDetail
                             managementLicense:(NSString *)managementLicense
                            businessLicenseUrl:(NSString *)businessLicenseUrl
                                idCardFrontUrl:(NSString *)idCardFrontUrl
                             idCardNegativeUrl:(NSString *)idCardNegativeUrl
                          managementLicenseUrl:(NSString *)managementLicenseUrl
                                            id:(double)identity
                                      delegate:(id <RequestDelegate>)delegate
                                       success:(void (^)(NSDictionary * response, id mark))success
                                       failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 重新提交（个体车主）（认证文件参数化）
 */
+(void)requestReAddSelfCompanyWithBusinesslicense:(NSString *)businessLicense
                                             name:(NSString *)name
                                   idCardFrontUrl:(nullable NSString *)idCardFrontUrl
                                idCardNegativeUrl:(nullable NSString *)idCardNegativeUrl
                                idCardHandheldUrl:(nullable NSString *)idCardHandheldUrl
                                 driverLicenseUrl:(NSString *)driverLicenseUrl
                                               id:(double)identity
                                         delegate:(id <RequestDelegate>)delegate
                                          success:(void (^)(NSDictionary * response, id mark))success
                                          failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 挂靠申请列表（车队）
 */
+(void)requestAttachApplyListWithEntid:(double)entId
                             cellPhone:(NSString *)cellPhone
                              realName:(NSString *)realName
                                 state:(NSString *)state
                             startTime:(double)startTime
                               endTime:(double)endTime
                                  page:(double)page
                                 count:(double)count
                              delegate:(id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 挂靠详情（车队）
 */
+(void)requestAttachInfoWithId:(double)identity
                         entId:(double)entId
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 挂靠司机列表（车队）（挂靠）
 */
+(void)requestrequestAttachedDriverListWithEntidWithEntid:(double)entId
                                                     page:(double)page
                                                    count:(double)count
                                               driverName:(NSString *)driverName
                                              driverPhone:(NSString *)driverPhone
                                                 delegate:(id <RequestDelegate>)delegate
                                                  success:(void (^)(NSDictionary * response, id mark))success
                                                  failure:(void (^)(NSString * errorStr, id mark))failure;
@end

NS_ASSUME_NONNULL_END
