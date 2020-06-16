//
//  ModelDriver.h
//
//  Created by sld s on 2019/5/29
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelDriver : NSObject

@property (nonatomic, strong) NSString *account;
@property (nonatomic, assign) double birthday;
@property (nonatomic, assign) double userStatus;

@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) double countyId;
@property (nonatomic, strong) NSString *driverName;
@property (nonatomic, assign) double driverId;
@property (nonatomic, strong) NSString *headUrl;
@property (nonatomic, assign) double gender;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *countyName;
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, assign) double provinceId;
@property (nonatomic, strong) NSString *wxNumber;
@property (nonatomic, assign) double cityId;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *driverPhone;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *introduce;
@property (nonatomic, strong) NSString *reviewStatus;
@property (nonatomic, strong) NSString *truckNumber;
@property (nonatomic, strong) NSString *bankAccount;
@property (nonatomic, strong) NSString *addr;
@property (nonatomic, strong) NSString *bankName;
@property (nonatomic, strong) NSString *qualificationDescription;
@property (nonatomic, strong) NSString *roadTransportNumber;
@property (nonatomic, assign) double driverClass;
@property (nonatomic, strong) NSString *driverLicense;
@property (nonatomic, strong) NSString *idAddr;
@property (nonatomic, strong) NSString *driverAgency;

//logical
@property (nonatomic, readonly) NSString *authStatusShow;
@property (nonatomic, readonly) UIColor *authStatusColorShow;
@property (nonatomic, readonly) NSString *idNumberShow;
@property (nonatomic, readonly) BOOL isAuthorityReject;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
