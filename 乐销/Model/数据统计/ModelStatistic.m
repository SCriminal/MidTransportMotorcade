//
//  ModelStatistic.m
//
//  Created by 林栋 隋 on 2019/6/12
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelStatistic.h"


NSString *const kModelStatisticPayableFee = @"payableFee";
NSString *const kModelStatisticReceivableFee = @"receivableFee";


@interface ModelStatistic ()
@end

@implementation ModelStatistic

@synthesize payableFee = _payableFee;
@synthesize receivableFee = _receivableFee;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.payableFee = [dict doubleValueForKey:kModelStatisticPayableFee];
            self.receivableFee = [dict doubleValueForKey:kModelStatisticReceivableFee];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.payableFee] forKey:kModelStatisticPayableFee];
    [mutableDict setValue:[NSNumber numberWithDouble:self.receivableFee] forKey:kModelStatisticReceivableFee];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
