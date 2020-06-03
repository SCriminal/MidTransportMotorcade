//
//  OrderDetailPackageView.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/7.
//Copyright © 2019 ping. All rights reserved.
//

#import "OrderDetailPackageView.h"
//location vc
#import "CarLocationVC.h"


@interface OrderDetailPackageView ()

@end

@implementation OrderDetailPackageView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _labelTitle;
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
        self.clipsToBounds = false;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.labelTitle];
    
    //初始化页面
    [self resetViewWithAry:nil];
}

#pragma mark 刷新view
- (void)resetViewWithAry:(NSArray *)models{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    self.aryDatas = models;
    //刷新view
    [self.labelTitle fitTitle:@"货物信息" variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    CGFloat top = self.labelTitle.bottom + W(40);
    for (int i = 0; i<self.aryDatas.count; i++) {
        OrderDetailPackageItemView * itemView = [OrderDetailPackageItemView new];
        itemView.tag = TAG_LINE;
        itemView.modelOrder = self.modelOrder;
        itemView.blockInputNum = self.blockInputNum;
        [itemView resetViewWithModel:self.aryDatas[i]];
        if (i == self.aryDatas.count -1) {
            itemView.line.hidden = true;
        }
        itemView.top = top;
        [self addSubview:itemView];
        top = itemView.bottom + W(20);
    }
    
    self.height = top;
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
    
}

@end



@implementation OrderDetailPackageItemView
#pragma mark 懒加载
- (UILabel *)labelPackageType{
    if (_labelPackageType == nil) {
        _labelPackageType = [UILabel new];
        _labelPackageType.textColor = COLOR_333;
        _labelPackageType.font =  [UIFont systemFontOfSize:F(16) ];
        _labelPackageType.numberOfLines = 1;
        _labelPackageType.lineSpace = 0;
    }
    return _labelPackageType;
}
- (UILabel *)labelStatus{
    if (_labelStatus == nil) {
        _labelStatus = [UILabel new];
        _labelStatus.textColor = [UIColor whiteColor];
        _labelStatus.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        [GlobalMethod setRoundView:_labelStatus color:[UIColor clearColor] numRound:3 width:0];
        _labelStatus.numberOfLines = 1;
        _labelStatus.textAlignment = NSTextAlignmentCenter;
        _labelStatus.lineSpace = 0;
        _labelStatus.backgroundColor = COLOR_BLUE;
    }
    return _labelStatus;
}
- (UILabel *)labelPackageNum{
    if (_labelPackageNum == nil) {
        _labelPackageNum = [UILabel new];
        _labelPackageNum.textColor = COLOR_666;
        _labelPackageNum.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelPackageNum.numberOfLines = 1;
        _labelPackageNum.lineSpace = 0;
    }
    return _labelPackageNum;
}
- (UILabel *)labelDriver{
    if (_labelDriver == nil) {
        _labelDriver = [UILabel new];
        _labelDriver.textColor = COLOR_666;
        _labelDriver.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelDriver.numberOfLines = 1;
        _labelDriver.lineSpace = 0;
    }
    return _labelDriver;
}
- (UILabel *)labelCar{
    if (_labelCar == nil) {
        _labelCar = [UILabel new];
        _labelCar.textColor = COLOR_666;
        _labelCar.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelCar.numberOfLines = 1;
        _labelCar.lineSpace = 0;
    }
    return _labelCar;
}
- (UILabel *)labelPlumbemNum{
    if (_labelPlumbemNum == nil) {
        _labelPlumbemNum = [UILabel new];
        _labelPlumbemNum.textColor = COLOR_666;
        _labelPlumbemNum.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelPlumbemNum.numberOfLines = 1;
        _labelPlumbemNum.lineSpace = 0;
    }
    return _labelPlumbemNum;
}
- (UILabel *)labelWeight{
    if (_labelWeight == nil) {
        _labelWeight = [UILabel new];
        _labelWeight.textColor = COLOR_666;
        _labelWeight.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelWeight.numberOfLines = 1;
        _labelWeight.lineSpace = 0;
    }
    return _labelWeight;
}
- (UILabel *)labelPrice{
    if (_labelPrice == nil) {
        _labelPrice = [UILabel new];
        _labelPrice.textColor = COLOR_666;
        _labelPrice.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelPrice.numberOfLines = 1;
        _labelPrice.lineSpace = 0;
    }
    return _labelPrice;
}
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        _labelName.textColor = COLOR_666;
        _labelName.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelName.numberOfLines = 1;
        _labelName.lineSpace = 0;
    }
    return _labelName;
}
- (UIView *)line{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = COLOR_LINE;
    }
    return _line;
}
- (UIImageView *)ivArrow{
    if (!_ivArrow) {
        _ivArrow = [UIImageView new];
        _ivArrow.image = [UIImage imageNamed:@"setting_RightArrow"];
        _ivArrow.backgroundColor = [UIColor clearColor];
        _ivArrow.widthHeight = XY(W(25),W(25));
    }
    return _ivArrow;
}
- (UIImageView *)ivInputNum{
    if (!_ivInputNum) {
        _ivInputNum = [UIImageView new];
        _ivInputNum.image = [UIImage imageNamed:@"orderDetail_edit"];
        _ivInputNum.backgroundColor = [UIColor clearColor];
        _ivInputNum.widthHeight = XY(W(25),W(25));
    }
    return _ivInputNum;
}
- (UIImageView *)ivInputSealNum{
    if (!_ivInputSealNum) {
        _ivInputSealNum = [UIImageView new];
        _ivInputSealNum.image = [UIImage imageNamed:@"orderDetail_edit"];
        _ivInputSealNum.backgroundColor = [UIColor clearColor];
        _ivInputSealNum.widthHeight = XY(W(25),W(25));
    }
    return _ivInputSealNum;
}
- (UIButton *)conInputNum{
    if (!_conInputNum) {
        _conInputNum = [UIButton buttonWithType:UIButtonTypeCustom];
        _conInputNum.backgroundColor = [UIColor clearColor];
        [_conInputNum addTarget:self action:@selector(inputNumClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _conInputNum;
}
- (UIButton *)conInputSealNum{
    if (!_conInputSealNum) {
        _conInputSealNum = [UIButton buttonWithType:UIButtonTypeCustom];
        _conInputSealNum.backgroundColor = [UIColor clearColor];
        [_conInputSealNum addTarget:self action:@selector(inputSealNumClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _conInputSealNum;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        [self addTarget:self action:@selector(click)];
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.labelPackageType];
    [self addSubview:self.labelStatus];
    [self addSubview:self.labelPackageNum];
    [self addSubview:self.labelPlumbemNum];
    [self addSubview:self.labelCar];
    [self addSubview:self.labelDriver];
    [self addSubview:self.labelWeight];
    [self addSubview:self.labelPrice];
    [self addSubview:self.labelName];
    [self addSubview:self.line];
    [self addSubview:self.ivArrow];
    [self addSubview:self.ivInputNum];
    [self addSubview:self.ivInputSealNum];

    [self addSubview:self.conInputNum];
    [self addSubview:self.conInputSealNum];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelPackageInfo *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelPackageType fitTitle:[NSString stringWithFormat:@"箱型：%@*1",UnPackStr(model.containerTypeShow)] variable:SCREEN_WIDTH - W(50)];
    self.labelPackageType.leftTop = XY(W(25),W(0));
    [self.labelStatus fitTitle:[ModelPackageInfo transformNameWithPackageState:model.cargoState orderType:self.modelOrder.orderType] variable:0];
    self.labelStatus.backgroundColor = [ModelPackageInfo transformColorWithPackageState:model.cargoState];
    self.labelStatus.widthHeight = XY(self.labelStatus.width + W(8), self.labelPackageType.height);
    self.labelStatus.leftCenterY = XY(self.labelPackageType.right + W(5),self.labelPackageType.centerY);
  
    
    [self.labelName fitTitle:[NSString stringWithFormat:@"货物名称：%@",UnPackStr(model.cargoName)] variable:SCREEN_WIDTH - W(50)];
    self.labelName.leftTop = XY(self.labelPackageType.left,self.labelPackageType.bottom+W(15));

    
    self.labelCar.hidden = !self.model.isTransporting;
    [self.labelCar fitTitle:[NSString stringWithFormat:@"车辆：%@",UnPackStr(model.truckNumber)] variable:SCREEN_WIDTH/2.0-W(25)];
    self.labelCar.leftTop = XY(self.labelPackageType.left,self.labelName.bottom+W(15));
    
    self.labelDriver.hidden = !self.model.isTransporting;
    [self.labelDriver fitTitle:[NSString stringWithFormat:@"司机：%@",UnPackStr(model.driverName)] variable:SCREEN_WIDTH/2.0-W(25)];
    self.labelDriver.leftCenterY = XY(SCREEN_WIDTH/2.0,self.labelCar.centerY);
    
    [self.labelPackageNum fitTitle:[NSString stringWithFormat:@"箱号：%@",UnPackStr(model.containerNumber)] variable:SCREEN_WIDTH-W(70)];
    self.labelPackageNum.leftTop = XY(self.labelPackageType.left,self.model.isTransporting?(self.labelCar.bottom+W(15)):(self.labelName.bottom+W(15)));
    self.conInputNum.frame = CGRectMake(0, self.labelPackageNum.top - W(3), SCREEN_WIDTH- W(50), self.labelPackageNum.height + W(6));
    self.ivInputNum.leftCenterY = XY(self.labelPackageNum.right + W(3), self.labelPackageNum.centerY);

    
    [self.labelPlumbemNum fitTitle:[NSString stringWithFormat:@"铅封号：%@",UnPackStr(model.sealNumber)] variable:SCREEN_WIDTH-W(70)];
    self.labelPlumbemNum.leftTop = XY(self.labelPackageType.left,self.labelPackageNum.bottom + W(15));
    self.conInputSealNum.frame = CGRectMake(0, self.labelPlumbemNum.top - W(3), SCREEN_WIDTH- W(50), self.labelPlumbemNum.height + W(6));
    self.ivInputSealNum.leftCenterY = XY(self.labelPlumbemNum.right + W(3), self.labelPlumbemNum.centerY);

    [self.labelWeight fitTitle:[NSString stringWithFormat:@"单箱货重：%@",model.weightShow] variable:SCREEN_WIDTH/2.0-W(25)];
    self.labelWeight.leftTop = XY(self.labelPackageType.left,self.labelPlumbemNum.bottom+W(15));
    [self.labelPrice fitTitle:[NSString stringWithFormat:@"单箱运费：￥%.2f",model.price/100.0] variable:SCREEN_WIDTH/2.0-W(25)];
    self.labelPrice.leftCenterY = XY(SCREEN_WIDTH/2.0,self.labelWeight.centerY);
    
    //设置总高度
    self.height = self.labelPrice.bottom + W(20);
    self.line.frame = CGRectMake(self.labelPackageType.left, self.height - 1, SCREEN_WIDTH - self.labelPackageType.left*2, 1);
    self.ivArrow.rightCenterY = XY(SCREEN_WIDTH - W(20), self.labelPackageNum.centerY);
    self.ivArrow.hidden = !self.model.isTransporting;
}

- (void)click{
    if (self.model.isTransporting) {
        CarLocationVC * vc = [CarLocationVC new];
        vc.modelPackage = self.model;
        [GB_Nav pushViewController:vc animated:true];
    }
}
- (void)inputNumClick{
    if (self.blockInputNum) {
        self.blockInputNum(self.model, true);
    }
}
- (void)inputSealNumClick{
    if (self.blockInputNum) {
        self.blockInputNum(self.model, false);
    }
}

@end
