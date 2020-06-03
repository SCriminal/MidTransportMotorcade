//
//  OrderListCell.m
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import "OrderListCell.h"
//order detail vc
#import "OrderDetailVC.h"
//request
#import "RequestApi+Order.h"

@interface OrderListCell ()

@end

@implementation OrderListCell
#pragma mark 懒加载
- (UILabel *)labelBillNo{
    if (_labelBillNo == nil) {
        _labelBillNo = [UILabel new];
        _labelBillNo.textColor = COLOR_333;
        _labelBillNo.font =  [UIFont systemFontOfSize:F(16) ];
        _labelBillNo.numberOfLines = 1;
        _labelBillNo.lineSpace = 0;
    }
    return _labelBillNo;
}
- (UIImageView *)ivOrder{
    if (_ivOrder == nil) {
        _ivOrder = [UIImageView new];
        _ivOrder.image = [UIImage imageNamed:@"order_cellOrder"];
        _ivOrder.widthHeight = XY(W(25),W(25));
    }
    return _ivOrder;
}
- (UILabel *)labelCompanyName{
    if (_labelCompanyName == nil) {
        _labelCompanyName = [UILabel new];
        _labelCompanyName.textColor = COLOR_333;
        _labelCompanyName.fontNum =  F(15);
        _labelCompanyName.numberOfLines = 1;
        _labelCompanyName.lineSpace = 0;
    }
    return _labelCompanyName;
}
- (UILabel *)labelOrderNo{
    if (_labelOrderNo == nil) {
        _labelOrderNo = [UILabel new];
        _labelOrderNo.textColor = COLOR_999;
        _labelOrderNo.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _labelOrderNo.numberOfLines = 1;
        _labelOrderNo.lineSpace = 0;
    }
    return _labelOrderNo;
}
- (UILabel *)labelStatus{
    if (_labelStatus == nil) {
        _labelStatus = [UILabel new];
        _labelStatus.textColor = COLOR_BLUE;
        _labelStatus.font =  [UIFont systemFontOfSize:F(15) ];
        _labelStatus.numberOfLines = 1;
        _labelStatus.lineSpace = 0;
    }
    return _labelStatus;
}

- (UILabel *)labelAddressFrom{
    if (_labelAddressFrom == nil) {
        _labelAddressFrom = [UILabel new];
        _labelAddressFrom.textColor = COLOR_333;
        _labelAddressFrom.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelAddressFrom.numberOfLines = 1;
        _labelAddressFrom.lineSpace = 0;
    }
    return _labelAddressFrom;
}
- (UILabel *)labelAddressTo{
    if (_labelAddressTo == nil) {
        _labelAddressTo = [UILabel new];
        _labelAddressTo.textColor = COLOR_333;
        _labelAddressTo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelAddressTo.numberOfLines = 1;
        _labelAddressTo.lineSpace = 0;
    }
    return _labelAddressTo;
}
- (UILabel *)labelPriceAll{
    if (_labelPriceAll == nil) {
        _labelPriceAll = [UILabel new];
        _labelPriceAll.textColor = COLOR_333;
        _labelPriceAll.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelPriceAll.numberOfLines = 1;
        _labelPriceAll.lineSpace = 0;
    }
    return _labelPriceAll;
}

- (UIImageView *)ivCompanyLogo{
    if (_ivCompanyLogo == nil) {
        _ivCompanyLogo = [UIImageView new];
        _ivCompanyLogo.image = [UIImage imageNamed:IMAGE_HEAD_COMPANY_DEFAULT];
        _ivCompanyLogo.widthHeight = XY(W(25),W(25));
        [GlobalMethod setRoundView:_ivCompanyLogo color:[UIColor clearColor] numRound:_ivCompanyLogo.width/2.0 width:0];
    }
    return _ivCompanyLogo;
}

