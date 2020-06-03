//
//  ModelUser.h
//
//  Created by sld s on 2019/5/17
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelUser : NSObject

@property (nonatomic, strong) NSString *account;
@property (nonatomic, assign) double userId;
@property (nonatomic, strong) NSString *headUrl;
@property (nonatomic, assign) double userStatus;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, assign) double userType;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, assign) double authStatus;
@property (nonatomic, strong) NSString *introduce;

//logical
@property (nonatomic, readonly) NSString *authStatusShow;

+ (void)jumpToAuthorityStateVCSuccessBlock:(void (^)(void))successBlock;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
