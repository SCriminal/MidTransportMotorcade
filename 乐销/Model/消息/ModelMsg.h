//
//  ModelMsg.h
//
//  Created by 林栋 隋 on 2019/6/26
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelMsg : NSObject

@property (nonatomic, assign) double isRead;
@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double src;
@property (nonatomic, assign) double type;
@property (nonatomic, assign) double total;
@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) double state;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