- (UIImageView *)ivBg{
    if (_ivBg == nil) {
        _ivBg = [UIImageView new];
        _ivBg.image = IMAGE_WHITE_BG;
        _ivBg.backgroundColor = [UIColor clearColor];
    }
    return _ivBg;
}
- (UIView *)viewBG{
    if (!_viewBG) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor clearColor];
    }
    return _viewBG;
}
- (UIView *)dotBlue{
    if (_dotBlue == nil) {
        _dotBlue = [UIView new];
        _dotBlue.backgroundColor = COLOR_BLUE;
        _dotBlue.widthHeight = XY(W(7), W(7));
        [GlobalMethod setRoundView:_dotBlue color:[UIColor clearColor] numRound:_dotBlue.width/2.0 width:0];
        
    }
    return _dotBlue;
}
- (UIView *)lineVertical{
    if (_lineVertical == nil) {
        _lineVertical = [UIView new];
        _lineVertical.backgroundColor = COLOR_LINE;
    }
    return _lineVertical;
}
- (UIView *)dotRed{
    if (_dotRed == nil) {
        _dotRed = [UIView new];
        _dotRed.backgroundColor = COLOR_RED;
        _dotRed.widthHeight = XY(W(7), W(7));
        [GlobalMethod setRoundView:_dotRed color:[UIColor clearColor] numRound:_dotRed.width/2.0 width:0];
    }
    return _dotRed;
}

- (UIView *)viewGray{
    if (!_viewGray) {
        _viewGray = [UIView new];
        _viewGray.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
        _viewGray.width = SCREEN_WIDTH;
    }
    return _viewGray;
}


