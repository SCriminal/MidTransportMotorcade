//
//  ModelAuthorityRecordListItem.h
//
//  Created by sld s on 2019/6/3
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAuthorityRecordListItem : NSObject

@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double reviewTime;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double submitTime;
@property (nonatomic, assign) double entId;
@property (nonatomic, strong) NSString *iDPropertyDescription;
@property (nonatomic, assign) double reviewerId;
@property (nonatomic, assign) double state;
@property (nonatomic, strong) NSString *officeProvinceName;
@property (nonatomic, strong) NSString *businessLicense;
@property (nonatomic, assign) double officeCountyId;
@property (nonatomic, assign) double officeProvinceId;
@property (nonatomic, strong) NSString *officeCityName;
@property (nonatomic, strong) NSString *legalName;
@property (nonatomic, strong) NSString *officePhone;
@property (nonatomic, strong) NSString *identityNumber;
@property (nonatomic, strong) NSString *logoUrl;
@property (nonatomic, assign) double officeCityId;
@property (nonatomic, strong) NSString *managementLicense;
@property (nonatomic, strong) NSString *officeEmail;
@property (nonatomic, strong) NSString *submitterName;
@property (nonatomic, strong) NSString *officeAddrDetail;
@property (nonatomic, assign) double submitterId;
@property (nonatomic, strong) NSString *officeCountyName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *simpleName;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
