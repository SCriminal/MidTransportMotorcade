//
//  AttachFilterView.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/12/11.
//Copyright © 2019 ping. All rights reserved.
//

#import "AttachFilterView.h"
//date picker
#import "DatePicker.h"
//date
#import "NSDate+YYAdd.h"

@interface AttachFilterView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UIView *viewBlackAlpha;
@property (nonatomic, strong) UITextField *tfPhone;
@property (nonatomic, strong) UITextField *tfName;

@property (nonatomic, strong) UIButton *btnSearch;
@property (nonatomic, strong) UIButton *btnReset;
@property (nonatomic, assign) CGRect borderFrame;
@end

@implementation AttachFilterView

#pragma mark 懒加载
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
    }
    return _viewBG;
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
        _tfName.placeholder = @"输入真实姓名";
    }
    return _tfName;
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
        _tfPhone.placeholder = @"输入手机号";
    }
    return _tfPhone;
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
    [self.viewBG addSubview:self.tfPhone];
    [self.viewBG addSubview:self.btnSearch];
    [self.viewBG addSubview:self.btnReset];
    [self.viewBG addSubview:self.tfName];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.viewBG.widthHeight = XY(SCREEN_WIDTH, W(215));
    self.viewBG.centerXTop = XY(SCREEN_WIDTH/2.0,NAVIGATIONBAR_HEIGHT);
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(20), W(20), W(335), W(45))];
        [self.viewBG addSubview:viewBorder];
        [viewBorder addTarget:self action:@selector(tfPhoneClick)];
        self.tfPhone.widthHeight = XY(viewBorder.width - W(30),viewBorder.height);
        self.tfPhone.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
    }
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(20), W(85), W(335), W(45))];
        self.borderFrame = viewBorder.frame;
        [viewBorder addTarget:self action:@selector(tfNameClick)];
        [self.viewBG addSubview:viewBorder];
        self.tfName.widthHeight = XY(viewBorder.width - W(30),viewBorder.height);
        self.tfName.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
        
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

#pragma mark text delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
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
- (void)btnResetClick{
    self.tfPhone.text = @"";
    self.tfName.text = @"";
    [self btnSearchClick];
    
}
- (void)btnSearchClick{
    if (self.blockSearchClick) { self.blockSearchClick(self.tfPhone.text,self.tfName.text);
    }
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}

@end


@interface ApplyFilterView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UIView *viewBlackAlpha;
@property (nonatomic, strong) UITextField *tfPhone;
@property (nonatomic, strong) UITextField *tfName;

@property (nonatomic, strong) UIButton *btnSearch;
@property (nonatomic, strong) UIButton *btnReset;

@property (nonatomic, strong) UILabel *labelTimeStart;
@property (nonatomic, strong) UILabel *labelTimeEnd;
@property (nonatomic, strong) NSDate *dateStart;
@property (nonatomic, strong) NSDate *dateEnd;
@property (nonatomic, assign) CGRect borderFrame;
@end

@implementation ApplyFilterView

#pragma mark 懒加载
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
    }
    return _viewBG;
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
        _tfName.placeholder = @"输入真实姓名";
    }
    return _tfName;
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
        _tfPhone.placeholder = @"输入手机号";
    }
    return _tfPhone;
}

- (UILabel *)labelTimeStart{
    if (_labelTimeStart == nil) {
        _labelTimeStart = [UILabel new];
        _labelTimeStart.font = [UIFont systemFontOfSize:F(15)];
        _labelTimeStart.textColor = COLOR_999;
        _labelTimeStart.backgroundColor = [UIColor clearColor];
        [_labelTimeStart fitTitle:@"选择开始时间" variable:0];
    }
    return _labelTimeStart;
}
- (UILabel *)labelTimeEnd{
    if (_labelTimeEnd == nil) {
        _labelTimeEnd = [UILabel new];
        _labelTimeEnd.font = [UIFont systemFontOfSize:F(15)];
        _labelTimeEnd.textColor = COLOR_999;
        _labelTimeEnd.backgroundColor = [UIColor clearColor];
        [_labelTimeEnd fitTitle:@"选择结束时间" variable:0];
    }
    return _labelTimeEnd;
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
    [self.viewBG addSubview:self.tfPhone];
    [self.viewBG addSubview:self.btnSearch];
    [self.viewBG addSubview:self.btnReset];
    [self.viewBG addSubview:self.labelTimeStart];
    [self.viewBG addSubview:self.labelTimeEnd];
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
        [viewBorder addTarget:self action:@selector(tfPhoneClick)];
        self.tfPhone.widthHeight = XY(viewBorder.width - W(30),viewBorder.height);
        self.tfPhone.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
    }
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(20), W(85), W(335), W(45))];
        self.borderFrame = viewBorder.frame;
        [self.viewBG addSubview:viewBorder];
        [viewBorder addTarget:self action:@selector(tfNameClick)];
        self.tfName.widthHeight = XY(viewBorder.width - W(30),viewBorder.height);
        self.tfName.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
        
    }
    
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(20), W(150), W(160), W(45))];
        [self.viewBG addSubview:viewBorder];
        [viewBorder addTarget:self action:@selector(startDateClick)];
        self.labelTimeStart.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
        
        UIImageView *ivDown = [UIImageView new];
        ivDown.image = [UIImage imageNamed:@"accountDown"];
        ivDown.widthHeight = XY(W(25),W(25));
        [self.viewBG addSubview:ivDown];
        ivDown.rightCenterY = XY(viewBorder.right - W(10), viewBorder.centerY);
    }
    {
        UIView * viewBorder = [self generateBorder:CGRectMake(W(195), W(150), W(160), W(45))];
        [self.viewBG addSubview:viewBorder];
        [viewBorder addTarget:self action:@selector(endDateClick)];
        self.labelTimeEnd.leftCenterY = XY(viewBorder.left + W(15),viewBorder.centerY);
        
        UIImageView *ivDown = [UIImageView new];
        ivDown.image = [UIImage imageNamed:@"accountDown"];
        ivDown.widthHeight = XY(W(25),W(25));
        [self.viewBG addSubview:ivDown];
        ivDown.rightCenterY = XY(viewBorder.right - W(10), viewBorder.centerY);
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

#pragma mark text delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
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
- (void)startDateClick{
    [GlobalMethod endEditing];
    WEAKSELF
    DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
        weakSelf.dateStart = date;
        [weakSelf.labelTimeStart fitTitle:[GlobalMethod exchangeDate:date formatter:TIME_DAY_SHOW] variable:0];
    } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
    [GB_Nav.lastVC.view addSubview:datePickerView];
}
- (void)endDateClick{
    [GlobalMethod endEditing];
    WEAKSELF
    DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
        date = [date dateByAddingSeconds:86399];
        weakSelf.dateEnd = date;
        
        [weakSelf.labelTimeEnd fitTitle:[GlobalMethod exchangeDate:date formatter:TIME_DAY_SHOW] variable:0];
    } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
    [GB_Nav.lastVC.view addSubview:datePickerView];
}

- (void)btnResetClick{
    self.tfPhone.text = @"";
    self.tfName.text = @"";
    self.dateStart = nil;
    self.dateEnd = nil;
    
    [self.labelTimeStart fitTitle:@"选择开始时间" variable:0];
    [self.labelTimeEnd fitTitle:@"选择结束时间" variable:0];
    [self btnSearchClick];
    
}
- (void)btnSearchClick{
    if (self.blockSearchClick) {
        self.blockSearchClick(self.tfPhone.text,self.tfName.text,self.dateStart,self.dateEnd);
    }
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}

@end
