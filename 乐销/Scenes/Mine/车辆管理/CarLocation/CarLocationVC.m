//
//  CarLocationVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "CarLocationVC.h"
//高德地图
#import <MAMapKit/MAMapView.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAPinAnnotationView.h>
#import <MAMapKit/MAPolyline.h>
#import <MAMapKit/MAPolylineRenderer.h>
//init location
#import "BaseVC+Location.h"
#import "BaseNavView+Logical.h"
//request
#import "RequestApi+Location.h"

@interface CarLocationVC ()<MAMapViewDelegate>
//地图
@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic,strong) CarLocationBottomView *bottomView;
@property (nonatomic, strong) ModelOrderList *model;

@property (nonatomic, strong) NSDate *dateStart;
@property (nonatomic, strong) NSDate *dateEnd;

@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, assign) CLLocationCoordinate2D locationStart;
@property (nonatomic, assign) CLLocationCoordinate2D locationEnd;

@end

@implementation CarLocationVC

- (CarLocationBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [CarLocationBottomView new];
        _bottomView.bottom = SCREEN_HEIGHT;
    }
    return _bottomView;
}
- (MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _mapView.showsCompass= NO; // 设置成NO表示关闭指南针；YES表示显示指南针
        _mapView.showsScale= NO;
        _mapView.delegate = self;
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        _mapView.showsUserLocation = false;
        _mapView.rotateEnabled = false;
        _mapView.rotateCameraEnabled = false;
        [_mapView setZoomLevel:MAPZOOMNUM animated:true];
        _mapView.userTrackingMode = MAUserTrackingModeNone;
    }
    return _mapView;
}


#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.bottomView];

    //init location
    [self.view addSubview:^(){
        BaseNavView * nav = [BaseNavView initNavBackTitle:@"车辆定位" rightTitle:nil rightBlock:^{
            
        }];
        [nav configBlackBackStyle];
        return nav;
    }()];
    if (self.modelDriver) {
        self.dateStart = ^(){
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            
            NSDateComponents *comps = nil;
            
            comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
            
            NSDateComponents *adcomps = [[NSDateComponents alloc] init];
            
            [adcomps setYear:0];
            
            [adcomps setMonth:-1];
            
            [adcomps setDay:0];
            
            return [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
        }();
        self.dateEnd = [NSDate date];
        [self requestTrick];
    }else{
        [self requestOrderDetail];
    }
}

#pragma mark status bar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return  UIStatusBarStyleLightContent;
}

- (void)requestOrderDetail{
    [self.bottomView resetViewWithName:self.modelPackage.driverName carNumber:self.modelPackage.truckNumber];
    
    [RequestApi requestCarTrickWithuploaderId:self.modelPackage.driverUserId startTime:self.modelPackage.stuffTime endTime:self.modelPackage.finishTime?self.modelPackage.finishTime:[[NSDate date]timeIntervalSince1970] vehicleNumber:self.modelPackage.truckNumber  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelLocationItem"];
            [self drawLine:ary];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            self.mapView.showsUserLocation = true;
            [self initLocation];

        } ];

}

- (void)requestTrick{
    [self.bottomView resetViewWithName:self.modelDriver.driverName carNumber:self.modelDriver.truckNumber];
    [RequestApi requestCarTrickWithuploaderId:self.modelDriver.iDProperty startTime:[self.dateStart timeIntervalSince1970] endTime:[self.dateEnd timeIntervalSince1970] vehicleNumber:self.modelDriver.truckNumber delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelLocationItem"];
        [self drawLine:ary];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        self.mapView.showsUserLocation = true;
        [self initLocation];

    } ];
}

#pragma mark line

