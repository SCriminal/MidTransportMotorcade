//
//  ModelPackageInfo.h
//
//  Created by sld s on 2019/5/25
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelPackageInfo : NSObject

@property (nonatomic, assign) double state;
@property (nonatomic, assign) double weightId;
@property (nonatomic, assign) double contractId;
@property (nonatomic, assign) double cargoId;
@property (nonatomic, assign) double transportWaybillId;
@property (nonatomic, strong) NSString *contractNumber;
@property (nonatomic, assign) double containerType;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) double truckWaybillId;
@property (nonatomic, assign) double trustWaybillId;
@property (nonatomic, assign) double backMode;
@property (nonatomic, strong) NSString *cargoName;
@property (nonatomic, assign) double waybillCargoId;
@property (nonatomic, strong) NSString *sealNumber;
@property (nonatomic, strong) NSString *containerNumber;
@property (nonatomic, assign) double cargoState;
@property (nonatomic, assign) double shipperId;
@property (nonatomic, assign) double stuffTime;
@property (nonatomic, assign) double finishTime;
@property (nonatomic, strong) NSString *driverPhone;
@property (nonatomic, assign) double toFactoryTime;
@property (nonatomic, assign) double handleTime;
@property (nonatomic, assign) double acceptTime;
@property (nonatomic, assign) double driverUserId;
@property (nonatomic, strong) NSString *truckNumber;
@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) double truckId;
@property (nonatomic, strong) NSString *driverName;
@property (nonatomic, assign) double waybillId;

//logical
@property (nonatomic, strong) NSString *packageNum;
@property (nonatomic, strong) NSString *plumbumNum;

@property (nonatomic, readonly) NSString *weightShow;
@property (nonatomic, readonly) NSString *backTypeShow;
@property (nonatomic, readonly) NSString *containerTypeShow;
@property (nonatomic, assign) bool isSelected;
@property (nonatomic, readonly) BOOL isTransporting;//是否正在运输 显示车辆位置
+ (NSString *)transformNameWithPackageState:(int)state orderType:(ENUM_ORDER_TYPE)orderType;
+ (UIColor *)transformColorWithPackageState:(int)state ;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
