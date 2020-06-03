//
//  ModelAttachApplyList.h
//
//  Created by 林栋 隋 on 2019/12/11
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAttachApplyList : NSObject

@property (nonatomic, strong) NSString *cellPhone;
@property (nonatomic, assign) double reviewTime;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, assign) double applyTime;
@property (nonatomic, assign) double entId;
@property (nonatomic, strong) NSString *contactPhone;
@property (nonatomic, assign) double state;
@property (nonatomic, strong) NSString *driverLicense;
@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double qualificationState;
@property (nonatomic, assign) double createTime;

@property (nonatomic, readonly) NSString *authStatusShow;
@property (nonatomic, readonly) UIColor *authStatusColorShow;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
