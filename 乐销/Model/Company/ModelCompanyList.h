//
//  ModelCompanyList.h
//
//  Created by 林栋 隋 on 2019/6/14
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelCompanyList : NSObject

@property (nonatomic, strong) NSString *logoUrl;
@property (nonatomic, assign) double qualificationState;
@property (nonatomic, assign) double entId;
@property (nonatomic, strong) NSString *entName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
