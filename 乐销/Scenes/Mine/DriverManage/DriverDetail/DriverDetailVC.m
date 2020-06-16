//
//  DriverDetailVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/12/3.
//Copyright © 2019 ping. All rights reserved.
//

#import "DriverDetailVC.h"
//detail view
#import "DriverDetailView.h"
//request
#import "RequestApi+Company.h"
#import "CarDetailView.h"

@interface DriverDetailVC ()
@property (nonatomic, strong) DriverDetailView  *topView;
@property (nonatomic, strong) CarDetailImageView *bottomView;

@end

@implementation DriverDetailVC

- (DriverDetailView *)topView{
    if (!_topView) {
        _topView = [DriverDetailView new];
        [_topView resetViewWithModel:self.model];
    }
    return _topView;
}
- (CarDetailImageView *)bottomView{
    if (!_bottomView) {
        _bottomView = [CarDetailImageView new];
    }
    return _bottomView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableView.tableHeaderView = self.topView;
    //request
    [self requestInfo];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"司机详情" rightView:nil]];
}

#pragma mark request
- (void)requestInfo{
    
    [RequestApi requestDriveFileListPassWithDriverId:self.model.driverId
                                               entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty
                                            delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        if (!isDic(response)) {
            return ;
        }
        [self.bottomView resetViewWithAryModels:@[^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加身份证人像面";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_身份证正"] url:nil];
            model.isEssential = true;
            model.url = [response stringValueForKey:@"idCardFrontUrl"];
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加身份证国徽面";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_身份证反"] url:nil];
            model.isEssential = true;
            model.url = [response stringValueForKey:@"idCardBackUrl"];
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加手持身份证人像面";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_手持身份证"] url:nil];
            model.isEssential = true;
            model.url = [response stringValueForKey:@"idCardHandelUrl"];
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加驾驶证主页";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_驾驶证"] url:nil];
            model.isEssential = true;
            model.url = [response stringValueForKey:@"driverLicenseUrl"];
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加人车照";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_humanCar"] url:nil];
            model.url = [response stringValueForKey:@"vehicleUrl"];
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加从业资格证照";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_driverLicense"] url:nil];
            model.url = [response stringValueForKey:@"credentialUrl"];
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            return model;
        }()]];
        self.tableView.tableFooterView = self.bottomView;
        
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
