//
//  ModelAuthorityRecordListItem.m
//
//  Created by sld s on 2019/6/3
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelAuthorityRecordListItem.h"


NSString *const kModelAuthorityRecordListItemUserId = @"userId";
NSString *const kModelAuthorityRecordListItemReviewTime = @"reviewTime";
NSString *const kModelAuthorityRecordListItemId = @"id";
NSString *const kModelAuthorityRecordListItemSubmitTime = @"submitTime";
NSString *const kModelAuthorityRecordListItemEntId = @"entId";
NSString *const kModelAuthorityRecordListItemDescription = @"description";
NSString *const kModelAuthorityRecordListItemReviewerId = @"reviewerId";
NSString *const kModelAuthorityRecordListItemState = @"state";
NSString *const kModelAuthorityRecordListItemOfficeProvinceName = @"officeProvinceName";
NSString *const kModelAuthorityRecordListItemBusinessLicense = @"businessLicense";
NSString *const kModelAuthorityRecordListItemOfficeCountyId = @"officeCountyId";
NSString *const kModelAuthorityRecordListItemOfficeProvinceId = @"officeProvinceId";
NSString *const kModelAuthorityRecordListItemOfficeCityName = @"officeCityName";
NSString *const kModelAuthorityRecordListItemLegalName = @"legalName";
NSString *const kModelAuthorityRecordListItemOfficePhone = @"officePhone";
NSString *const kModelAuthorityRecordListItemIdentityNumber = @"identityNumber";
NSString *const kModelAuthorityRecordListItemLogoUrl = @"logoUrl";
NSString *const kModelAuthorityRecordListItemOfficeCityId = @"officeCityId";
NSString *const kModelAuthorityRecordListItemManagementLicense = @"managementLicense";
NSString *const kModelAuthorityRecordListItemOfficeEmail = @"officeEmail";
NSString *const kModelAuthorityRecordListItemSubmitterName = @"submitterName";
NSString *const kModelAuthorityRecordListItemOfficeAddrDetail = @"officeAddrDetail";
NSString *const kModelAuthorityRecordListItemSubmitterId = @"submitterId";
NSString *const kModelAuthorityRecordListItemOfficeCountyName = @"officeCountyName";
NSString *const kModelAuthorityRecordListItemName = @"name";
NSString *const kModelAuthorityRecordListItemSimpleName = @"simpleName";

@interface ModelAuthorityRecordListItem ()
@end

@implementation ModelAuthorityRecordListItem

