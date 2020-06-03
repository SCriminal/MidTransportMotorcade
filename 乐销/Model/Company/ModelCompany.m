//
//  ModelCompany.m
//
//  Created by sld s on 2019/5/29
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelCompany.h"


NSString *const kModelCompanyOfficePhone = @"officePhone";
NSString *const kModelCompanyOfficeProvinceName = @"officeProvinceName";
NSString *const kModelCompanyOfficeCountyName = @"officeCountyName";
NSString *const kModelCompanyBusinessLicense = @"businessLicense";
NSString *const kModelCompanyCode = @"code";
NSString *const kModelCompanyOfficeEmail = @"officeEmail";
NSString *const kModelCompanyDataState = @"dataState";
NSString *const kModelCompanyCreateTime = @"createTime";
NSString *const kModelCompanyOfficeCityName = @"officeCityName";
NSString *const kModelCompanyLogoUrl = @"logoUrl";
NSString *const kModelCompanyName = @"name";
NSString *const kModelCompanyManagementLicense = @"managementLicense";
NSString *const kModelCompanyType = @"type";
NSString *const kModelCompanyState = @"state";
NSString *const kModelCompanyId = @"id";
NSString *const kModelCompanyIdentityNumber = @"identityNumber";
NSString *const kModelCompanySubmitTime = @"submitTime";
NSString *const kModelCompanyOfficeAddrDetail = @"officeAddrDetail";
NSString *const kModelCompanyOfficeProvinceId = @"officeProvinceId";
NSString *const kModelCompanyIsHaveFleet = @"isHaveFleet";
NSString *const kModelCompanyQualificationState = @"qualificationState";
NSString *const kModelCompanyOffcieCountyId = @"offcieCountyId";
NSString *const kModelCompanyOfficeCityId = @"officeCityId";
NSString *const kModelCompanyLegalName = @"legalName";
NSString *const kModelCompanyOfficeCountyId = @"officeCountyId";
NSString *const kModelCompanyIsEnt = @"isEnt";


@interface ModelCompany ()
@end

@implementation ModelCompany

@synthesize officePhone = _officePhone;
@synthesize officeProvinceName = _officeProvinceName;
@synthesize officeCountyName = _officeCountyName;
@synthesize businessLicense = _businessLicense;
@synthesize code = _code;
@synthesize officeEmail = _officeEmail;
@synthesize dataState = _dataState;
@synthesize officeCityName = _officeCityName;
@synthesize logoUrl = _logoUrl;
@synthesize name = _name;
@synthesize managementLicense = _managementLicense;
@synthesize type = _type;
@synthesize state = _state;
@synthesize iDProperty = _iDProperty;
@synthesize identityNumber = _identityNumber;
@synthesize submitTime = _submitTime;
@synthesize officeAddrDetail = _officeAddrDetail;
@synthesize officeProvinceId = _officeProvinceId;
@synthesize isHaveFleet = _isHaveFleet;
@synthesize qualificationState = _qualificationState;
@synthesize offcieCountyId = _offcieCountyId;
@synthesize officeCityId = _officeCityId;
@synthesize legalName = _legalName;

