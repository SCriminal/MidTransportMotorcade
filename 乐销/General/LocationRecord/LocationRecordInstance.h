//
//  LocationRecordInstance.h
//  Driver
//
//  Created by 隋林栋 on 2019/6/5.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationRecordInstance : NSObject
@property (nonatomic, strong) AMapLocationManager *locationManager;//获取地址

DECLARE_SINGLETON(LocationRecordInstance)

//start
- (void)startRecord;
- (void)upLocation;
@end
