//
//  OrderDetailTopView.m
//  Driver
//
//  Created by 隋林栋 on 2018/12/6.
//Copyright © 2018 ping. All rights reserved.
//

#import "OrderDetailTopView.h"

@interface OrderDetailTopView ()

@end

@implementation OrderDetailTopView
#pragma mark 懒加载
- (UILabel *)labelBill{
    if (_labelBill == nil) {
        _labelBill = [UILabel new];
        _labelBill.textColor = COLOR_333;
        _labelBill.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelBill.numberOfLines = 0;
        _labelBill.lineSpace = 0;
    }
    return _labelBill;
}
- (UILabel *)labelBillNo{
    if (_labelBillNo == nil) {
        _labelBillNo = [UILabel new];
        _labelBillNo.textColor = COLOR_333;
        _labelBillNo.font =  [UIFont systemFontOfSize:F(22) weight:UIFontWeightSemibold];
        _labelBillNo.numberOfLines = 0;
        _labelBillNo.lineSpace = 0;
    }
    return _labelBillNo;
}
- (UILabel *)labelOrderNo{
    if (_labelOrderNo == nil) {
        _labelOrderNo = [UILabel new];
        _labelOrderNo.textColor = COLOR_666;
        _labelOrderNo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelOrderNo.numberOfLines = 0;
        _labelOrderNo.lineSpace = 0;
    }
    return _labelOrderNo;
}
- (UILabel *)labelOrderType{
    if (_labelOrderType == nil) {
        _labelOrderType = [UILabel new];
        _labelOrderType.textColor = COLOR_666;
        _labelOrderType.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelOrderType.numberOfLines = 0;
        _labelOrderType.lineSpace = 0;
    }
    return _labelOrderType;
}
- (UILabel *)labelShipCompanyName{
    if (_labelShipCompanyName == nil) {
        _labelShipCompanyName = [UILabel new];
        _labelShipCompanyName.textColor = COLOR_666;
        _labelShipCompanyName.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelShipCompanyName.numberOfLines = 0;
        _labelShipCompanyName.lineSpace = 0;
    }
    return _labelShipCompanyName;
}
- (UILabel *)labelShipName{
    if (_labelShipName == nil) {
        _labelShipName = [UILabel new];
        _labelShipName.textColor = COLOR_666;
        _labelShipName.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelShipName.numberOfLines = 0;
        _labelShipName.lineSpace = 0;
    }
    return _labelShipName;
}
- (UILabel *)labelShipNumber{
    if (_labelShipNumber == nil) {
        _labelShipNumber = [UILabel new];
        _labelShipNumber.textColor = COLOR_666;
        _labelShipNumber.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelShipNumber.numberOfLines = 0;
        _labelShipNumber.lineSpace = 0;
    }
    return _labelShipNumber;
}
- (UILabel *)labelZhongcheyun{
    if (_labelZhongcheyun == nil) {
        _labelZhongcheyun = [UILabel new];
        _labelZhongcheyun.textColor = COLOR_666;
        _labelZhongcheyun.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelZhongcheyun.numberOfLines = 0;
        _labelZhongcheyun.lineSpace = 0;
    }
    return _labelZhongcheyun;
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
        [self addTarget:self action:@selector(copyCodeClick)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.labelBill];
    [self addSubview:self.labelBillNo];
    [self addSubview:self.labelOrderNo];
    [self addSubview:self.labelOrderType];
    [self addSubview:self.labelShipCompanyName];
    [self addSubview:self.labelShipName];
    [self addSubview:self.labelShipNumber];
    [self addSubview:self.labelZhongcheyun];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderList *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelBill fitTitle:@"提单号" variable:0];
    self.labelBill.centerXTop = XY(SCREEN_WIDTH/2.0,W(25));
    [self.labelBillNo fitTitle:UnPackStr(model.blNumber ) variable:0];
    self.labelBillNo.centerXTop = XY(SCREEN_WIDTH/2.0,self.labelBill.bottom + W(25));
    
    [self addLineFrame:CGRectMake(W(25), self.labelBillNo.bottom + W(25), SCREEN_WIDTH - W(50), 1)];
    
    [self.labelOrderNo fitTitle:[NSString stringWithFormat:@"运单编号：%@",UnPackStr(model.waybillNumber)] variable:SCREEN_WIDTH - W(50)];
    self.labelOrderNo.leftTop = XY(W(25),self.labelBillNo.bottom+W(45));
    
    [self.labelOrderType fitTitle:[NSString stringWithFormat:@"运单类型：%@",model.orderType== ENUM_ORDER_TYPE_INPUT?@"进口":@"出口"] variable:SCREEN_WIDTH - W(50)];
    self.labelOrderType.leftTop = XY(W(25),self.labelOrderNo.bottom+W(20));

    
    [self.labelShipCompanyName fitTitle:[NSString stringWithFormat: @"船  公 司：%@",UnPackStr(model.shippingLineName)] variable:SCREEN_WIDTH - W(50)];
    self.labelShipCompanyName.leftTop = XY(W(25),self.labelOrderType.bottom+W(20));
    
    [self.labelShipName fitTitle:[NSString stringWithFormat: @"船      名：%@",UnPackStr(model.oceanVessel)] variable:SCREEN_WIDTH - W(50)];
    self.labelShipName.leftTop = XY(W(25),self.labelShipCompanyName.bottom+W(20));
    
    [self.labelShipNumber fitTitle:[NSString stringWithFormat: @"航      次：%@",UnPackStr(model.voyageNumber)] variable:SCREEN_WIDTH - W(50)];
    self.labelShipNumber.leftTop = XY(W(25),self.labelShipName.bottom+W(20));

    [self.labelZhongcheyun fitTitle:@"托  运 方：中车运" variable:SCREEN_WIDTH - W(50)];
    self.labelZhongcheyun.leftTop = XY(W(25),self.labelShipNumber.bottom+W(20));

    //设置总高度
    self.height = self.labelZhongcheyun.bottom+W(20);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}

