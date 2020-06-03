//
//  AuthorityVerifySuccessVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/10.
//Copyright © 2019 ping. All rights reserved.
//

#import "AuthorityDriverVerifySuccessVC.h"
#import "BaseNavView+Logical.h"
#import "RequestApi+UserApi.h"
#import "RequestApi+Company.h"
#import "TransportCompanyAuthorityVC.h"
#import "PersonalCarOwnerAuthorityVC.h"

@interface AuthorityDriverVerifySuccessVC ()
@property (strong, nonatomic) UIImageView *ivFail;
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelTime;
@property (strong, nonatomic) ModelBaseInfo *modelBaseInfo;
@end

@implementation AuthorityDriverVerifySuccessVC

#pragma mark 懒加载
- (UIImageView *)ivFail{
    if (_ivFail == nil) {
        _ivFail = [UIImageView new];
        _ivFail.image = [UIImage imageNamed:@"authority_succeed"];
        _ivFail.widthHeight = XY(W(100),W(100));
    }
    return _ivFail;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(20)];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineSpace = 0;
        [_labelTitle fitTitle:@"车队认证信息已通过" variable:0];
    }
    return _labelTitle;
}
- (UILabel *)labelTime{
    if (_labelTime == nil) {
        _labelTime = [UILabel new];
        _labelTime.textColor = COLOR_666;
        _labelTime.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelTime.numberOfLines = 0;
        _labelTime.lineSpace = 0;
    }
    return _labelTime;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNav];
    self.viewBG.backgroundColor = [UIColor whiteColor];
    
    //添加subView
    [self.view addSubview:self.ivFail];
    [self.view addSubview:self.labelTitle];
    [self.view addSubview:self.labelTime];
    
    //刷新view
    self.ivFail.centerXTop = XY(SCREEN_WIDTH/2.0,W(90)+NAVIGATIONBAR_HEIGHT);
    
    self.labelTitle.centerXTop = XY(SCREEN_WIDTH/2.0,self.ivFail.bottom+W(30));
    
    [self.labelTime fitTitle:@" " variable:0];
    self.labelTime.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelTitle.bottom+W(20));
    
    [self reqeustInfo];
    [self requstBaseInfo];
}

- (void)configInfoView:(CGFloat)height{
    UILabel * labelInfo = [UILabel new];
    labelInfo.textColor = COLOR_999;
    labelInfo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    labelInfo.numberOfLines = 0;
    labelInfo.lineSpace = 0;
    labelInfo.textAlignment = NSTextAlignmentCenter;
    labelInfo.backgroundColor = [UIColor whiteColor];
    [labelInfo fitTitle:@"认证资料" fixed:W(112)];
    labelInfo.centerXTop = XY(SCREEN_WIDTH/2.0,height);
    [self.view addSubview:labelInfo];
    
    
    UIView * line = [UIView new];
    line.backgroundColor = COLOR_LINE;
    line.widthHeight = XY(SCREEN_WIDTH - W(90), 1);
    line.centerXCenterY = XY(SCREEN_WIDTH/2.0, labelInfo.centerY);
    [self.view insertSubview:line belowSubview:labelInfo];

    CGFloat __block top = labelInfo.bottom + W(30);
    [self.view addSubview:^(){
        UILabel * label = [UILabel new];
        label.fontNum = F(13);
        label.textColor = COLOR_666;
        [label fitTitle:[NSString stringWithFormat:@"姓 名：%@",UnPackStr(self.modelBaseInfo.realName)] variable:0];
        label.leftTop = XY(W(45), top);
        top = label.bottom + W(20);
        return label;
    }()];
    [self.view addSubview:^(){
        UILabel * label = [UILabel new];
        label.fontNum = F(13);
        label.textColor = COLOR_666;
        [label fitTitle:[NSString stringWithFormat:@"身份证号：%@",UnPackStr(self.modelBaseInfo.idNumber)] variable:0];
        label.leftTop = XY(W(45), top);
        top = label.bottom + W(20);
        return label;
    }()];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView *nav = [BaseNavView initNavBackTitle:@"车队认证" rightTitle:@"修改认证" rightBlock:^{
        if([GlobalData sharedInstance].GB_CompanyModel.type == ENUM_COMPANY_TYPE_MOTORCADE){// 2是运输公司 3 是个体车主
            TransportCompanyAuthorityVC * vc = [TransportCompanyAuthorityVC new];
            vc.model = [GlobalData sharedInstance].GB_CompanyModel;
            [GB_Nav pushViewController:vc animated:true];
            
        }else if([GlobalData sharedInstance].GB_CompanyModel.type == ENUM_COMPANY_TYPE_PERSONAL_DRIVER){
            PersonalCarOwnerAuthorityVC * vc = [PersonalCarOwnerAuthorityVC new];
            vc.model = [GlobalData sharedInstance].GB_CompanyModel;
            [GB_Nav pushViewController:vc animated:true];
        }
    }];
    [nav configBlackBackStyle];
    [self.view addSubview:nav];
}

#pragma mark request
- (void)reqeustInfo{
    [RequestApi requestAuthorityRecordListWithEntid:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        
        NSArray * aryReasons = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelAuthorityRecordListItem"];
        if (!aryReasons.count) {
            return ;
        }
        ModelAuthorityRecordListItem * model = aryReasons.firstObject;
        [self.labelTime fitTitle: [GlobalMethod exchangeTimeWithStamp:model.reviewTime andFormatter:TIME_SEC_SHOW] variable:0];
        self.labelTime.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelTitle.bottom+W(20));
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
- (void)requstBaseInfo{
    [RequestApi requestUserInfoWithDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelBaseInfo = [ModelBaseInfo modelObjectWithDictionary:response];
        [self configInfoView:self.labelTime.bottom+W(80)
];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
#pragma mark status bar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
