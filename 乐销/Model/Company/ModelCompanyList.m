//
//  ModelCompanyList.m
//
//  Created by 林栋 隋 on 2019/6/14
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelCompanyList.h"


NSString *const kModelCompanyListLogoUrl = @"logoUrl";
NSString *const kModelCompanyListQualificationState = @"qualificationState";
NSString *const kModelCompanyListEntType = @"entType";
NSString *const kModelCompanyListEntId = @"entId";
NSString *const kModelCompanyListEntName = @"entName";


@interface ModelCompanyList ()
@property (nonatomic, assign) double entType;

@end

@implementation ModelCompanyList

@synthesize logoUrl = _logoUrl;
@synthesize qualificationState = _qualificationState;
@synthesize entType = _entType;
@synthesize entId = _entId;
@synthesize entName = _entName;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.logoUrl = [dict stringValueForKey:kModelCompanyListLogoUrl];
            self.qualificationState = [dict doubleValueForKey:kModelCompanyListQualificationState];
            self.entType = [dict doubleValueForKey:kModelCompanyListEntType];
            self.entId = [dict doubleValueForKey:kModelCompanyListEntId];
            self.entName = [dict stringValueForKey:kModelCompanyListEntName];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.logoUrl forKey:kModelCompanyListLogoUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.qualificationState] forKey:kModelCompanyListQualificationState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.entType] forKey:kModelCompanyListEntType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.entId] forKey:kModelCompanyListEntId];
    [mutableDict setValue:self.entName forKey:kModelCompanyListEntName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
