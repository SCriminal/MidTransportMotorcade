//
//  PersonalCenterView.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "PersonalCenterView.h"
//request
#import "RequestApi+UserApi.h"
@interface PersonalCenterView ()

@end

@implementation PersonalCenterView
#pragma mark 懒加载
- (UIImageView *)ivBG{
    if (_ivBG == nil) {
        _ivBG = [UIImageView new];
        _ivBG.image = [UIImage imageNamed:@"personalCenter_darkBg"];
        _ivBG.widthHeight = XY(SCREEN_WIDTH,W(15));
        _ivBG.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _ivBG;
}
- (UIImageView *)ivLogo{
    if (_ivLogo == nil) {
        _ivLogo = [UIImageView new];
        _ivLogo.image = [UIImage imageNamed:IMAGE_HEAD_DEFAULT];
        _ivLogo.widthHeight = XY(W(65),W(65));
        _ivLogo.backgroundColor = [UIColor clearColor];
        [GlobalMethod setRoundView:_ivLogo color:[UIColor clearColor] numRound:_ivLogo.width/2.0 width:0];
    }
    return _ivLogo;
}
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        _labelName.textColor = [UIColor whiteColor];
        _labelName.font =  [UIFont systemFontOfSize:F(20) ];
        _labelName.numberOfLines = 0;
        _labelName.lineSpace = 0;
    }
    return _labelName;
}
- (UILabel *)labelID{
    if (_labelID == nil) {
        _labelID = [UILabel new];
        _labelID.textColor = [UIColor whiteColor];
        _labelID.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _labelID.numberOfLines = 0;
        _labelID.lineSpace = 0;
    }
    return _labelID;
}
- (UILabel *)labelBrief{
    if (_labelBrief == nil) {
        _labelBrief = [UILabel new];
        _labelBrief.textColor = [UIColor whiteColor];
        _labelBrief.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _labelBrief.numberOfLines = 1;
        _labelBrief.lineSpace = 0;
    }
    return _labelBrief;
}
- (UIControl *)conCopyCode{
    if (_conCopyCode == nil) {
        _conCopyCode = [UIControl new];
        _conCopyCode.tag = 1;
        [_conCopyCode addTarget:self action:@selector(copyCodeClick) forControlEvents:UIControlEventTouchUpInside];
        _conCopyCode.backgroundColor = [UIColor clearColor];
        _conCopyCode.widthHeight = XY(SCREEN_WIDTH,W(0));
    }
    return _conCopyCode;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
        self.clipsToBounds = false;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userInfoChange) name:NOTICE_SELFMODEL_CHANGE object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userInfoChange) name:NOTICE_COMPANY_MODEL_CHANGE object:nil];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBG];
    [self addSubview:self.ivLogo];
    [self addSubview:self.labelName];
    [self addSubview:self.labelID];
    [self addSubview:self.labelBrief];
    [self addSubview:self.conCopyCode];

    //初始化页面
    [self userInfoChange];
}
#pragma mark notice
- (void)userInfoChange{
    [self resetViewWithModel:nil];
}
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    ModelUser *modelUser = [GlobalData sharedInstance].GB_UserModel;
    [self.ivLogo sd_setImageWithURL:[NSURL URLWithString:modelUser.headUrl] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
    self.ivLogo.centerXTop = XY(SCREEN_WIDTH/2.0,W(40));
    [self.labelName fitTitle:UnPackStr(modelUser.nickName) variable:0];
    self.labelName.centerXTop = XY(SCREEN_WIDTH/2.0,self.ivLogo.bottom+W(20));
    [self.labelID fitTitle:[NSString stringWithFormat:@"企业码：%@",UnPackStr([GlobalData sharedInstance].GB_CompanyModel.code)] variable:0];
    self.conCopyCode.frame = CGRectMake(0, self.labelID.top- W(10), SCREEN_WIDTH, self.labelID.height + W(20));
    
    self.labelID.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelName.bottom+W(15));
    [self.labelBrief fitTitle: isStr(modelUser.introduce)?modelUser.introduce:@"还未填写个性签名，介绍一下自己吧" variable:SCREEN_WIDTH- W(50)];
    self.labelBrief.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelID.bottom+W(15));
    
    //设置总高度
    self.height = self.labelBrief.bottom + W(40);
    self.ivBG.top = -W(300);
    self.ivBG.height = self.height + W(66)/2.0 + W(300);
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




