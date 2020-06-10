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

@interface DriverDetailVC ()
@property (nonatomic, strong) DriverDetailView  *topView;
@property (nonatomic, strong) DriverDetailImageView *bottomView;

@end

@implementation DriverDetailVC

- (DriverDetailView *)topView{
    if (!_topView) {
        _topView = [DriverDetailView new];
        [_topView resetViewWithModel:self.model];
    }
    return _topView;
}
- (DriverDetailImageView *)bottomView{
    if (!_bottomView) {
        _bottomView = [DriverDetailImageView new];
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
            model.desc = @"身份证人像面";
            model.url = [response stringValueForKey:@"idCardFrontUrl"];
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            model.isEssential = true;
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"身份证国徽面";
            model.url = [response stringValueForKey:@"idCardBackUrl"];
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            model.isEssential = true;
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"手持身份证人像面";
            model.url = [response stringValueForKey:@"idCardHandelUrl"];
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            model.isEssential = true;
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"驾驶证主页";
            model.url = [response stringValueForKey:@"driverLicenseUrl"];
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
            model.isEssential = true;
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            return model;
        }()]];
        self.tableView.tableFooterView = self.bottomView;
        
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
