//
//  SelectPackageCell.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/8.
//Copyright © 2019 ping. All rights reserved.
//

#import "SelectPackageCell.h"

@interface SelectPackageCell ()

@end

@implementation SelectPackageCell
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
- (UIImageView *)ivSelect{
    if (!_ivSelect) {
        _ivSelect = [UIImageView new];
        _ivSelect.widthHeight = XY(W(25), W(25));
        _ivSelect.backgroundColor = [UIColor clearColor];
        _ivSelect.image = [UIImage imageNamed:@"choose_default"];
        _ivSelect.highlightedImage = [UIImage imageNamed:@"choose_selected"];
    }
    return _ivSelect;
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


#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.labelPackageType];
        [self.contentView addSubview:self.labelPackageNum];
        [self.contentView addSubview:self.labelPlumbemNum];
        [self.contentView addSubview:self.labelWeight];
        [self.contentView addSubview:self.labelPrice];
        [self.contentView addSubview:self.labelName];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.ivSelect];
    }
    return self;
}

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelPackageInfo *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    self.model = model;
    //刷新view
    [self.labelPackageType fitTitle:[NSString stringWithFormat:@"箱型：%@*1  背箱方式：%@",model.containerTypeShow,model.backTypeShow] variable:SCREEN_WIDTH - W(50)];
    self.labelPackageType.leftTop = XY(W(15),W(20));
    [self.labelPackageNum fitTitle:[NSString stringWithFormat:@"箱号：%@",UnPackStr(model.containerNumber)] variable:SCREEN_WIDTH/2.0-W(25)-W(10)];
    self.labelPackageNum.leftTop = XY(self.labelPackageType.left,self.labelPackageType.bottom+W(15));
    [self.labelPlumbemNum fitTitle:[NSString stringWithFormat:@"铅封号：%@",UnPackStr(model.sealNumber)] variable:SCREEN_WIDTH/2.0-W(25)-W(10)];
    self.labelPlumbemNum.leftCenterY = XY(SCREEN_WIDTH/2.0-W(10),self.labelPackageNum.centerY);
    [self.labelWeight fitTitle:[NSString stringWithFormat:@"单箱货重：%@",UnPackStr(model.weightShow)]  variable:SCREEN_WIDTH/2.0-W(25)];
    self.labelWeight.leftTop = XY(self.labelPackageType.left,self.labelPackageNum.bottom+W(15));
    [self.labelPrice fitTitle:[NSString stringWithFormat:@"单箱运费：￥%.2f",model.price/100.0] variable:SCREEN_WIDTH/2.0-W(25)-W(10)];
    self.labelPrice.leftCenterY = XY(SCREEN_WIDTH/2.0-W(10),self.labelWeight.centerY);
    [self.labelName fitTitle:[NSString stringWithFormat:@"货物名称：%@",model.cargoName] variable:SCREEN_WIDTH - W(50)-W(10)];
    self.labelName.leftTop = XY(self.labelPackageType.left,self.labelWeight.bottom+W(15));
    
    //设置总高度
    self.height = self.labelName.bottom + W(20);
    self.ivSelect.rightCenterY = XY(SCREEN_WIDTH - W(10), self.height/2.0);
    self.ivSelect.highlighted = model.isSelected;
    self.line.frame = CGRectMake(0, self.height - 1, SCREEN_WIDTH , 1);
}
@end



@implementation SelectPackageBottomView
#pragma mark 懒加载
- (UILabel *)labelSelectALl{
    if (_labelSelectALl == nil) {
        _labelSelectALl = [UILabel new];
        _labelSelectALl.textColor = COLOR_333;
        _labelSelectALl.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_labelSelectALl fitTitle:@"全选" variable:0];
    }
    return _labelSelectALl;
}
- (UIImageView *)ivSelect{
    if (!_ivSelect) {
        _ivSelect = [UIImageView new];
        _ivSelect.widthHeight = XY(W(25), W(25));
        _ivSelect.backgroundColor = [UIColor clearColor];
        _ivSelect.image = [UIImage imageNamed:@"choose_default"];
        _ivSelect.highlightedImage = [UIImage imageNamed:@"choose_selected"];
    }
    return _ivSelect;
}
-(UIButton *)btnSend{
    if (_btnSend == nil) {
        _btnSend = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSend addTarget:self action:@selector(btnSendClick) forControlEvents:UIControlEventTouchUpInside];
        _btnSend.backgroundColor = [UIColor whiteColor];
        _btnSend.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnSend setTitle:@"派车" forState:(UIControlStateNormal)];
        [_btnSend setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
        _btnSend.widthHeight = XY( W(125),W(40));
        [GlobalMethod setRoundView:_btnSend color:COLOR_BLUE numRound:_btnSend.height/2.0 width:1];
    }
    return _btnSend;
}
#pragma mark 懒加载
- (UIControl *)conSelectAll{
    if (_conSelectAll == nil) {
        _conSelectAll = [UIControl new];
        [_conSelectAll addTarget:self action:@selector(btnSelectAllClick) forControlEvents:UIControlEventTouchUpInside];
        _conSelectAll.backgroundColor = [UIColor clearColor];
    }
    return _conSelectAll;
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
    [self addSubview:self.labelSelectALl];
    [self addSubview:self.ivSelect];
    [self addSubview:self.btnSend];
    [self addSubview:self.conSelectAll];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //设置总高度
    CGFloat height = W(54);
    //刷新view
    self.ivSelect.leftCenterY = XY(W(10),height/2.0);

    self.labelSelectALl.leftCenterY = XY(self.ivSelect.right + W(10),height/2.0);
    
    self.btnSend.rightCenterY = XY(SCREEN_WIDTH -  W(15),height/2.0);
    
    self.height = height + iphoneXBottomInterval;

    self.conSelectAll.frame = CGRectMake(0, 0, self.labelSelectALl.right+ W(25), height);
    
    [self addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
}
#pragma mark 点击事件
- (void)btnSendClick{
    if (self.blockSend) {
        self.blockSend();
    }
}
- (void)btnSelectAllClick{
    self.ivSelect.highlighted = !self.ivSelect.highlighted;
    if (self.blockSelectAll) {
        self.blockSelectAll(self.ivSelect.highlighted);
    }
}
@end
