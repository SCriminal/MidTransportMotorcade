//
//  ModelDriver.m
//
//  Created by sld s on 2019/5/29
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelDriver.h"


NSString *const kModelDriverAccount = @"account";
NSString *const kModelDriverBirthday = @"birthday";
NSString *const kModelDriverUserStatus = @"userStatus";
NSString *const kModelDriverNickname = @"nickname";
NSString *const kModelDriverContactPhone = @"contactPhone";
NSString *const kModelDriverRealName = @"realName";
NSString *const kModelDriverCreateTime = @"createTime";
NSString *const kModelDriverCountyId = @"countyId";
NSString *const kModelDriverDriverName = @"driverName";
NSString *const kModelDriverDrvierId = @"driverId";
NSString *const kModelDriverHeadUrl = @"headUrl";
NSString *const kModelDriverGender = @"gender";
NSString *const kModelDriverId = @"id";
NSString *const kModelDriverCountyName = @"countyName";
NSString *const kModelDriverIdNumber = @"idNumber";
NSString *const kModelDriverProvinceName = @"provinceName";
NSString *const kModelDriverProvinceId = @"provinceId";
NSString *const kModelDriverWxNumber = @"wxNumber";
NSString *const kModelDriverCityId = @"cityId";
NSString *const kModelDriverEmail = @"email";
NSString *const kModelDriverDriverPhone = @"driverPhone";
NSString *const kModelDriverCityName = @"cityName";
NSString *const kModelDriverAddress = @"address";
NSString *const kModelDriverIntroduce = @"introduce";
NSString *const kModelDriverReviewStatus = @"reviewStatus";
NSString *const kModelDriverTruckNumber = @"truckNumber";
NSString *const kModelDriverBankAccount = @"bankAccount";
NSString *const kModelDriverAddr = @"addr";
NSString *const kModelDriverBankName = @"bankName";
NSString *const kModelDriverQualificationDescription = @"qualificationDescription";
NSString *const kModelDriverRoadTransportNumber = @"roadTransportNumber";
NSString *const kModelDriverDriverClass = @"driverClass";
NSString *const kModelDriverDriverLicense = @"driverLicense";
NSString *const kModelDriverIdAddr = @"idAddr";
NSString *const kModelDriverDriverAgency = @"driverAgency";

@interface ModelDriver ()
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *contactPhone;
@property (nonatomic, strong) NSString *realName;
@end

@implementation ModelDriver

@synthesize account = _account;
@synthesize birthday = _birthday;
@synthesize userStatus = _userStatus;
@synthesize nickname = _nickname;
@synthesize contactPhone = _contactPhone;
@synthesize realName = _realName;
@synthesize countyId = _countyId;
@synthesize driverName = _driverName;
@synthesize driverId = _driverId;
@synthesize headUrl = _headUrl;
@synthesize gender = _gender;
@synthesize iDProperty = _iDProperty;
@synthesize countyName = _countyName;
@synthesize idNumber = _idNumber;
@synthesize provinceName = _provinceName;
@synthesize provinceId = _provinceId;
@synthesize wxNumber = _wxNumber;
@synthesize cityId = _cityId;
@synthesize email = _email;
@synthesize driverPhone = _driverPhone;
@synthesize cityName = _cityName;
@synthesize address = _address;
@synthesize introduce = _introduce;

