//
//  LocationRecordInstance.m
//  Driver
//
//  Created by 隋林栋 on 2019/6/5.
//Copyright © 2019 ping. All rights reserved.
//

#import "LocationRecordInstance.h"
//logcation
#import <AMapLocationKit/AMapLocationKit.h>
//request
#import "RequestApi+Location.h"
//阿里云推送
#import <CloudPushSDK/CloudPushSDK.h>
@interface LocationRecordInstance ()<AMapLocationManagerDelegate>

@end

@implementation LocationRecordInstance

#pragma mark single instance
SYNTHESIZE_SINGLETONE_FOR_CLASS(LocationRecordInstance)

#pragma mark init
- (instancetype)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upLocation) name:NOTICE_SELFMODEL_CHANGE object:nil];
    }
    return self;
}
#pragma mark 销毁
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"%s  %@",__func__,self.class);
}

- (void)upLocation{
    NSMutableArray * ary = [GlobalMethod readAry:LOCAL_LOCATION_RECORD modelName:@"ModelAddress"];
    [self request:ary];
}
#pragma mark lazy init
- (AMapLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc]init];
        //带逆地理信息的一次定位（返回坐标和地址信息）
        //kCLLocationAccuracyHundredMeters，一次还不错的定位，偏差在百米左右，超时时间设置在2s-3s左右即可。
        //高精度：kCLLocationAccuracyBest，可以获取精度很高的一次定位，偏差在十米左右。
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
        _locationManager.delegate = self;
        //位置更改超过5米记录
        _locationManager.distanceFilter = 5;
        _locationManager.locatingWithReGeocode = true;
        _locationManager.allowsBackgroundLocationUpdates = true;
        _locationManager.locationTimeout = 5;

        
    }
    return _locationManager;
}
#pragma mark start record
- (void)startRecord{
    [self.locationManager startUpdatingLocation];
}

#pragma mark delegate
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
    ModelAddress * modelAddress = [ModelAddress initWithAMapLocationReGeocode:reGeocode location:location];
    if (!modelAddress.lat) {
        return;
    }
    [GlobalMethod writeModel:modelAddress key:LOCAL_LOCATION_UPTODATE];
    
    NSMutableArray * ary = [GlobalMethod readAry:LOCAL_LOCATION_RECORD modelName:@"ModelAddress"];
    [ary addObject:modelAddress];
    [GlobalMethod writeAry:ary key:LOCAL_LOCATION_RECORD];
    //请求
    [self request:ary];
}
- (void)amapLocationManager:(AMapLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self startRecord];
    }else{
        [self.locationManager stopUpdatingLocation];
    }
}
#pragma mark request
- (void)request:(NSMutableArray *)aryParameter{
    static NSDate * dateRequest = nil;
    if (![GlobalMethod isLoginSuccess]) {
        return;
    }
    if (dateRequest && [[NSDate date]timeIntervalSinceDate:dateRequest]<30) {
        return;
    }
    NSMutableArray * aryJson = [NSMutableArray array];
    for (ModelAddress * modelItem in aryParameter) {
        [aryJson addObject:@{@"uploaderId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.userId),
                             @"lng":NSNumber.dou(modelItem.lng),
                             @"terminalNumber":UnPackStr([CloudPushSDK getDeviceId]),
                             @"terminalType":@1,
                             @"collectTime":NSNumber.dou(modelItem.dateRecord),
                             @"addr":UnPackStr(modelItem.desc),
                             @"lat":NSNumber.dou(modelItem.lat)
                             }];
    }
    NSString * strJson = [GlobalMethod exchangeDicToJson:aryJson];
    [RequestApi requestAddLocationsWithData:strJson delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        dateRequest = [NSDate date];
        NSMutableArray * aryLocation = [GlobalMethod readAry:LOCAL_LOCATION_RECORD modelName:@"ModelAddress"];
        if (aryLocation.count >= aryParameter.count) {
            [aryLocation removeObjectsInRange:NSMakeRange(0, aryParameter.count)];
            [GlobalMethod writeAry:aryLocation key:LOCAL_LOCATION_RECORD];
        }
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

@end
