//
//  ModelStatistic.h
//
//  Created by 林栋 隋 on 2019/6/12
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelStatistic : NSObject

@property (nonatomic, assign) double payableFee;
@property (nonatomic, assign) double receivableFee;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