#pragma mark 点击事件
- (void)copyCodeClick{
    [GlobalMethod copyToPlte:self.model.blNumber];
    [GlobalMethod showAlert:@"提单号已经复制"];
}
@end



@implementation OrderDetailStatusView
#pragma mark 懒加载
- (UILabel *)labelStatus{
    if (_labelStatus == nil) {
        _labelStatus = [UILabel new];
        _labelStatus.textColor = COLOR_333;
        _labelStatus.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelStatus.numberOfLines = 0;
        _labelStatus.lineSpace = 0;
    }
    return _labelStatus;
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
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.labelStatus];
}

#pragma mark 刷新view
- (void)resetViewWithAry:(NSArray *)ary{
    self.aryDatas = ary;
    [self removeAllSubViews];//移除线
    [self addSubView];
    //刷新view
    [self.labelStatus fitTitle:@"运单状态" variable:0];
    self.labelStatus.leftTop = XY(W(25),W(20));
    [self addLineFrame:CGRectMake(W(25), self.labelStatus.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    NSMutableArray * aryModels = [NSMutableArray array];
    for (ModelOrderOperateTimeItem * item in ary) {
        ModelBtn * model = [ModelBtn new];
//        model.title = [ModelOrderList transformOrderStatusToName:item.formState orderType:item.orderType];
        model.title = [ModelOrderList transformOrderStatusToCompleteName:item.formState ];

        model.subTitle = [GlobalMethod exchangeTimeWithStamp:item.stateTime andFormatter:TIME_SEC_SHOW];
        model.isSelected = true;
        [aryModels addObject:model];
    }
    
    CGFloat top = self.labelStatus.bottom + W(50);
    for (int i = 0; i<aryModels.count; i++) {
        ModelBtn * model = aryModels[i];
        UILabel * label = [UILabel new];
        label.fontNum = F(15);
        label.textColor = model.isSelected?COLOR_333:COLOR_666;
        [label fitTitle:model.title variable:0];
        label.leftTop = XY(W(25), top);
        [self addSubview:label];
        top = label.bottom + W(35);
        
        UIView * viewDot = [UIView new];
        viewDot.widthHeight = XY(W(7), W(7));
        [GlobalMethod setRoundView:viewDot color:[UIColor clearColor] numRound:viewDot.width/2.0 width:0];
        viewDot.backgroundColor = model.isSelected?COLOR_BLUE:COLOR_666;
        viewDot.leftCenterY = XY(label.right + W(20), label.centerY);
        if (i!=aryModels.count -1) {
            [self addLineFrame:CGRectMake(viewDot.centerX, viewDot.centerY, 1, W(35)+label.height) color:viewDot.backgroundColor];
        }
        [self addSubview:viewDot];
        
        
        UILabel * labelTime = [UILabel new];
        labelTime.fontNum = F(15);
        labelTime.textColor = model.isSelected?COLOR_333:COLOR_666;
        [labelTime fitTitle:UnPackStr(model.subTitle) variable:0];
        labelTime.leftCenterY = XY(viewDot.right + W(25), label.centerY);
        [self addSubview:labelTime];
        
    }
    
    //设置总高度
    self.height = top - W(5);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}


@end





@implementation OrderDetailPathView
#pragma mark 懒加载
- (UILabel *)labelPath{
    if (_labelPath == nil) {
        _labelPath = [UILabel new];
        _labelPath.textColor = COLOR_333;
        _labelPath.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _labelPath;
}
- (UILabel *)labelAddressFrom{
    if (_labelAddressFrom == nil) {
        _labelAddressFrom = [UILabel new];
        _labelAddressFrom.textColor = COLOR_333;
        _labelAddressFrom.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelAddressFrom.numberOfLines = 0;
        _labelAddressFrom.lineSpace = 0;
    }
    return _labelAddressFrom;
}
- (UILabel *)labelAddressTo{
    if (_labelAddressTo == nil) {
        _labelAddressTo = [UILabel new];
        _labelAddressTo.textColor = COLOR_333;
        _labelAddressTo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelAddressTo.numberOfLines = 0;
        _labelAddressTo.lineSpace = 0;
    }
    return _labelAddressTo;
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
    [self addSubview:self.labelPath];
    [self addSubview:self.labelAddressFrom];
    [self addSubview:self.labelAddressTo];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderList *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelPath fitTitle:@"路线信息" variable:0];
    self.labelPath.leftTop = XY(W(25),W(20));
    
    [self addLineFrame:CGRectMake(W(25), self.labelPath.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    [self.labelAddressFrom fitTitle:[NSString stringWithFormat:@"%@：%@",model.orderType == ENUM_ORDER_TYPE_INPUT?@"提箱港":@"提箱点",UnPackStr(model.backPackageAddressShow)] variable:SCREEN_WIDTH - W(57)*2];
    self.labelAddressFrom.leftTop = XY(W(57),self.labelPath.bottom+W(40));
    [self.labelAddressTo fitTitle:[NSString stringWithFormat:@"%@：%@",model.orderType == ENUM_ORDER_TYPE_INPUT?@"卸货地":@"装货地",UnPackStr(model.loadAddressShow)] variable:SCREEN_WIDTH - W(57)*2];
    self.labelAddressTo.leftTop = XY(self.labelAddressFrom.left,self.labelAddressFrom.bottom+W(20));

    UIView * viewDot = [UIView new];
    viewDot.widthHeight = XY(W(7), W(7));
    [GlobalMethod setRoundView:viewDot color:[UIColor clearColor] numRound:viewDot.width/2.0 width:0];
    viewDot.backgroundColor = COLOR_BLUE;
    viewDot.leftCenterY = XY( W(30), self.labelAddressFrom.centerY);
    [self addLineFrame:CGRectMake(viewDot.centerX-1, viewDot.centerY, 1, self.labelAddressTo.centerY - self.labelAddressFrom.centerY)];
    viewDot.tag = TAG_LINE;
    [self addSubview:viewDot];
    
    UIView * viewDotRed = [UIView new];
    viewDotRed.widthHeight = XY(W(7), W(7));
    [GlobalMethod setRoundView:viewDotRed color:[UIColor clearColor] numRound:viewDot.width/2.0 width:0];
    viewDotRed.backgroundColor = COLOR_RED;
    viewDotRed.leftCenterY = XY( W(30), self.labelAddressTo.centerY);
    [self addSubview:viewDotRed];
    viewDotRed.tag = TAG_LINE;
    
    self.height = self.labelAddressTo.bottom + W(20);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
    
}

@end


@implementation OrderDetailLoadView
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
        [self addTarget:self action:@selector(phoneClick)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.labelTitle];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderList *)modelOrder{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.model = modelOrder;
    //刷新view
    [self.labelTitle fitTitle:modelOrder.orderType == ENUM_ORDER_TYPE_INPUT?@"卸货信息":@"装货信息" variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    
    [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    NSArray * aryModels = @[^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"联系人员：";
        model.subTitle = UnPackStr(modelOrder.placeContact);
        model.isSelected = false;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"联系电话：";
        model.subTitle = UnPackStr(modelOrder.placePhone);
        model.isSelected = true;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = modelOrder.orderType == ENUM_ORDER_TYPE_INPUT?@"卸货时间：":@"装货时间：";
        model.subTitle = [GlobalMethod exchangeTimeWithStamp:modelOrder.placeTime andFormatter:TIME_SEC_SHOW];
        model.isSelected = false;
        return model;
    }()];
    CGFloat top = self.labelTitle.bottom + W(40);
    for (int i = 0; i<aryModels.count; i++) {
        ModelBtn * model = aryModels[i];
        UILabel * label = [UILabel new];
        label.fontNum = F(15);
        label.textColor = COLOR_333;
        [label fitTitle:model.title variable:0];
        label.leftTop = XY(W(25), top);
        label.tag = TAG_LINE;
        [self addSubview:label];
        top = label.bottom + W(20);
        
        
        UILabel * labelTime = [UILabel new];
        labelTime.fontNum = F(15);
        labelTime.textColor = model.isSelected?COLOR_BLUE:COLOR_333;
        [labelTime fitTitle:UnPackStr(model.subTitle) variable:0];
        labelTime.leftCenterY = XY(label.right + W(2), label.centerY);
        labelTime.tag = TAG_LINE;
        [self addSubview:labelTime];
        
    }
    
    self.height = top;
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
    
}
#pragma mark click
- (void)phoneClick{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",UnPackStr(self.model.placePhone)];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
@end
@implementation OrderDetailStationView
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
        [self resetViewWithModel:nil];
    }
    return self;
}


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderList *)modelOrder{
    [self removeAllSubViews];//移除线
    [self addSubview:self.ivBg];
    [self addSubview:self.labelTitle];
    
    self.model = modelOrder;
    //刷新view
    [self.labelTitle fitTitle:@"场站信息" variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    NSArray * aryModels ;
    if (modelOrder.orderType == ENUM_ORDER_TYPE_INPUT) {
        aryModels = @[^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"提  箱  港：";
            model.subTitle = UnPackStr(modelOrder.startAreaName);
            model.isSelected = false;
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"提箱港区：";
            model.subTitle = UnPackStr(modelOrder.startCyName);
            model.isSelected = false;
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"联系人员：";
            model.subTitle = UnPackStr(modelOrder.startContact);
            model.isSelected = false;
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"联系电话：";
            model.subTitle = UnPackStr(modelOrder.startPhone);
            model.isSelected = true;
            model.tag = 1;
            return model;
        }()];
    }else {
        aryModels = @[^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"提  箱  点：";
            model.subTitle = UnPackStr(modelOrder.startCyName);
            model.isSelected = false;
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"联系人员：";
            model.subTitle = UnPackStr(modelOrder.startContact);
            model.isSelected = false;
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"联系电话：";
            model.subTitle = UnPackStr(modelOrder.startPhone);
            model.isSelected = true;
            model.tag = 1;
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"还  箱  点：";
            model.subTitle = UnPackStr(modelOrder.endCyName);
            model.isSelected = false;
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"联系人员：";
            model.subTitle = UnPackStr(modelOrder.endContact);
            model.isSelected = false;
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"联系电话：";
            model.subTitle = UnPackStr(modelOrder.endPhone);
            model.isSelected = true;
            model.tag = 2;
            return model;
        }()];
    }
    
    CGFloat top = self.labelTitle.bottom + W(40);
    for (int i = 0; i<aryModels.count; i++) {
        ModelBtn * model = aryModels[i];
        UILabel * label = [UILabel new];
        label.fontNum = F(15);
        label.textColor = COLOR_333;
        [label fitTitle:model.title variable:0];
        label.leftTop = XY(W(25), top);
        label.tag = TAG_LINE;
        [self addSubview:label];
        top = label.bottom + W(20);
        
        
        UILabel * labelTime = [UILabel new];
        labelTime.fontNum = F(15);
        labelTime.textColor = model.isSelected?COLOR_BLUE:COLOR_333;
        [labelTime fitTitle:UnPackStr(model.subTitle) variable:0];
        labelTime.tag = TAG_LINE;
        labelTime.leftCenterY = XY(label.right + W(2), label.centerY);
        [self addSubview:labelTime];
        
        if (model.isSelected) {
            UIView * con =  [self addControlFrame:CGRectInset(labelTime.frame, -W(100), -W(20)) belowView:labelTime target:self action:@selector(click:)];
            con.tag = model.tag;
        }
        
    }
    
    self.height = top;
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
    
}

#pragma mark click
- (void)click:(UIControl *)con{
    switch (con.tag) {
        case 1:
        {
            NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",UnPackStr(self.model.startPhone)];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }
            break;
        case 2:
        {
            NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",UnPackStr(self.model.endPhone)];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }
            break;
        default:
            break;
    }
}
@end



@implementation OrderDetailRemarkView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _labelTitle;
}
- (UILabel *)labelSubTitle{
    if (_labelSubTitle == nil) {
        _labelSubTitle = [UILabel new];
        _labelSubTitle.textColor = COLOR_333;
        _labelSubTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelSubTitle.numberOfLines = 0;
        _labelSubTitle.lineSpace = W(8);
    }
    return _labelSubTitle;
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
        self.clipsToBounds = false;
        self.width = SCREEN_WIDTH;
        [self addSubView];
        [self addTarget:self action:@selector(phoneClick)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.labelTitle];
    [self addSubview:self.labelSubTitle];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelOrderList *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelTitle fitTitle:@"备注信息" variable:0];
    self.labelTitle.leftTop = XY(W(25),W(20));
    [self addLineFrame:CGRectMake(W(25), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(50), 1)];
    
    [self.labelSubTitle fitTitle:model.iDPropertyDescription variable:SCREEN_WIDTH - W(50)];
    self.labelSubTitle.leftTop = XY(self.labelTitle.left, self.labelTitle.bottom + W(35));
    
    self.height = self.labelSubTitle.bottom + W(15);
    self.ivBg.frame = CGRectMake(0, -W(10), SCREEN_WIDTH, self.height + W(20));
}

@end
