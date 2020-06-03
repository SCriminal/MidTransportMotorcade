//
//  PersonalCenterVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "PersonalCenterVC.h"
//hot line view
#import "HotLineView.h"
//basenav
#import "BaseNavView+Logical.h"
//subview
#import "PersonalCenterView.h"
//request
#import "RequestApi+Company.h"

@interface PersonalCenterVC ()
@property (nonatomic, strong) HotLineView *hotLineView;
@property (nonatomic, strong) PersonalCenterView *topView;
@property (nonatomic, strong) PersonalCenterBottomView *bottomView;
@property (nonatomic, strong) UIImageView *ivShadow;

@end

@implementation PersonalCenterVC
- (HotLineView *)hotLineView{
    if (!_hotLineView) {
        _hotLineView = [HotLineView new];
    }
    return _hotLineView;
}
- (UIImageView *)ivShadow{
    if (!_ivShadow) {
        _ivShadow = [UIImageView new];
        _ivShadow.backgroundColor  = [UIColor clearColor];
        _ivShadow.image = [UIImage imageNamed:@"shadow"];
        _ivShadow.widthHeight = XY(SCREEN_WIDTH, W(10));
    }
    return _ivShadow;
}
- (PersonalCenterView *)topView{
    if (!_topView) {
        _topView = [PersonalCenterView new];
    }
    return _topView;
}
- (PersonalCenterBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [PersonalCenterBottomView new];
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
    self.tableView.tableFooterView = [UIView initWithViews:@[self.bottomView,self.hotLineView]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - TABBAR_HEIGHT;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self requestList];
}
#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavTitle:@"个人中心" leftImageName:nil leftImageSize:CGSizeZero leftBlock:nil rightTitle:@"编辑资料" righBlock:^{
        [GB_Nav pushVCName:@"EditInfoVC" animated:true];
    }];
    [nav configBlackStyle];
    [self.view addSubview:nav];
    [self.view addSubview:self.ivShadow];
    self.ivShadow.top = nav.bottom;
}


#pragma mark request
- (void)requestList{
    [RequestApi requestCompanyDetailWithId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelCompany * modelNew = [GlobalMethod exchangeDicToModel:response modelName:@"ModelCompany"];
        if (![modelNew.description isEqualToString:[GlobalData sharedInstance].GB_CompanyModel.description]) {
            [GlobalData sharedInstance].GB_CompanyModel = modelNew;
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    } ];
}

#pragma mark statust bar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
