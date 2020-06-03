//
//  ModelPackageInfo.m
//
//  Created by sld s on 2019/5/25
//  Copyright (c) 2019 __MyCompanyName__. All rights reserved.
//

#import "ModelPackageInfo.h"


NSString *const kModelPackageInfoState = @"state";
NSString *const kModelPackageInfoWeightId = @"weightId";
NSString *const kModelPackageInfoContractId = @"contractId";
NSString *const kModelPackageInfoCargoId = @"cargoId";
NSString *const kModelPackageInfoTransportWaybillId = @"transportWaybillId";
NSString *const kModelPackageInfoContractNumber = @"contractNumber";
NSString *const kModelPackageInfoContainerType = @"containerType";
NSString *const kModelPackageInfoPrice = @"price";
NSString *const kModelPackageInfoTruckWaybillId = @"truckWaybillId";
NSString *const kModelPackageInfoTrustWaybillId = @"trustWaybillId";
NSString *const kModelPackageInfoBackMode = @"backMode";
NSString *const kModelPackageInfoCargoName = @"cargoName";
NSString *const kModelPackageInfoWaybillCargoId = @"waybillCargoId";
NSString *const kModelPackageInfoSealNumber = @"sealNumber";
NSString *const kModelPackageInfoContainerNumber = @"containerNumber";
NSString *const kModelPackageInfoCargoState = @"cargoState";
NSString *const kModelPackageInfoShipperId = @"shipperId";
NSString *const kModelPackageInfoStuffTime = @"stuffTime";
NSString *const kModelPackageInfoFinishTime = @"finishTime";
NSString *const kModelPackageInfoDriverPhone = @"driverPhone";
NSString *const kModelPackageInfoToFactoryTime = @"toFactoryTime";
NSString *const kModelPackageInfoHandleTime = @"handleTime";
NSString *const kModelPackageInfoAcceptTime = @"acceptTime";
NSString *const kModelPackageInfoDriverUserId = @"driverUserId";
NSString *const kModelPackageInfoTruckNumber = @"truckNumber";
NSString *const kModelPackageInfoCreateTime = @"createTime";
NSString *const kModelPackageInfoTruckId = @"truckId";
NSString *const kModelPackageInfoDriverName = @"driverName";
NSString *const kModelPackageInfoWaybillId = @"waybillId";

@interface ModelPackageInfo ()
@end

@implementation ModelPackageInfo

@synthesize state = _state;
@synthesize weightId = _weightId;
@synthesize contractId = _contractId;
@synthesize cargoId = _cargoId;
@synthesize transportWaybillId = _transportWaybillId;
@synthesize contractNumber = _contractNumber;
@synthesize containerType = _containerType;
@synthesize price = _price;
@synthesize truckWaybillId = _truckWaybillId;
@synthesize trustWaybillId = _trustWaybillId;
@synthesize backMode = _backMode;
@synthesize cargoName = _cargoName;
@synthesize waybillCargoId = _waybillCargoId;


- (NSString *)weightShow{
    if (self.weightId == 1) {
        return @"10吨以下";
    }
    if (self.weightId == 2) {
        return @"10吨-20吨";
    }
    if (self.weightId == 3) {
        return @"20-25吨";
    }
    if (self.weightId == 4) {
        return @"25-28吨";
    }
    if (self.weightId == 5) {
        return @"28吨以上";
    }
    return @"";
}

- (NSString *)containerTypeShow{
    static NSMutableDictionary * dicTyps = nil;
    if (!dicTyps) {
        NSMutableArray * aryLocal = [GlobalMethod readAry:LOCAL_PACKAGE_TYPE modelName:@"ModelPackageType"];
        if (isAry(aryLocal)) {
            dicTyps = [aryLocal exchangeDicWithKeyPath:@"iDProperty"];
        }
    }
    if (isDic(dicTyps)) {
        ModelPackageType * model = [dicTyps objectForKey:[NSNumber numberWithInt:self.containerType]];
        if (model && [model isKindOfClass:ModelPackageType.class]) {
            return model.name;
        }
    }
    if (self.containerType == 1) {
        return @"20GP";
    }
    if (self.containerType == 2) {
        return @"40GP";
    }
    if (self.containerType == 3) {
        return @"40HC";
    }
    if (self.containerType == 4) {
        return @"20HC";
    }
    if (self.containerType == 5) {
        return @"20RF";
    }
    if (self.containerType == 6) {
        return @"20TK";
    }
    if (self.containerType == 7) {
        return @"20OT";
    }
    if (self.containerType == 8) {
        return @"40RF";
    }
    if (self.containerType == 9) {
        return @"40TK";
    }
    if (self.containerType == 10) {
        return @"40OT";
    }
    if (self.containerType == 11) {
        return @"45GP";
    }
    if (self.containerType == 12) {
        return @"45HC";
    }
    if (self.containerType == 13) {
        return @"45RF";
    }
    if (self.containerType == 14) {
        return @"45TK";
    }
    if (self.containerType == 15) {
        return @"45OT";
    }
    return @"";
}
- (NSString *)backTypeShow{
    if (self.containerType == 1) {
        return @"单背";
    }
    if (self.containerType == 2) {
        return @"双背";
    }
    return @"";
}