@synthesize userId = _userId;
@synthesize reviewTime = _reviewTime;
@synthesize iDProperty = _iDProperty;
@synthesize submitTime = _submitTime;
@synthesize entId = _entId;
@synthesize iDPropertyDescription = _iDPropertyDescription;
@synthesize reviewerId = _reviewerId;
@synthesize state = _state;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.userId = [dict doubleValueForKey:kModelAuthorityRecordListItemUserId];
            self.reviewTime = [dict doubleValueForKey:kModelAuthorityRecordListItemReviewTime];
            self.iDProperty = [dict doubleValueForKey:kModelAuthorityRecordListItemId];
            self.submitTime = [dict doubleValueForKey:kModelAuthorityRecordListItemSubmitTime];
            self.entId = [dict doubleValueForKey:kModelAuthorityRecordListItemEntId];
            self.iDPropertyDescription = [dict stringValueForKey:kModelAuthorityRecordListItemDescription];
            self.reviewerId = [dict doubleValueForKey:kModelAuthorityRecordListItemReviewerId];
            self.state = [dict doubleValueForKey:kModelAuthorityRecordListItemState];
        self.officeProvinceName = [dict stringValueForKey:kModelAuthorityRecordListItemOfficeProvinceName];
        self.businessLicense = [dict stringValueForKey:kModelAuthorityRecordListItemBusinessLicense];
        self.officeCountyId = [dict doubleValueForKey:kModelAuthorityRecordListItemOfficeCountyId];
        self.officeProvinceId = [dict doubleValueForKey:kModelAuthorityRecordListItemOfficeProvinceId];
        self.officeCityName = [dict stringValueForKey:kModelAuthorityRecordListItemOfficeCityName];
        self.legalName = [dict stringValueForKey:kModelAuthorityRecordListItemLegalName];
        self.officePhone = [dict stringValueForKey:kModelAuthorityRecordListItemOfficePhone];
        self.identityNumber = [dict stringValueForKey:kModelAuthorityRecordListItemIdentityNumber];
        self.logoUrl = [dict stringValueForKey:kModelAuthorityRecordListItemLogoUrl];
        self.officeCityId = [dict doubleValueForKey:kModelAuthorityRecordListItemOfficeCityId];
        self.managementLicense = [dict stringValueForKey:kModelAuthorityRecordListItemManagementLicense];
        self.officeEmail = [dict stringValueForKey:kModelAuthorityRecordListItemOfficeEmail];
        self.submitterName = [dict stringValueForKey:kModelAuthorityRecordListItemSubmitterName];
        self.officeAddrDetail = [dict stringValueForKey:kModelAuthorityRecordListItemOfficeAddrDetail];
        self.submitterId = [dict doubleValueForKey:kModelAuthorityRecordListItemSubmitterId];
        self.officeCountyName = [dict stringValueForKey:kModelAuthorityRecordListItemOfficeCountyName];
        self.name = [dict stringValueForKey:kModelAuthorityRecordListItemName];
        self.simpleName = [dict stringValueForKey:kModelAuthorityRecordListItemSimpleName];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelAuthorityRecordListItemUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewTime] forKey:kModelAuthorityRecordListItemReviewTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelAuthorityRecordListItemId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitTime] forKey:kModelAuthorityRecordListItemSubmitTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.entId] forKey:kModelAuthorityRecordListItemEntId];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelAuthorityRecordListItemDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewerId] forKey:kModelAuthorityRecordListItemReviewerId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.state] forKey:kModelAuthorityRecordListItemState];
    [mutableDict setValue:self.officeProvinceName forKey:kModelAuthorityRecordListItemOfficeProvinceName];
    [mutableDict setValue:self.businessLicense forKey:kModelAuthorityRecordListItemBusinessLicense];
    [mutableDict setValue:[NSNumber numberWithDouble:self.officeCountyId] forKey:kModelAuthorityRecordListItemOfficeCountyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.officeProvinceId] forKey:kModelAuthorityRecordListItemOfficeProvinceId];
    [mutableDict setValue:self.officeCityName forKey:kModelAuthorityRecordListItemOfficeCityName];
    [mutableDict setValue:self.legalName forKey:kModelAuthorityRecordListItemLegalName];
    [mutableDict setValue:self.officePhone forKey:kModelAuthorityRecordListItemOfficePhone];
    [mutableDict setValue:self.identityNumber forKey:kModelAuthorityRecordListItemIdentityNumber];
    [mutableDict setValue:self.logoUrl forKey:kModelAuthorityRecordListItemLogoUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.officeCityId] forKey:kModelAuthorityRecordListItemOfficeCityId];
    [mutableDict setValue:self.managementLicense forKey:kModelAuthorityRecordListItemManagementLicense];
    [mutableDict setValue:self.officeEmail forKey:kModelAuthorityRecordListItemOfficeEmail];
    [mutableDict setValue:self.submitterName forKey:kModelAuthorityRecordListItemSubmitterName];
    [mutableDict setValue:self.officeAddrDetail forKey:kModelAuthorityRecordListItemOfficeAddrDetail];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitterId] forKey:kModelAuthorityRecordListItemSubmitterId];
    [mutableDict setValue:self.officeCountyName forKey:kModelAuthorityRecordListItemOfficeCountyName];
    [mutableDict setValue:self.name forKey:kModelAuthorityRecordListItemName];
    [mutableDict setValue:self.simpleName forKey:kModelAuthorityRecordListItemSimpleName];
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
