//
//  AttachDetailView.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/12/3.
//Copyright © 2019 ping. All rights reserved.
//

#import "AttachDetailView.h"
#import "DriverDetailView.h"
//image detail
#import "ImageDetailBigView.h"

@implementation AttachDetailView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelAttachApplyList *)modelAttach{
    [self removeAllSubViews];//移除线
    //重置视图坐标
    CGFloat bottom =  [DriverDetailView addDetailSubView:@[^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"身份证号";
        model.subTitle = modelAttach.driverLicense;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"当前状态";
        model.subTitle = modelAttach.authStatusShow;
        model.color = modelAttach.authStatusColorShow;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"联系方式";
        model.subTitle = modelAttach.cellPhone;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        if(modelAttach.state == 10){
            model.title = @"挂靠时间";
            model.subTitle = [GlobalMethod exchangeTimeWithStamp:modelAttach.createTime andFormatter:TIME_SEC_SHOW];;
        }else{
            model.title = @"申请时间";
            model.subTitle = [GlobalMethod exchangeTimeWithStamp:modelAttach.applyTime andFormatter:TIME_SEC_SHOW];;
        }
        return model;
    }()] inView:self title:modelAttach.realName];
    //设置总高度
    self.height = [self addLineFrame:CGRectMake(W(15), bottom, SCREEN_WIDTH - W(30), 1)];
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}


@end


@implementation AttachDetailImageView

#pragma mark 刷新view
- (void)resetViewWithAryModels:(NSArray *)aryImages{
    self.aryImages = aryImages;
    [self removeAllSubViews];//移除线
    CGFloat left= W(15);
    //重置视图坐标
    for (int i = 0; i<aryImages.count; i++) {
        ModelImage *model = aryImages[i];
        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(left, W(25), W(78), W(65))];
        [iv sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:model.image];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.tag = i;
        iv.userInteractionEnabled = true;
        [iv addTarget:self action:@selector(imageClick:)];
        [self addSubview:iv];
        left = iv.right +W(11);
        [GlobalMethod setRoundView:iv color:[UIColor clearColor] numRound:5 width:0];
    }
    self.height = W(90);
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}

#pragma mark click
- (void)imageClick:(UITapGestureRecognizer *)tap{
    UIImageView * view = (UIImageView *)tap.view;
    if (![view isKindOfClass:UIImageView.class]) {
        return;
    }
    ImageDetailBigView * detailView = [ImageDetailBigView new];
    [detailView resetView:self.aryImages.mutableCopy isEdit:false index: view.tag];
    [detailView showInView:[GB_Nav.lastVC view] imageViewShow:view];
}


@end



@implementation AttachDetailBottomView
#pragma mark 懒加载
-(UIButton *)btnCancel{
    if (_btnCancel == nil) {
        _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCancel.tag = 1;
        [_btnCancel addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnCancel.backgroundColor = [UIColor clearColor];
        _btnCancel.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnCancel setTitleColor:COLOR_RED forState:UIControlStateNormal];
        _btnCancel.widthHeight = XY(SCREEN_WIDTH - W(30),W(40));
        [GlobalMethod setRoundView:_btnCancel color:COLOR_RED numRound:_btnCancel.height/2.0 width:1];
        [_btnCancel setTitle:@"取消挂靠" forState:(UIControlStateNormal)];
        
    }
    return _btnCancel;
}
-(UIButton *)btnReject{
    if (_btnReject == nil) {
        _btnReject = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnReject.tag = 2;
        [_btnReject addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnReject.backgroundColor = [UIColor clearColor];
        _btnReject.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnReject setTitleColor:COLOR_RED forState:UIControlStateNormal];
        _btnReject.widthHeight = XY(W(165),W(40));
        [GlobalMethod setRoundView:_btnReject color:COLOR_RED numRound:_btnCancel.height/2.0 width:1];
        [_btnReject setTitle:@"拒绝" forState:(UIControlStateNormal)];
    }
    return _btnReject;
}
-(UIButton *)btnAgree{
    if (_btnAgree == nil) {
        _btnAgree = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAgree.tag = 3;
        [_btnAgree addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnAgree.backgroundColor = [UIColor clearColor];
        _btnAgree.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnAgree setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
        _btnAgree.widthHeight = XY(W(165),W(40));
        [GlobalMethod setRoundView:_btnAgree color:COLOR_BLUE numRound:_btnCancel.height/2.0 width:1];
        [_btnAgree setTitle:@"同意" forState:(UIControlStateNormal)];
    }
    return _btnAgree;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.btnCancel];
    [self addSubview:self.btnReject];
    [self addSubview:self.btnAgree];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelAttachApplyList *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.btnCancel.centerXTop = XY(SCREEN_WIDTH/2.0,W(0));
    self.btnReject.leftTop = XY(W(15),0);
    self.btnAgree.rightTop = XY(SCREEN_WIDTH - W(15),0);
    
    if (model.state == 10) {
        self.btnReject.hidden = true;
        self.btnAgree.hidden = true;
        self.btnCancel.hidden = false;
    }else{
        self.btnCancel.hidden = true;
        self.btnReject.hidden = false;
        self.btnAgree.hidden = false;
    }
    
    //设置总高度
    self.height = self.btnAgree.bottom + W(15)+iphoneXBottomInterval;
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1://取消
        {
            if (self.blockCancel) {
                self.blockCancel();
            }
        }
            break;
        case 2://拒绝
        {
            if (self.blockReject) {
                self.blockReject();
            }
        }
            break;
        case 3://同意
        {
            if (self.blockAgree) {
                self.blockAgree();
            }
        }
            break;
        default:
            break;
    }
}

@end
