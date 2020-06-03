//
//  ModelMsg.m
//
//  Created by 林栋 隋 on 2019/6/26
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelMsg.h"


NSString *const kModelMsgIsRead = @"isRead";
NSString *const kModelMsgAlias = @"alias";
NSString *const kModelMsgContent = @"content";
NSString *const kModelMsgId = @"id";
NSString *const kModelMsgSrc = @"src";
NSString *const kModelMsgType = @"type";
NSString *const kModelMsgTotal = @"total";
NSString *const kModelMsgCreateTime = @"createTime";
NSString *const kModelMsgState = @"state";


@interface ModelMsg ()
@end

@implementation ModelMsg

@synthesize isRead = _isRead;
@synthesize alias = _alias;
@synthesize content = _content;
@synthesize iDProperty = _iDProperty;
@synthesize src = _src;
@synthesize type = _type;
@synthesize total = _total;
@synthesize createTime = _createTime;
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
            self.isRead = [dict doubleValueForKey:kModelMsgIsRead];
            self.alias = [dict stringValueForKey:kModelMsgAlias];
            self.content = [dict stringValueForKey:kModelMsgContent];
            self.iDProperty = [dict doubleValueForKey:kModelMsgId];
            self.src = [dict doubleValueForKey:kModelMsgSrc];
            self.type = [dict doubleValueForKey:kModelMsgType];
            self.total = [dict doubleValueForKey:kModelMsgTotal];
            self.createTime = [dict doubleValueForKey:kModelMsgCreateTime];
            self.state = [dict doubleValueForKey:kModelMsgState];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isRead] forKey:kModelMsgIsRead];
    [mutableDict setValue:self.alias forKey:kModelMsgAlias];
    [mutableDict setValue:self.content forKey:kModelMsgContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelMsgId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.src] forKey:kModelMsgSrc];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kModelMsgType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.total] forKey:kModelMsgTotal];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelMsgCreateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.state] forKey:kModelMsgState];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