#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = COLOR_BACKGROUND;
        self.backgroundColor = COLOR_BACKGROUND;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = false;
        self.contentView.clipsToBounds = false;
        [self.contentView addSubview:self.ivBg];
        [self.contentView addSubview:self.viewBG];
        [self.viewBG addSubview:self.viewGray];
        [self.viewBG addSubview:self.labelBillNo];
        [self.viewBG addSubview:self.labelOrderNo];
        [self.viewBG addSubview:self.labelStatus];
        [self.viewBG addSubview:self.labelAddressFrom];
        [self.viewBG addSubview:self.labelAddressTo];
        [self.viewBG addSubview:self.labelPriceAll];
        [self.viewBG addSubview:self.ivCompanyLogo];
        [self.viewBG addSubview:self.lineVertical];
        [self.viewBG addSubview:self.dotBlue];
        [self.viewBG addSubview:self.dotRed];
        [self.viewBG addSubview:self.labelCompanyName];
        [self.viewBG addSubview:self.ivOrder];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelOrderList *)model{
    self.model = model;
    [self.viewBG removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.viewBG.frame = CGRectMake(W(10), W(10), SCREEN_WIDTH - W(20), W(292));
    
    [self.labelStatus fitTitle:model.orderStatusShow variable:0];
    self.labelStatus.rightTop = XY(self.viewBG.width - W(15),W(20));
    
    self.ivCompanyLogo.leftCenterY = XY(W(15), self.labelStatus.centerY);
    
    [self.labelCompanyName fitTitle:UnPackStr(model.shipperName) variable:self.labelStatus.left - W(40) - self.ivCompanyLogo.right];
    self.labelCompanyName.leftCenterY = XY(self.ivCompanyLogo.right + W(10), self.labelStatus.centerY);
    
    self.viewGray.width = SCREEN_WIDTH - 20;
    self.viewGray.centerXTop = XY(self.viewBG.width/2.0, self.labelStatus.bottom + W(20));
    
    self.ivOrder.centerXTop = XY(self.ivCompanyLogo.centerY, self.viewGray.top + W(30));
    
    [self.labelBillNo fitTitle:[NSString stringWithFormat:@"提单号：%@",UnPackStr(model.blNumber)] variable:self.viewBG.width - W(20) - self.ivOrder.right];
    self.labelBillNo.leftTop = XY(self.ivOrder.right + W(10),self.viewGray.top + W(20));
    
    [self.labelOrderNo fitTitle:[NSString stringWithFormat:@"运单编号：%@",UnPackStr(model.waybillNumber)] variable:self.viewBG.width - W(20)- self.ivOrder.right];
    self.labelOrderNo.leftTop = XY(self.labelBillNo.left,self.labelBillNo.bottom + W(13));
    
    
    CGFloat bottom =  [self.viewBG addLineFrame:CGRectMake(W(15), self.labelOrderNo.bottom + W(20), self.viewBG.width - W(30), 1)];
    
    
    self.dotBlue.centerXTop = XY(self.ivCompanyLogo.centerX, bottom + W(22));
    
    [self.labelAddressFrom fitTitle:[NSString stringWithFormat:@"%@：%@",model.orderType == ENUM_ORDER_TYPE_INPUT?@"提箱港":@"提箱点",UnPackStr(model.backPackageAddressShow)] variable:self.viewBG.width - self.dotBlue.right - W(40)];
    self.labelAddressFrom.leftCenterY = XY(self.dotBlue.right + W(20),self.dotBlue.centerY);
    
    self.dotRed.centerXTop = XY(self.ivCompanyLogo.centerX, self.dotBlue.bottom + W(28));
    [self.labelAddressTo fitTitle:[NSString stringWithFormat:@"%@：%@",model.orderType == ENUM_ORDER_TYPE_INPUT?@"卸货地":@"装货地",UnPackStr(model.loadAddressShow)] variable:self.viewBG.width - self.dotBlue.right - W(40)];
    self.labelAddressTo.leftCenterY = XY(self.labelAddressFrom.left,self.dotRed.centerY);
    
    self.lineVertical.frame = CGRectMake(self.dotRed.centerX-1, self.dotRed.centerY, 1, self.dotBlue.centerY - self.dotRed.centerY);
    
    self.viewGray.height =  self.labelAddressTo.bottom + W(20)-self.viewGray.top;
    
    [self.labelPriceAll fitTitle:[NSString stringWithFormat:@"总箱量:%.f个  合计运费:￥%.2f",model.total,model.price/100.0] variable:self.viewBG.width - W(40)];
    
    self.labelPriceAll.rightTop = XY(self.viewBG.width - W(15),self.viewGray.bottom + W(15));
    
    NSMutableArray * aryBtns = [NSMutableArray array];
    WEAKSELF
    switch (self.model.operateType) {
        case ENUM_ORDER_OPERATE_WAIT_RECEIVE:
        {
            [aryBtns addObject:^(){
                ModelBtn * modelBtn = [ModelBtn new];
                modelBtn.title = @"接单";
                modelBtn.color = COLOR_BLUE;
                modelBtn.blockClick = ^{
                    if (weakSelf.blockAcceptClick) {
                        weakSelf.blockAcceptClick(weakSelf.model);
                    }
                };
                return modelBtn;
            }()];
            [aryBtns addObject:^(){
                ModelBtn * modelBtn = [ModelBtn new];
                modelBtn.title = @"拒单";
                modelBtn.color = COLOR_666;
                modelBtn.blockClick = ^{
                    if (weakSelf.blockRejectClick) {
                        weakSelf.blockRejectClick(weakSelf.model);
                    }
                };
                return modelBtn;
            }()];
        }
            break;
        case ENUM_ORDER_OPERATE_WAIT_TRANSPORT:
        {
            if (model.isDispatch) {
                [aryBtns addObject:^(){
                    ModelBtn * modelBtn = [ModelBtn new];
                    modelBtn.title = @"派车";
                    modelBtn.color = COLOR_BLUE;
                    modelBtn.blockClick = ^{
                        if (weakSelf.blockDispatchClick) {
                            weakSelf.blockDispatchClick(weakSelf.model);
                        }
                    };
                    return modelBtn;
                }()];
            }
            if (model.totalAccept == 0) {
                [aryBtns addObject:^(){
                    ModelBtn * modelBtn = [ModelBtn new];
                    modelBtn.title = @"退单";
                    modelBtn.color = COLOR_666;
                    modelBtn.blockClick = ^{
                        if (weakSelf.blockReturnClick) {
                            weakSelf.blockReturnClick(weakSelf.model);
                        }
                    };
                    return modelBtn;
                }()];
            }
           
        }
            break;
        default:
            break;
    }
    
    if (isAry(aryBtns)) {
        bottom =  [self.viewBG addLineFrame:CGRectMake(W(15), self.labelPriceAll.bottom + W(15), self.viewBG.width - W(30), 1)];
    }
    
    CGFloat right = self.viewBG.width - W(15);
    CGFloat viewBGHeight = self.labelPriceAll.bottom + W(15) ;
    for (ModelBtn * item in aryBtns) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:F(13)];
        [btn setTitle:item.title forState:(UIControlStateNormal)];
        [btn setTitleColor:item.color forState:UIControlStateNormal];
        btn.widthHeight = XY(W(80),W(30));
        btn.tag = TAG_LINE;
        btn.modelBtn = item;
        [GlobalMethod setRoundView:btn color:item.color numRound:btn.height/2.0 width:1];
        [self.viewBG addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.rightTop = XY(right, bottom + W(15));
        right = btn.left - W(15);
        
        viewBGHeight = btn.bottom +W(15);
    }
    self.viewBG.height = viewBGHeight;
    
    
    CGFloat interval = 4;
    if (isIphone5) {
        interval = W(3);
    }else if(isIphone6){
        interval = 4;
    }else if(isIphone6p){
        interval = 5;
    }
    self.ivBg.frame = CGRectMake(0, self.viewBG.top-W(10), SCREEN_WIDTH, self.viewBG.height+W(20));
    //设置总高度
    self.height = self.viewBG.bottom+W(5);
}