#pragma mark logical show
- (NSString *)authStatusShow{
    if (self.isEnt) {
        switch ((int)self.qualificationState) {
            case 1:
                return @"未审核";
                break;
            case 2:
                return @"修改已提交";
                break;
            case 3:
                return @"已认证";
                break;
            case 10:
                return @"修改已驳回";
                break;
            default:
                break;
        }
    }
    switch ((int)self.qualificationState) {
        case 1:
            return @"未审核";
            break;
        case 2:
            return @"审核中";
            break;
        case 3:
            return @"审核成功";
            break;
        case 10:
            return @"审核拒绝";
            break;
        default:
            break;
    }
    return @"";
}
#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.officePhone = [dict stringValueForKey:kModelCompanyOfficePhone];
        self.officeProvinceName = [dict stringValueForKey:kModelCompanyOfficeProvinceName];
        self.officeCountyName = [dict stringValueForKey:kModelCompanyOfficeCountyName];
        self.businessLicense = [dict stringValueForKey:kModelCompanyBusinessLicense];
        self.code = [dict stringValueForKey:kModelCompanyCode];
        self.officeEmail = [dict stringValueForKey:kModelCompanyOfficeEmail];
        self.dataState = [dict doubleValueForKey:kModelCompanyDataState];
        self.createTime = [dict stringValueForKey:kModelCompanyCreateTime];
        self.officeCityName = [dict stringValueForKey:kModelCompanyOfficeCityName];
        self.logoUrl = [dict stringValueForKey:kModelCompanyLogoUrl];
        self.name = [dict stringValueForKey:kModelCompanyName];
        self.managementLicense = [dict stringValueForKey:kModelCompanyManagementLicense];
        self.type = [dict doubleValueForKey:kModelCompanyType];
        self.state = [dict doubleValueForKey:kModelCompanyState];
        self.iDProperty = [dict doubleValueForKey:kModelCompanyId];
        self.identityNumber = [dict stringValueForKey:kModelCompanyIdentityNumber];
        self.submitTime = [dict doubleValueForKey:kModelCompanySubmitTime];
        self.officeAddrDetail = [dict stringValueForKey:kModelCompanyOfficeAddrDetail];
        self.officeProvinceId = [dict doubleValueForKey:kModelCompanyOfficeProvinceId];
        self.isHaveFleet = [dict doubleValueForKey:kModelCompanyIsHaveFleet];
        self.qualificationState = [dict doubleValueForKey:kModelCompanyQualificationState];
        self.offcieCountyId = [dict doubleValueForKey:kModelCompanyOffcieCountyId];
        self.officeCityId = [dict doubleValueForKey:kModelCompanyOfficeCityId];
        self.legalName = [dict stringValueForKey:kModelCompanyLegalName];
        self.officeCountyId = [dict doubleValueForKey:kModelCompanyOfficeCountyId];
        self.isEnt = [dict doubleValueForKey:kModelCompanyIsEnt];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.officePhone forKey:kModelCompanyOfficePhone];
    [mutableDict setValue:self.officeProvinceName forKey:kModelCompanyOfficeProvinceName];
    [mutableDict setValue:self.officeCountyName forKey:kModelCompanyOfficeCountyName];
    [mutableDict setValue:self.businessLicense forKey:kModelCompanyBusinessLicense];
    [mutableDict setValue:self.code forKey:kModelCompanyCode];
    [mutableDict setValue:self.officeEmail forKey:kModelCompanyOfficeEmail];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dataState] forKey:kModelCompanyDataState];
    [mutableDict setValue:self.createTime forKey:kModelCompanyCreateTime];
    [mutableDict setValue:self.officeCityName forKey:kModelCompanyOfficeCityName];
    [mutableDict setValue:self.logoUrl forKey:kModelCompanyLogoUrl];
    [mutableDict setValue:self.name forKey:kModelCompanyName];
    [mutableDict setValue:self.managementLicense forKey:kModelCompanyManagementLicense];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kModelCompanyType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.state] forKey:kModelCompanyState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelCompanyId];
    [mutableDict setValue:self.identityNumber forKey:kModelCompanyIdentityNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitTime] forKey:kModelCompanySubmitTime];
    [mutableDict setValue:self.officeAddrDetail forKey:kModelCompanyOfficeAddrDetail];
    [mutableDict setValue:[NSNumber numberWithDouble:self.officeProvinceId] forKey:kModelCompanyOfficeProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isHaveFleet] forKey:kModelCompanyIsHaveFleet];
    [mutableDict setValue:[NSNumber numberWithDouble:self.qualificationState] forKey:kModelCompanyQualificationState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.offcieCountyId] forKey:kModelCompanyOffcieCountyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.officeCityId] forKey:kModelCompanyOfficeCityId];
    [mutableDict setValue:self.legalName forKey:kModelCompanyLegalName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.officeCountyId] forKey:kModelCompanyOfficeCountyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isEnt] forKey:kModelCompanyIsEnt];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