#pragma mark 点击事件
- (void)copyCodeClick{
    [GlobalMethod copyToPlte:[GlobalData sharedInstance].GB_CompanyModel.code];
    [GlobalMethod showAlert:@"企业码已经复制"];
}
@end



@implementation PersonalCenterBottomView
#pragma mark 懒加载
- (UILabel *)labelAuthorityStatus{
    if (_labelAuthorityStatus == nil) {
        _labelAuthorityStatus = [UILabel new];
        _labelAuthorityStatus.textColor = COLOR_BLUE;
        _labelAuthorityStatus.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _labelAuthorityStatus.numberOfLines = 0;
        _labelAuthorityStatus.lineSpace = 0;
    }
    return _labelAuthorityStatus;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(companyInfoChange) name:NOTICE_COMPANY_MODEL_CHANGE object:nil];
    }
    return self;
}
#pragma mark 销毁
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark notice
- (void)companyInfoChange{
    [self.labelAuthorityStatus fitTitle:UnPackStr([GlobalData sharedInstance].GB_CompanyModel.authStatusShow) variable:0];
    self.labelAuthorityStatus.rightCenterY = XY(SCREEN_WIDTH - W(25)-W(20)-W(3),W(66)/2.0);
}
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    {
        UIImageView * ivBG = [UIImageView new];
        ivBG.image = IMAGE_WHITE_BG;
        ivBG.backgroundColor = [UIColor clearColor];
        ivBG.frame = CGRectMake(0, -W(9), SCREEN_WIDTH, W(66)+W(18));
        [self addSubview:ivBG];
    }
    [self addItemImage:@"personlCenter_attestation" title:@"车队认证" top:0 tag:1];
    [self addSubview:self.labelAuthorityStatus];
    
    
    {
        UIImageView * ivBG = [UIImageView new];
        ivBG.image = IMAGE_WHITE_BG;
        ivBG.backgroundColor = [UIColor clearColor];
        ivBG.frame = CGRectMake(0, W(66)+W(5), SCREEN_WIDTH, W(66)*2+W(20));
        [self addSubview:ivBG];
    }
    [self addItemImage:@"personlCenter_data" title:@"消息中心" top:W(66)+W(15) tag:2];
    
    [self addItemImage:@"personlCenter_set" title:@"系统设置" top:W(66)*2+W(15) tag:3];
    
    [self addLineFrame:CGRectMake(W(25), W(66)*2+W(15), SCREEN_WIDTH - W(50), 1)];
    
    //刷新view
    [self.labelAuthorityStatus fitTitle:UnPackStr([GlobalData sharedInstance].GB_CompanyModel.authStatusShow) variable:0];
    self.labelAuthorityStatus.rightCenterY = XY(SCREEN_WIDTH - W(25)-W(20)-W(3),W(66)/2.0);
    
    //设置总高度
    self.height = W(66)*3+W(15);
}

- (void)addItemImage:(NSString *)imageName title:(NSString *)title top:(CGFloat )top tag:(NSInteger)tag{
    CGFloat cellHeight = W(66);
    
    UIImageView * iv = [UIImageView new];
    iv.widthHeight = XY(W(25), W(25));
    iv.image = [UIImage imageNamed:imageName];
    iv.leftCenterY = XY(W(25), cellHeight/2.0+top);
    [self addSubview:iv];
    
    UILabel * label = [UILabel new];
    label.fontNum = F(16);
    label.textColor = COLOR_333;
    [label fitTitle:title variable:0];
    label.leftCenterY = XY(iv.right + W(10), cellHeight/2.0+top);
    [self addSubview:label];
    
    UIImageView * arrow = [UIImageView new];
    arrow.widthHeight = XY(W(25), W(25));
    arrow.image = [UIImage imageNamed:@"setting_RightArrow"];
    arrow.rightCenterY = XY(SCREEN_WIDTH - W(20), cellHeight/2.0+top);
    [self addSubview:arrow];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.tag = tag;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, top, SCREEN_WIDTH, cellHeight);
    [self addSubview:btn];
}


#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            [ModelUser jumpToAuthorityStateVCSuccessBlock:nil];
        }
            break;
        case 2:
        {
            [GB_Nav pushVCName:@"MsgCenterVC" animated:true];
       }
            break;
        case 3:
        {
            [GB_Nav pushVCName:@"SettingVC" animated:true];
        }
            break;
        default:
            break;
    }
}
@end