+(NSString *)transformNameWithPackageState:(int)state orderType:(ENUM_ORDER_TYPE)orderType{
    switch (state) {
        case 1:
            return @"待平台接单";
            break;
        case 2:
            return @"待平台派车队";
            break;
        case 3:
            return @"待车队接单";
            break;
        case 4:
            return @"待车队分派司机";
            break;
      
        case 5:
            return @"待司机接单";
            break;
        case 6:
            return @"待提箱";
            break;
        case 7:
            return @"已提箱";
            break;
        case 8:
            return orderType==ENUM_ORDER_TYPE_INPUT?@"待卸货":@"待装货";//
            break;
        case 9:
            return @"待还箱";
            break;
        case 20:
            return @"运输完成";
        case 21:
            return @"处理中";
        case 31:
            return @"处理中";
        case 99:
            return @"已关闭";
            break;
        default:
            break;
    }
    return @"";
}
+ (UIColor *)transformColorWithPackageState:(int)state{
    switch (state) {
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            return COLOR_BLUE;
        case 410:
        case 20:
            return COLOR_GREEN;
        default:
            break;
    }
    return COLOR_ORANGE;
}
- (BOOL)isTransporting{
    return self.cargoState == 6||self.cargoState == 7||self.cargoState == 8||self.cargoState == 9||self.cargoState == 20;
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
            self.state = [dict doubleValueForKey:kModelPackageInfoState];
            self.weightId = [dict doubleValueForKey:kModelPackageInfoWeightId];
            self.contractId = [dict doubleValueForKey:kModelPackageInfoContractId];
            self.cargoId = [dict doubleValueForKey:kModelPackageInfoCargoId];
            self.transportWaybillId = [dict doubleValueForKey:kModelPackageInfoTransportWaybillId];
            self.contractNumber = [dict stringValueForKey:kModelPackageInfoContractNumber];
            self.containerType = [dict doubleValueForKey:kModelPackageInfoContainerType];
            self.price = [dict doubleValueForKey:kModelPackageInfoPrice];
            self.truckWaybillId = [dict doubleValueForKey:kModelPackageInfoTruckWaybillId];
            self.trustWaybillId = [dict doubleValueForKey:kModelPackageInfoTrustWaybillId];
            self.backMode = [dict doubleValueForKey:kModelPackageInfoBackMode];
            self.cargoName = [dict stringValueForKey:kModelPackageInfoCargoName];
            self.waybillCargoId = [dict doubleValueForKey:kModelPackageInfoWaybillCargoId];
        self.sealNumber = [dict stringValueForKey:kModelPackageInfoSealNumber];
        self.containerNumber = [dict stringValueForKey:kModelPackageInfoContainerNumber];
        self.cargoState = [dict doubleValueForKey:kModelPackageInfoCargoState];
        self.shipperId = [dict doubleValueForKey:kModelPackageInfoShipperId];
        self.stuffTime = [dict doubleValueForKey:kModelPackageInfoStuffTime];
        self.finishTime = [dict doubleValueForKey:kModelPackageInfoFinishTime];
        self.driverPhone = [dict stringValueForKey:kModelPackageInfoDriverPhone];
        self.toFactoryTime = [dict doubleValueForKey:kModelPackageInfoToFactoryTime];
        self.handleTime = [dict doubleValueForKey:kModelPackageInfoHandleTime];
        self.acceptTime = [dict doubleValueForKey:kModelPackageInfoAcceptTime];
        self.driverUserId = [dict doubleValueForKey:kModelPackageInfoDriverUserId];
        self.truckNumber = [dict stringValueForKey:kModelPackageInfoTruckNumber];
        self.createTime = [dict doubleValueForKey:kModelPackageInfoCreateTime];
        self.truckId = [dict doubleValueForKey:kModelPackageInfoTruckId];
        self.driverName = [dict stringValueForKey:kModelPackageInfoDriverName];
        self.waybillId = [dict doubleValueForKey:kModelPackageInfoWaybillId];
        
        self.cargoName = isStr(self.cargoName)?self.cargoName:@"货物";
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.state] forKey:kModelPackageInfoState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.weightId] forKey:kModelPackageInfoWeightId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.contractId] forKey:kModelPackageInfoContractId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cargoId] forKey:kModelPackageInfoCargoId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.transportWaybillId] forKey:kModelPackageInfoTransportWaybillId];
    [mutableDict setValue:self.contractNumber forKey:kModelPackageInfoContractNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.containerType] forKey:kModelPackageInfoContainerType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kModelPackageInfoPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.truckWaybillId] forKey:kModelPackageInfoTruckWaybillId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.trustWaybillId] forKey:kModelPackageInfoTrustWaybillId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.backMode] forKey:kModelPackageInfoBackMode];
    [mutableDict setValue:self.cargoName forKey:kModelPackageInfoCargoName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.waybillCargoId] forKey:kModelPackageInfoWaybillCargoId];
    [mutableDict setValue:self.sealNumber forKey:kModelPackageInfoSealNumber];
    [mutableDict setValue:self.containerNumber forKey:kModelPackageInfoContainerNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cargoState] forKey:kModelPackageInfoCargoState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shipperId] forKey:kModelPackageInfoShipperId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stuffTime] forKey:kModelPackageInfoStuffTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.finishTime] forKey:kModelPackageInfoFinishTime];
    [mutableDict setValue:self.driverPhone forKey:kModelPackageInfoDriverPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.toFactoryTime] forKey:kModelPackageInfoToFactoryTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.handleTime] forKey:kModelPackageInfoHandleTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.acceptTime] forKey:kModelPackageInfoAcceptTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.driverUserId] forKey:kModelPackageInfoDriverUserId];
    [mutableDict setValue:self.truckNumber forKey:kModelPackageInfoTruckNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelPackageInfoCreateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.truckId] forKey:kModelPackageInfoTruckId];
    [mutableDict setValue:self.driverName forKey:kModelPackageInfoDriverName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.waybillId] forKey:kModelPackageInfoWaybillId];
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
