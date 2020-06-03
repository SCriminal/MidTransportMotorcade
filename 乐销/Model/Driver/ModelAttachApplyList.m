//
//  ModelAttachApplyList.m
//
//  Created by 林栋 隋 on 2019/12/11
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelAttachApplyList.h"


NSString *const kModelAttachApplyListCellPhone = @"cellPhone";
NSString *const kModelAttachApplyListReviewTime = @"reviewTime";
NSString *const kModelAttachApplyListId = @"id";
NSString *const kModelAttachApplyListRealName = @"realName";
NSString *const kModelAttachApplyListApplyTime = @"applyTime";
NSString *const kModelAttachApplyListEntId = @"entId";
NSString *const kModelAttachApplyListContactPhone = @"contactPhone";
NSString *const kModelAttachApplyListState = @"state";
NSString *const kModelAttachApplyListDriverLicense = @"driverLicense";
NSString *const kModelAttachApplyListUserId = @"userId";
NSString *const kModelAttachApplyListQualificationState = @"qualificationState";
NSString *const kModelAttachApplyListCreateTime = @"createTime";


@interface ModelAttachApplyList ()
@end

@implementation ModelAttachApplyList

@synthesize cellPhone = _cellPhone;
@synthesize reviewTime = _reviewTime;
@synthesize iDProperty = _iDProperty;
@synthesize realName = _realName;
@synthesize applyTime = _applyTime;
@synthesize entId = _entId;
@synthesize contactPhone = _contactPhone;
@synthesize state = _state;
@synthesize driverLicense = _driverLicense;

- (NSString *)authStatusShow{
    switch ((int)self.state) {
        case 1:
            return @"已申请";
            break;
        case 10:
            return @"已挂靠";
            break;
        case 21:
            return @"已拒绝";
            break;
        default:
            break;
    }
    return @"";
}
- (UIColor *)authStatusColorShow{

    switch ((int)self.state) {
        case 1:
            return COLOR_ORANGE;
            break;
        case 10:
            return COLOR_GREEN;
            break;
        case 21:
            return [UIColor redColor];
            break;
        default:
            break;
    }
    return COLOR_ORANGE;
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
            self.cellPhone = [dict stringValueForKey:kModelAttachApplyListCellPhone];
            self.reviewTime = [dict doubleValueForKey:kModelAttachApplyListReviewTime];
            self.iDProperty = [dict doubleValueForKey:kModelAttachApplyListId];
            self.realName = [dict stringValueForKey:kModelAttachApplyListRealName];
            self.applyTime = [dict doubleValueForKey:kModelAttachApplyListApplyTime];
            self.entId = [dict doubleValueForKey:kModelAttachApplyListEntId];
            self.contactPhone = [dict stringValueForKey:kModelAttachApplyListContactPhone];
            self.state = [dict doubleValueForKey:kModelAttachApplyListState];
            self.driverLicense = [dict stringValueForKey:kModelAttachApplyListDriverLicense];
        self.userId = [dict doubleValueForKey:kModelAttachApplyListUserId];
        self.qualificationState = [dict doubleValueForKey:kModelAttachApplyListQualificationState];
        self.createTime = [dict doubleValueForKey:kModelAttachApplyListCreateTime];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cellPhone forKey:kModelAttachApplyListCellPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewTime] forKey:kModelAttachApplyListReviewTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelAttachApplyListId];
    [mutableDict setValue:self.realName forKey:kModelAttachApplyListRealName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.applyTime] forKey:kModelAttachApplyListApplyTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.entId] forKey:kModelAttachApplyListEntId];
    [mutableDict setValue:self.contactPhone forKey:kModelAttachApplyListContactPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.state] forKey:kModelAttachApplyListState];
    [mutableDict setValue:self.driverLicense forKey:kModelAttachApplyListDriverLicense];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelAttachApplyListUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.qualificationState] forKey:kModelAttachApplyListQualificationState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelAttachApplyListCreateTime];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
