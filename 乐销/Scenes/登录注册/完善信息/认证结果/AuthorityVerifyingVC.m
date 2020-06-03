//
//  AuthorityVerifyingVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/6.
//Copyright © 2019 ping. All rights reserved.
//

#import "AuthorityVerifyingVC.h"
#import "BaseNavView+Logical.h"
//request
#import "RequestApi+Company.h"

@interface AuthorityVerifyingVC ()
@property (strong, nonatomic) UIImageView *ivFail;
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelTime;
@property (strong, nonatomic) UILabel *labelReason;
@property (strong, nonatomic) UILabel *labelSubReason;

@end

@implementation AuthorityVerifyingVC
#pragma mark 懒加载
- (UIImageView *)ivFail{
    if (_ivFail == nil) {
        _ivFail = [UIImageView new];
        _ivFail.image = [UIImage imageNamed:[GlobalData sharedInstance].GB_CompanyModel.isEnt?@"authority_succeed":@"authority_verifying"];
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
        [_labelTitle fitTitle:[GlobalData sharedInstance].GB_CompanyModel.isEnt?@"车队认证信息已通过":@"认证信息审核中" variable:0];
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

- (UILabel *)labelReason{
    if (_labelReason == nil) {
        _labelReason = [UILabel new];
        _labelReason.textColor = COLOR_999;
        _labelReason.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelReason.numberOfLines = 0;
        _labelReason.lineSpace = 0;
    }
    return _labelReason;
}
- (UILabel *)labelSubReason{
    if (!_labelSubReason) {
        _labelSubReason = [UILabel new];
        _labelSubReason.textColor = COLOR_999;
        _labelSubReason.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelSubReason.numberOfLines = 0;
        _labelSubReason.lineSpace = 0;
    }
    return _labelSubReason;
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
    [self.view addSubview:self.labelSubReason];
    [self.view addSubview:self.labelReason];
    
    //刷新view
    self.ivFail.centerXTop = XY(SCREEN_WIDTH/2.0,W(90)+NAVIGATIONBAR_HEIGHT);
    
    self.labelTitle.centerXTop = XY(SCREEN_WIDTH/2.0,self.ivFail.bottom+W(30));
    [self.labelTime fitTitle:@" " variable:0];
    self.labelTime.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelTitle.bottom+W(20));
    
    if ([GlobalData sharedInstance].GB_CompanyModel.isEnt) {
        [self.labelReason fitTitle:@"变更认证信息已提交" variable:0];
        self.labelReason.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelTime.bottom+W(90));
        [self.labelSubReason fitTitle:@" " variable:0];
        self.labelSubReason.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelReason.bottom+W(15));
    }else{
        [self.labelReason fitTitle:@"请确保您提交的认证信息真实有效" variable:0];
        self.labelReason.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelTime.bottom+W(90));
        [self.labelSubReason fitTitle:@"系统将在24小时内完成审核，请耐心等待" variable:0];
        self.labelSubReason.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelReason.bottom+W(15));
    }
   
    
    [self request];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView *nav = [BaseNavView initNavBackTitle:@"认证状态" rightTitle:@"" rightBlock:nil];
    [nav configBlackBackStyle];
    [self.view addSubview:nav];
}

#pragma mark status bar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)configInfoView:(CGFloat)height model:(ModelAuthorityRecordListItem *)model{
    self.labelReason.hidden = true;
    self.labelSubReason.hidden = true;
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
    
    if ([GlobalData sharedInstance].GB_CompanyModel.type == ENUM_COMPANY_TYPE_MOTORCADE) {
        [self.view addSubview:^(){
            UILabel * label = [UILabel new];
            label.fontNum = F(13);
            label.textColor = COLOR_666;
            [label fitTitle:[NSString stringWithFormat:@"企业名称：%@",UnPackStr(model.name)] variable:0];
            label.leftTop = XY(W(45), top);
            top = label.bottom + W(20);
            return label;
        }()];
        [self.view addSubview:^(){
            UILabel * label = [UILabel new];
            label.fontNum = F(13);
            label.textColor = COLOR_666;
            [label fitTitle:[NSString stringWithFormat:@"办公电话：%@",model.officePhone] variable:0];
            label.leftTop = XY(W(45), top);
            top = label.bottom + W(20);
            return label;
        }()]; [self.view addSubview:^(){
            UILabel * label = [UILabel new];
            label.fontNum = F(13);
            label.textColor = COLOR_666;
            [label fitTitle:[NSString stringWithFormat:@"办公地址：%@%@%@",UnPackStr(model.officeProvinceName),UnPackStr(model.officeCityName),UnPackStr(model.officeCountyName)] variable:0];
            label.leftTop = XY(W(45), top);
            top = label.bottom + W(20);
            return label;
        }()]; [self.view addSubview:^(){
            UILabel * label = [UILabel new];
            label.fontNum = F(13);
            label.textColor = COLOR_666;
            [label fitTitle:[NSString stringWithFormat:@"详细地址：%@",model.officeAddrDetail] variable:0];
            label.leftTop = XY(W(45), top);
            top = label.bottom + W(20);
            return label;
        }()];
    }else{
        [self.view addSubview:^(){
            UILabel * label = [UILabel new];
            label.fontNum = F(13);
            label.textColor = COLOR_666;
            [label fitTitle:[NSString stringWithFormat:@"姓 名：%@",UnPackStr(model.legalName)] variable:0];
            label.leftTop = XY(W(45), top);
            top = label.bottom + W(20);
            return label;
        }()];
        [self.view addSubview:^(){
            UILabel * label = [UILabel new];
            label.fontNum = F(13);
            label.textColor = COLOR_666;
            [label fitTitle:[NSString stringWithFormat:@"身份证号：%@",UnPackStr(model.identityNumber)] variable:0];
            label.leftTop = XY(W(45), top);
            top = label.bottom + W(20);
            return label;
        }()];
    }
    
   
}
#pragma mark request
- (void)request{
    [RequestApi requestAuthorityRecordListWithEntid:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * aryAuthority =  [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelAuthorityRecordListItem"];
        if (!isAry(aryAuthority)) {
            return ;
        }
        for (int i = 0; i<aryAuthority.count; i++) {
            ModelAuthorityRecordListItem * model =aryAuthority[i];
            if ([GlobalData sharedInstance].GB_CompanyModel.isEnt) {
                if (model.state == 3) {
                    [self.labelTime fitTitle: [GlobalMethod exchangeTimeWithStamp:model.submitTime andFormatter:TIME_SEC_SHOW] variable:0];
                    self.labelTime.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelTitle.bottom+W(20));

                    [self configInfoView:self.labelTime.bottom + W(20) model:model];
                    break;
                }

            }else{
                [self.labelTime fitTitle: [GlobalMethod exchangeTimeWithStamp:model.submitTime andFormatter:TIME_SEC_SHOW] variable:0];
                self.labelTime.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelTitle.bottom+W(20));
                break;
            }

        }
       
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