#pragma mark click
- (void)btnClick:(UIButton *)btn{
    if (btn.modelBtn.blockClick) {
        btn.modelBtn.blockClick();
    }
    
}

@end



@implementation OrderListDateCell
#pragma mark 懒加载
- (UILabel *)labelDay{
    if (_labelDay == nil) {
        _labelDay = [UILabel new];
        _labelDay.textColor = [UIColor whiteColor];
        _labelDay.font =  [UIFont systemFontOfSize:F(18) weight:UIFontWeightRegular];
        _labelDay.numberOfLines = 1;
        _labelDay.lineSpace = 0;
    }
    return _labelDay;
}
- (UILabel *)labelYear{
    if (_labelYear == nil) {
        _labelYear = [UILabel new];
        _labelYear.textColor = [UIColor whiteColor];
        _labelYear.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        _labelYear.numberOfLines = 1;
        _labelYear.lineSpace = 0;
    }
    return _labelYear;
}
- (UIView *)grayBg{
    if (_grayBg == nil) {
        _grayBg = [UIView new];
        _grayBg.backgroundColor = COLOR_BACKGROUND;
    }
    return _grayBg;
}
- (UIView *)blueBG{
    if (_blueBG == nil) {
        _blueBG = [UIView new];
        _blueBG.backgroundColor = COLOR_BLUE;
    }
    return _blueBG;
}
- (UIView *)lineTop{
    if (!_lineTop) {
        _lineTop = [UIView new];
        _lineTop.backgroundColor = COLOR_LINE;
        _lineTop.widthHeight = XY(SCREEN_WIDTH, 1);
    }
    return _lineTop;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.grayBg];
        [self.contentView addSubview:self.blueBG];
        [self.contentView addSubview:self.lineTop];
        [self.contentView addSubview:self.labelDay];
        [self.contentView addSubview:self.labelYear];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.grayBg.widthHeight = XY(SCREEN_WIDTH, W(10));
    [self.contentView addLineFrame:CGRectMake(0, self.grayBg.bottom, SCREEN_WIDTH, 1)];
    
    [self.labelDay fitTitle:UnPackStr(model.string) variable:0];
    self.labelDay.leftTop = XY(W(36),W(3)+self.grayBg.bottom);
    [self.labelYear fitTitle:UnPackStr(model.subString) variable:0];
    self.labelYear.centerXTop = XY(self.labelDay.centerX,self.labelDay.bottom+W(2));
    
    self.blueBG.widthHeight = XY((self.labelDay.centerX - W(15))*2,self.labelYear.bottom - self.grayBg.bottom+ W(3));
    self.blueBG.leftTop = XY(W(15),self.grayBg.bottom);
    [self reconfigCellColor];
    //设置总高度
    self.height = self.blueBG.bottom;
}
- (void)reconfigCellColor{
    switch (self.model.enumType) {
        case ENUM_ORDER_OPERATE_WAIT_RECEIVE:
            self.blueBG.backgroundColor = COLOR_BLUE;
            break;
        case ENUM_ORDER_OPERATE_COMPLETE:
            self.blueBG.backgroundColor = [UIColor colorWithHexString:@"66C931"];
            
            break;
        default:
            self.blueBG.backgroundColor = [UIColor colorWithHexString:@"E76E8C"];
            
            break;
    }
    
}

@end