#pragma mark logical show
- (NSString *)authStatusShow{
    switch (self.reviewStatus.intValue) {
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
            return @"审核失败";
            break;
        default:
            break;
    }
    return @"";
}
- (UIColor *)authStatusColorShow{
    switch (self.reviewStatus.intValue) {
        case 1:
        case 2:
            return COLOR_BLUE;
            break;
        case 3:
            return COLOR_GREEN;
            break;
        case 10:
            return COLOR_RED;
            break;
        default:
            break;
    }
    return COLOR_ORANGE;
}
- (BOOL)isAuthorityReject{
    return self.reviewStatus.intValue == 10;
}
- (NSString *)idNumberShow{
    if (self.idNumber.length > 8) {
        return [NSString stringWithFormat:@"%@******%@",[self.idNumber substringToIndex:4],[self.idNumber substringFromIndex:self.idNumber.length - 4]];
    }
    return self.idNumber;
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
        self.account = [dict stringValueForKey:kModelDriverAccount];
        self.birthday = [dict doubleValueForKey:kModelDriverBirthday];
        self.userStatus = [dict doubleValueForKey:kModelDriverUserStatus];
        self.nickname = [dict stringValueForKey:kModelDriverNickname];
        self.contactPhone = [dict stringValueForKey:kModelDriverContactPhone];
        self.realName = [dict stringValueForKey:kModelDriverRealName];
        self.createTime = [dict doubleValueForKey:kModelDriverCreateTime];
        self.countyId = [dict doubleValueForKey:kModelDriverCountyId];
        self.driverName = [dict stringValueForKey:kModelDriverDriverName];
        self.driverId = [dict doubleValueForKey:kModelDriverDrvierId];
        self.headUrl = [dict stringValueForKey:kModelDriverHeadUrl];
        self.gender = [dict doubleValueForKey:kModelDriverGender];
        self.iDProperty = [dict doubleValueForKey:kModelDriverId];
        self.countyName = [dict stringValueForKey:kModelDriverCountyName];
        self.idNumber = [dict stringValueForKey:kModelDriverIdNumber];
        self.provinceName = [dict stringValueForKey:kModelDriverProvinceName];
        self.provinceId = [dict doubleValueForKey:kModelDriverProvinceId];
        self.wxNumber = [dict stringValueForKey:kModelDriverWxNumber];
        self.cityId = [dict doubleValueForKey:kModelDriverCityId];
        self.email = [dict stringValueForKey:kModelDriverEmail];
        self.driverPhone = [dict stringValueForKey:kModelDriverDriverPhone];
        self.cityName = [dict stringValueForKey:kModelDriverCityName];
        self.address = [dict stringValueForKey:kModelDriverAddress];
        self.introduce = [dict stringValueForKey:kModelDriverIntroduce];
        self.reviewStatus = [dict stringValueForKey:kModelDriverReviewStatus];
        self.truckNumber = [dict stringValueForKey:kModelDriverTruckNumber];
        self.bankAccount = [dict stringValueForKey:kModelDriverBankAccount];
        self.addr = [dict stringValueForKey:kModelDriverAddr];
        self.bankName = [dict stringValueForKey:kModelDriverBankName];
        self.qualificationDescription = [dict stringValueForKey:kModelDriverQualificationDescription];
        self.roadTransportNumber = [dict stringValueForKey:kModelDriverRoadTransportNumber];
        self.driverClass = [dict doubleValueForKey:kModelDriverDriverClass];
        self.driverLicense = [dict stringValueForKey:kModelDriverDriverLicense];
        self.idAddr = [dict stringValueForKey:kModelDriverIdAddr];
        self.driverAgency = [dict stringValueForKey:kModelDriverDriverAgency];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.account forKey:kModelDriverAccount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.birthday] forKey:kModelDriverBirthday];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userStatus] forKey:kModelDriverUserStatus];
    [mutableDict setValue:self.nickname forKey:kModelDriverNickname];
    [mutableDict setValue:self.contactPhone forKey:kModelDriverContactPhone];
    [mutableDict setValue:self.realName forKey:kModelDriverRealName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelDriverCreateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countyId] forKey:kModelDriverCountyId];
    [mutableDict setValue:self.driverName forKey:kModelDriverDriverName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverId] forKey:kModelDriverDrvierId];
    [mutableDict setValue:self.headUrl forKey:kModelDriverHeadUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.gender] forKey:kModelDriverGender];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelDriverId];
    [mutableDict setValue:self.countyName forKey:kModelDriverCountyName];
    [mutableDict setValue:self.idNumber forKey:kModelDriverIdNumber];
    [mutableDict setValue:self.provinceName forKey:kModelDriverProvinceName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provinceId] forKey:kModelDriverProvinceId];
    [mutableDict setValue:self.wxNumber forKey:kModelDriverWxNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kModelDriverCityId];
    [mutableDict setValue:self.email forKey:kModelDriverEmail];
    [mutableDict setValue:self.driverPhone forKey:kModelDriverDriverPhone];
    [mutableDict setValue:self.cityName forKey:kModelDriverCityName];
    [mutableDict setValue:self.address forKey:kModelDriverAddress];
    [mutableDict setValue:self.introduce forKey:kModelDriverIntroduce];
    [mutableDict setValue:self.reviewStatus forKey:kModelDriverReviewStatus];
    [mutableDict setValue:self.truckNumber forKey:kModelDriverTruckNumber];
    [mutableDict setValue:self.bankAccount forKey:kModelDriverBankAccount];
    [mutableDict setValue:self.addr forKey:kModelDriverAddr];
    [mutableDict setValue:self.bankName forKey:kModelDriverBankName];
    [mutableDict setValue:self.qualificationDescription forKey:kModelDriverQualificationDescription];
    [mutableDict setValue:self.roadTransportNumber forKey:kModelDriverRoadTransportNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverClass] forKey:kModelDriverDriverClass];
    [mutableDict setValue:self.driverLicense forKey:kModelDriverDriverLicense];
    [mutableDict setValue:self.idAddr forKey:kModelDriverIdAddr];
    [mutableDict setValue:self.driverAgency forKey:kModelDriverDriverAgency];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
