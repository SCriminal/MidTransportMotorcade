//
//  CarFilterView.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/14.
//Copyright © 2019 ping. All rights reserved.
//

#import "CarFilterView.h"

@interface CarFilterView ()<UITextFieldDelegate>

@end

@implementation CarFilterView

#pragma mark 懒加载
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
        [_viewBG addTarget:self action:@selector(viewBgClick)];
    }
    return _viewBG;
}

- (UITextField *)tfBillNo{
    if (_tfBillNo == nil) {
        _tfBillNo = [UITextField new];
        _tfBillNo.font = [UIFont systemFontOfSize:F(15)];
        _tfBillNo.textAlignment = NSTextAlignmentLeft;
        _tfBillNo.textColor = COLOR_333;
        _tfBillNo.borderStyle = UITextBorderStyleNone;
        _tfBillNo.backgroundColor = [UIColor clearColor];
        _tfBillNo.delegate = self;
        _tfBillNo.placeholder = @"输入车牌号码";
    }
    return _tfBillNo;
}
- (UITextField *)tfPhone{
    if (_tfPhone == nil) {
        _tfPhone = [UITextField new];
        _tfPhone.font = [UIFont systemFontOfSize:F(15)];
        _tfPhone.textAlignment = NSTextAlignmentLeft;
        _tfPhone.textColor = COLOR_333;
        _tfPhone.borderStyle = UITextBorderStyleNone;
        _tfPhone.backgroundColor = [UIColor clearColor];
        _tfPhone.delegate = self;
        _tfPhone.placeholder = @"输入司机联系方式";
    }
    return _tfPhone;
}
- (UITextField *)tfName{
    if (_tfName == nil) {
        _tfName = [UITextField new];
        _tfName.font = [UIFont systemFontOfSize:F(15)];
        _tfName.textAlignment = NSTextAlignmentLeft;
        _tfName.textColor = COLOR_333;
        _tfName.borderStyle = UITextBorderStyleNone;
        _tfName.backgroundColor = [UIColor clearColor];
        _tfName.delegate = self;
        _tfName.placeholder = @"输入司机姓名";
    }
    return _tfName;
}
-(UIButton *)btnSearch{
    if (_btnSearch == nil) {
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSearch.backgroundColor = COLOR_DARK;
        _btnSearch.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnSearch setTitle:@"搜索" forState:(UIControlStateNormal)];
        [_btnSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnSearch addTarget:self action:@selector(btnSearchClick) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:_btnSearch color:[UIColor clearColor] numRound:5 width:0];
    }
    return _btnSearch;
}
-(UIButton *)btnReset{
    if (_btnReset == nil) {
        _btnReset = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnReset.backgroundColor = COLOR_DARK;
        _btnReset.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnReset setTitle:@"重置" forState:(UIControlStateNormal)];
        [_btnReset setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnReset addTarget:self action:@selector(btnResetClick) forControlEvents:UIControlEventTouchUpInside];
        [GlobalMethod setRoundView:_btnReset color:[UIColor clearColor] numRound:5 width:0];
    }
    return _btnReset;
}
- (UIView *)viewBlackAlpha{
    if (!_viewBlackAlpha) {
        _viewBlackAlpha = [UIView new];
        _viewBlackAlpha.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
        _viewBlackAlpha.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _viewBlackAlpha;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addSubView];
        [self addTarget:self action:@selector(closeClick)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBlackAlpha];
    [self addSubview:self.viewBG];
    [self.viewBG addSubview:self.tfBillNo];
    [self.viewBG addSubview:self.btnSearch];
    [self.viewBG addSubview:self.btnReset];
    [self.viewBG addSubview:self.tfPhone];
    [self.viewBG addSubview:self.tfName];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.viewBG.widthHeight = XY(SCREEN_WIDTH, W(280));
    self.viewBG.centerXTop = XY(SCREEN_WIDTH/2.0,NAVIGATIONBAR_HEIGHT);
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(20), W(20), W(335), W(45))];
        [self.viewBG addSubview:viewBorder];
        [viewBorder addTarget:self action:@selector(tfBilNoClick)];
        self.tfBillNo.widthHeight = XY(viewBorder.width - W(30),viewBorder.height);
        self.tfBillNo.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
    }
    
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(20), W(85), W(335), W(45))];
        [viewBorder addTarget:self action:@selector(tfNameClick)];
        [self.viewBG addSubview:viewBorder];
        self.tfName.widthHeight = XY(viewBorder.width - W(30),viewBorder.height);
        self.tfName.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
    }
    
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(20), W(150), W(335), W(45))];
        [viewBorder addTarget:self action:@selector(tfPhoneClick)];
        [self.viewBG addSubview:viewBorder];
        self.tfPhone.widthHeight = XY(viewBorder.width - W(30),viewBorder.height);
        self.tfPhone.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
    }
    
    self.btnSearch.widthHeight = XY(W(160),W(45));
    self.btnReset.widthHeight = XY(W(160),W(45));
    self.btnSearch.leftBottom = XY(self.viewBG.width/2.0 + W(7.5),self.viewBG.height- W(20));
    self.btnReset.rightBottom = XY(self.viewBG.width/2.0 - W(7.5),self.viewBG.height- W(20));

}
- (UIView *)generateBorder:(CGRect)frame{
    UIView * viewBorder = [UIView new];
    viewBorder.backgroundColor = [UIColor clearColor];
    [GlobalMethod setRoundView:viewBorder color:COLOR_LINE numRound:5 width:1];
    viewBorder.frame = frame;
    return viewBorder;
}
#pragma mark keyboard
- (void)keyboardShow:(NSNotification *)notice{
    [UIView animateWithDuration:0.3 animations:^{
        self.viewBG.top = MIN(SCREEN_HEIGHT/2.0-W(203)/2.0, W(107));
    }];
}

- (void)keyboardHide:(NSNotification *)notice{
    [UIView animateWithDuration:0.3 animations:^{
        self.viewBG.top = MIN(SCREEN_HEIGHT/2.0-W(203)/2.0, W(167));
    }];
}
#pragma mark text delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}

#pragma mark 销毁
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark click
- (void)closeClick{
    if ([self fetchFirstResponder]) {
        [GlobalMethod endEditing];
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)show{
    self.alpha = 1;
    [GB_Nav.lastVC.view addSubview:self];
}

- (void)tfPhoneClick{
    [self.tfPhone becomeFirstResponder];
}
- (void)tfNameClick{
    [self.tfName becomeFirstResponder];
}
- (void)tfBilNoClick{
    [self.tfBillNo becomeFirstResponder];
}
- (void)btnSearchClick{
    if (self.blockSearchClick) {
        self.blockSearchClick(self.tfBillNo.text,self.tfName.text,self.tfPhone.text);
    }
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}
- (void)btnResetClick{
    self.tfBillNo.text = @"";
    self.tfName.text = @"";
    self.tfPhone.text = @"";
    [self btnSearchClick];
    
}
- (void)viewBgClick{
    
}
@end
