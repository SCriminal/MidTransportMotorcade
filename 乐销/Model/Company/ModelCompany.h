//
//  ModelCompany.h
//
//  Created by sld s on 2019/5/29
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ENUM_COMPANY_TYPE) {
    ENUM_COMPANY_TYPE_MOTORCADE = 31,
    ENUM_COMPANY_TYPE_PERSONAL_DRIVER = 32,
};

@interface ModelCompany : NSObject

@property (nonatomic, strong) NSString *officePhone;
@property (nonatomic, strong) NSString *officeProvinceName;
@property (nonatomic, strong) NSString *officeCountyName;
@property (nonatomic, strong) NSString *businessLicense;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *officeEmail;
@property (nonatomic, assign) double dataState;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *officeCityName;
@property (nonatomic, strong) NSString *logoUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *managementLicense;
@property (nonatomic, assign) double type;
@property (nonatomic, assign) double state;

@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *identityNumber;
@property (nonatomic, assign) double submitTime;
@property (nonatomic, strong) NSString *officeAddrDetail;
@property (nonatomic, assign) double officeProvinceId;
@property (nonatomic, assign) double isHaveFleet;
@property (nonatomic, assign) double qualificationState;
@property (nonatomic, assign) double offcieCountyId;
@property (nonatomic, assign) double officeCityId;
@property (nonatomic, strong) NSString *legalName;
@property (nonatomic, readonly) NSString *authStatusShow;
@property (nonatomic, assign) double officeCountyId;
@property (nonatomic, assign) double isEnt;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