- (void)drawLine:(NSArray *)aryLocation{
    if (!isAry(aryLocation)) {
        self.mapView.showsUserLocation = true;
        [self initLocation];
        return;
    }
    //reconfig view
    if (isAry(aryLocation)) {
        ModelLocationItem *item = aryLocation.firstObject;
        self.mapView.centerCoordinate =CLLocationCoordinate2DMake(item.lat, item.lng);
        if (isStr(item.addr)) {
            [self.bottomView resetViewWithAddress:item.addr];
        }else{
            [self search:item.lat lng:item.lng];
        }
    }

    //draw line
    if (self.modelPackage.waybillId) {
        CLLocationCoordinate2D commonPolylineCoords[aryLocation.count];
        for (int i = 0; i<aryLocation.count; i++) {
            ModelLocationItem *item = aryLocation[i];
            commonPolylineCoords[i].latitude = item.lat;
            commonPolylineCoords[i].longitude = item.lng;
        }
        //构造折线对象
        MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:aryLocation.count];
        [self.mapView removeOverlays:self.mapView.overlays];

        //在地图上添加折线对象
        [self.mapView addOverlay: commonPolyline];
    }
   
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    //drwa end point annotation
    if (isAry(aryLocation)) {
        ModelLocationItem *item = aryLocation.firstObject;
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(item.lat, item.lng);
        self.locationEnd = pointAnnotation.coordinate;
        [self.mapView addAnnotation:pointAnnotation];
    }
   
    //draw start point annotation
    if (self.modelPackage.waybillId) {
        ModelLocationItem *item = aryLocation.lastObject;
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(item.lat, item.lng);
        self.locationStart = pointAnnotation.coordinate;
        [self.mapView addAnnotation:pointAnnotation];
    }
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView =  [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        if(annotation.coordinate.latitude == self.locationStart.latitude && annotation.coordinate.longitude == self.locationStart.longitude){
            annotationView.image =  [UIImage imageNamed:@"origin_map"];
        }
        if(annotation.coordinate.latitude == self.locationEnd.latitude && annotation.coordinate.longitude == self.locationEnd.longitude){
            annotationView.image =  [UIImage imageNamed:@"car_map"];
        }
        
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
//        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        polylineRenderer.strokeImage = [UIImage imageNamed:@"arrowTexture"];

        return polylineRenderer;
    }
    return nil;
}

#pragma mark search
- (void)search:(double)lat lng:(double)lng{
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location = [AMapGeoPoint locationWithLatitude:lat longitude:lng];
    regeo.requireExtension  = YES;
    
    [self.search AMapReGoecodeSearch:regeo];
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        //解析response获取地址描述，具体解析见 Demo
        [self.bottomView resetViewWithAddress:response.regeocode.formattedAddress];
    }
}
-(void)fetchLocation:(CLLocation *)location{
    self.mapView.centerCoordinate =location.coordinate;

}
@end



@implementation CarLocationBottomView
#pragma mark 懒加载
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        _labelName.textColor = COLOR_333;
        _labelName.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _labelName.numberOfLines = 1;
        _labelName.lineSpace = 0;
    }
    return _labelName;
}
- (UILabel *)labelAddress{
    if (_labelAddress == nil) {
        _labelAddress = [UILabel new];
        _labelAddress.textColor = COLOR_666;
        _labelAddress.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelAddress.numberOfLines = 1;
        _labelAddress.lineSpace = 0;
    }
    return _labelAddress;
}
- (UIImageView *)ivBg{
    if (_ivBg == nil) {
        _ivBg = [UIImageView new];
        _ivBg.image = IMAGE_WHITE_BG;
        _ivBg.backgroundColor = [UIColor clearColor];
    }
    return _ivBg;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.labelName];
    [self addSubview:self.labelAddress];
    
    //初始化页面
    [self resetViewWithName:nil carNumber:nil];
}

#pragma mark 刷新view
- (void)resetViewWithName:(NSString *)strName carNumber:(NSString *)carNumber{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
//    if (isStr(strName) && isStr(phone) && [strName isEqualToString:phone]) {
//        phone = @"";
//    }
    [self.labelName fitTitle:[NSString stringWithFormat:@"%@ %@",UnPackStr(strName),UnPackStr(carNumber)] variable:SCREEN_WIDTH - W(50)];
    self.labelName.leftTop = XY(W(25),W(30));
    [self.labelAddress fitTitle:@"暂无定位信息" variable:SCREEN_WIDTH - W(50)];
    self.labelAddress.leftTop = XY(W(25),self.labelName.bottom+W(20));
    
    self.ivBg.widthHeight = XY(SCREEN_WIDTH,self.labelAddress.bottom + W(30));
    
    //设置总高度
    self.height = self.ivBg.bottom + iphoneXBottomInterval;
}

- (void)resetViewWithAddress:(NSString *)address{
    [self.labelAddress fitTitle:isStr(address)?address:@"暂无定位信息" variable:SCREEN_WIDTH - W(50)];

}
@end
