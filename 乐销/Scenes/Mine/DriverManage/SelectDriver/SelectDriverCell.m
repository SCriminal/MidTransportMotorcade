//
//  SelectDriverCell.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/8.
//Copyright © 2019 ping. All rights reserved.
//

#import "SelectDriverCell.h"

@interface SelectDriverCell ()

@end

@implementation SelectDriverCell
#pragma mark 懒加载
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        _labelName.textColor = COLOR_333;
        _labelName.font =  [UIFont systemFontOfSize:F(16) ];
        _labelName.numberOfLines = 1;
        _labelName.lineSpace = 0;
    }
    return _labelName;
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
- (UILabel *)labelIdentity{
    if (_labelIdentity == nil) {
        _labelIdentity = [UILabel new];
        _labelIdentity.textColor = COLOR_666;
        _labelIdentity.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelIdentity.numberOfLines = 1;
        _labelIdentity.lineSpace = 0;
    }
    return _labelIdentity;
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
        [self.contentView addSubview:self.labelName];
        [self.contentView addSubview:self.labelIdentity];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.ivSelect];
    }
    return self;
}

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelDriver *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelName fitTitle:UnPackStr(model.driverName) variable:SCREEN_WIDTH - W(50)];
    self.labelName.leftTop = XY(W(15),W(20));
    
    [self.labelIdentity fitTitle:[NSString stringWithFormat:@"身份证号：%@",UnPackStr(model.idNumberShow)] variable:SCREEN_WIDTH - W(50)-W(10)];
    self.labelIdentity.leftTop = XY(self.labelName.left,self.labelName.bottom+W(13));
    
    //设置总高度
    self.height = self.labelIdentity.bottom + W(20);
    self.ivSelect.rightCenterY = XY(SCREEN_WIDTH - W(10), self.height/2.0);
    self.line.frame = CGRectMake(0, self.height - 1, SCREEN_WIDTH , 1);
}

@end

@implementation SelectDriverTopView
#pragma mark 懒加载
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        _labelName.textColor = COLOR_333;
        _labelName.font =  [UIFont systemFontOfSize:F(16) ];
        _labelName.numberOfLines = 1;
        _labelName.lineSpace = 0;
    }
    return _labelName;
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

- (UIView *)line{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = COLOR_LINE;
    }
    return _line;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.labelName];
        [self addSubview:self.line];
        [self addSubview:self.ivSelect];
        [self resetView];
        [self addTarget:self action:@selector(click)];
    }
    return self;
}


#pragma mark 刷新cell
- (void)resetView{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelName fitTitle:@"解绑司机" variable:SCREEN_WIDTH - W(50)];
    self.labelName.leftTop = XY(W(15),W(20));
    
    //设置总高度
    self.height = self.labelName.bottom + W(20);
    self.ivSelect.rightCenterY = XY(SCREEN_WIDTH - W(10), self.height/2.0);
    self.line.frame = CGRectMake(0, self.height - 1, SCREEN_WIDTH , 1);
}

#pragma mark click
- (void)click{
    if (self.blockClick) {
        self.blockClick();
    }
}
@end

@implementation SelectDriverBottomView

-(UIButton *)btnSend{
    if (_btnSend == nil) {
        _btnSend = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnSend addTarget:self action:@selector(btnSendClick) forControlEvents:UIControlEventTouchUpInside];
        _btnSend.backgroundColor = [UIColor whiteColor];
        _btnSend.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnSend setTitle:@"完成" forState:(UIControlStateNormal)];
        [_btnSend setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
        _btnSend.widthHeight = XY( W(125),W(40));
        [GlobalMethod setRoundView:_btnSend color:COLOR_BLUE numRound:_btnSend.height/2.0 width:1];
    }
    return _btnSend;
}
-(UIButton *)btnAdd{
    if (_btnAdd == nil) {
        _btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAdd addTarget:self action:@selector(btnAddClick) forControlEvents:UIControlEventTouchUpInside];
        _btnAdd.backgroundColor = [UIColor whiteColor];
        _btnAdd.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnAdd setTitle:@"添加司机" forState:(UIControlStateNormal)];
        [_btnAdd setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
        _btnAdd.widthHeight = XY( W(125),W(40));
        [GlobalMethod setRoundView:_btnAdd color:COLOR_BLUE numRound:_btnAdd.height/2.0 width:1];
    }
    return _btnAdd;
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
    [self addSubview:self.btnSend];
    [self addSubview:self.btnAdd];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //设置总高度
    CGFloat height = W(54);
    //刷新view
    self.btnSend.rightCenterY = XY(SCREEN_WIDTH -  W(15),height/2.0);
    self.btnAdd.rightCenterY = XY(self.btnSend.left - W(15),height/2.0);
    
    self.height = height + iphoneXBottomInterval;
    
    [self addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
}
#pragma mark 点击事件
- (void)btnSendClick{
    if (self.blockSend) {
        self.blockSend();
    }
}
- (void)btnAddClick{
    if (self.blockAdd) {
        self.blockAdd();
    }
}
@end
