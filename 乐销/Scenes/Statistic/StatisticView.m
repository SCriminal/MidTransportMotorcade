//
//  StatisticView.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/13.
//Copyright © 2019 ping. All rights reserved.
//

#import "StatisticView.h"
#import "OtherStatisticView.h"
#import "DatePicker.h"
//date
#import "NSDate+YYAdd.h"
@interface StatisticView ()

@end

@implementation StatisticView

#pragma mark 懒加载
- (StatisticTopView *)topDateView{
    if (!_topDateView) {
        _topDateView = [StatisticTopView new];
    }
    return _topDateView;
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
        [self resetViewWithModel:nil];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivBg];
    [self addSubview:self.topDateView];
    
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelStatistic *)modelStastic{
    [self removeAllSubViews];//移除线
    [self addSubView];
    self.model = modelStastic;
    //刷新view
    
    //设置总高度
    CGFloat bottom = [OtherStatisticDayView addLabelToView:self ary:@[^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"总利润 (元)";
        model.subTitle = [NSString stringWithFormat:@"%.2f",(modelStastic.receivableFee- modelStastic.payableFee)/100.0];
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"";
        model.subTitle = @"";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"应收 (元)";
        model.subTitle = [NSString stringWithFormat:@"%.2f",modelStastic.receivableFee/100.0];
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"应付 (元)";
        model.subTitle = [NSString stringWithFormat:@"%.2f",modelStastic.payableFee/100.0];
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"实际应收 (元)";
        model.subTitle = @"0.00";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"实际应付 (元)";
        model.subTitle = @"0.00";
        return model;
    }()] top:self.topDateView.bottom + W(20)];
    self.height = bottom + W(10);
    self.ivBg.widthHeight = XY(SCREEN_WIDTH,self.height);
    
}


@end



@implementation StatisticTopView
#pragma mark 懒加载
- (UILabel *)labelDateFrom{
    if (_labelDateFrom == nil) {
        _labelDateFrom = [UILabel new];
        _labelDateFrom.textColor = COLOR_333;
        _labelDateFrom.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelDateFrom.numberOfLines = 0;
        _labelDateFrom.lineSpace = 0;
    }
    return _labelDateFrom;
}
- (UILabel *)labelDateTo{
    if (_labelDateTo == nil) {
        _labelDateTo = [UILabel new];
        _labelDateTo.textColor = COLOR_333;
        _labelDateTo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelDateTo.numberOfLines = 0;
        _labelDateTo.lineSpace = 0;
    }
    return _labelDateTo;
}
#pragma mark 懒加载
- (UIImageView *)ivArrowDownFrom{
    if (_ivArrowDownFrom == nil) {
        _ivArrowDownFrom = [UIImageView new];
        _ivArrowDownFrom.image = [UIImage imageNamed:@"arrow_down"];
        _ivArrowDownFrom.widthHeight = XY(W(25),W(25));
    }
    return _ivArrowDownFrom;
}
- (UIImageView *)ivArrowDownTo{
    if (_ivArrowDownTo == nil) {
        _ivArrowDownTo = [UIImageView new];
        _ivArrowDownTo.image = [UIImage imageNamed:@"arrow_down"];
        _ivArrowDownTo.widthHeight = XY(W(25),W(25));
    }
    return _ivArrowDownTo;
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.labelDateFrom];
    [self addSubview:self.labelDateTo];
    [self addSubview:self.ivArrowDownFrom];
    [self addSubview:self.ivArrowDownTo];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view


    [self.labelDateFrom fitTitle:[GlobalMethod exchangeDate:^(){
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSDateComponents *comps = nil;
        
        comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
        
        NSDateComponents *adcomps = [[NSDateComponents alloc] init];
        
        [adcomps setYear:0];
        
        [adcomps setMonth:-1];
        
        [adcomps setDay:0];
        
        return [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    }() formatter:TIME_DAY_SHOW] variable:0];
    self.labelDateFrom.leftTop = XY(W(37),W(40));
    
    [self.labelDateTo fitTitle:[GlobalMethod exchangeDate:[NSDate date] formatter:TIME_DAY_SHOW] variable:0];
    self.labelDateTo.leftCenterY = XY(W(220),self.labelDateFrom.centerY);
    
    self.ivArrowDownFrom.leftCenterY = XY(self.labelDateFrom.right + W(6),self.labelDateFrom.centerY);
    self.ivArrowDownTo.leftCenterY = XY(self.labelDateTo.right + W(6),self.labelDateFrom.centerY);

    {
        UIView * viewLine = [UIView new];
        viewLine.frame = CGRectMake(self.labelDateFrom.left - W(12), self.labelDateFrom.top - W(12),self.ivArrowDownFrom.right + W(10) - self.labelDateFrom.left + W(12), self.labelDateFrom.height + W(24));
        viewLine.backgroundColor = [UIColor clearColor];
        [GlobalMethod setRoundView:viewLine color:COLOR_LINE numRound:5 width:1];
        [viewLine addTarget:self action:@selector(dateFromClick)];
        [self addSubview:viewLine];
    }
    {
        UIView * viewLine = [UIView new];
        viewLine.frame = CGRectMake(self.labelDateTo.left - W(12), self.labelDateTo.top - W(12),self.ivArrowDownTo.right + W(10) - self.labelDateTo.left + W(12), self.labelDateTo.height + W(24));
        viewLine.backgroundColor = [UIColor clearColor];
        [GlobalMethod setRoundView:viewLine color:COLOR_LINE numRound:5 width:1];
        [viewLine addTarget:self action:@selector(dateToClick)];
        
        [self addSubview:viewLine];
    }
    {
        UIView * viewLine = [UIView new];
        viewLine.widthHeight = XY(W(20), 1);
        viewLine.backgroundColor = COLOR_LINE;
        viewLine.centerXCenterY = XY(SCREEN_WIDTH/2.0, self.labelDateFrom.centerY);
        [self addSubview:viewLine];
    }
    //设置总高度
    self.height = self.labelDateFrom.bottom + W(32);
    [self addLineFrame:CGRectMake(W(25), self.height -1, SCREEN_WIDTH - W(25)*2, 1)];
    
}

#pragma mark click
- (void)dateFromClick{
    [GlobalMethod endEditing];
    WEAKSELF
    DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
        if (weakSelf.blockStartDateChange) {
            weakSelf.blockStartDateChange(date);
        }
        [weakSelf.labelDateFrom fitTitle:[GlobalMethod exchangeDate:date formatter:TIME_DAY_SHOW] variable:0];
        
    } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
    [GB_Nav.lastVC.view addSubview:datePickerView];
}
- (void)dateToClick{
    [GlobalMethod endEditing];
    WEAKSELF
    DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
        date = [date dateByAddingSeconds:86399];
        if (weakSelf.blockEndDateChange) {
            weakSelf.blockEndDateChange(date);
        }
        [weakSelf.labelDateTo fitTitle:[GlobalMethod exchangeDate:date formatter:TIME_DAY_SHOW] variable:0];
        
    } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
    [GB_Nav.lastVC.view addSubview:datePickerView];
}
@end


@implementation StatisticNavDateView
#pragma mark 懒加载
- (UIImageView *)ivArrowDown{
    if (_ivArrowDown == nil) {
        _ivArrowDown = [UIImageView new];
        _ivArrowDown.image = [UIImage imageNamed:@"arrow_down_white"];
        _ivArrowDown.widthHeight = XY(W(25),W(25));
        _ivArrowDown.backgroundColor = [UIColor clearColor];
    }
    return _ivArrowDown;
}
- (UILabel *)date{
    if (_date == nil) {
        _date = [UILabel new];
        _date.textColor = [UIColor whiteColor];
        _date.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_date fitTitle:@"接单时间" variable:0];
    }
    return _date;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
        [self addTarget:self action:@selector(click)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivArrowDown];
    [self addSubview:self.date];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.height = NAVIGATIONBAR_HEIGHT - STATUSBAR_HEIGHT;
    //刷新view
    self.date.leftCenterY = XY(W(15),self.height/2.0);

    self.ivArrowDown.leftCenterY = XY(self.date.right+ W(3),self.date.centerY);
    self.width = self.ivArrowDown.right + W(20);
}

- (void)click{
    if (self.blockClick) {
        self.blockClick();
    }
}
@end



@implementation StatisticFilterView
#pragma mark 懒加载
- (UIImageView *)ivAll{
    if (_ivAll == nil) {
        _ivAll = [UIImageView new];
        _ivAll.image = [UIImage imageNamed:@"Statistic_Filter"];
        _ivAll.widthHeight = XY(W(142),W(170));
        _ivAll.leftTop = XY(W(10), NAVIGATIONBAR_HEIGHT + W(5));
        _ivAll.userInteractionEnabled = true;
    }
    return _ivAll;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubView];
        self.backgroundColor = [UIColor clearColor];
        [self addTarget:self action:@selector(bgClick)];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.ivAll];
    [self resetWithModel:nil];
}

#pragma mark 刷新view
- (void)resetWithModel:(id)model{
    //刷新view
    self.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [self.ivAll addSubview:^(){
        UIButton * con = [UIButton buttonWithType:UIButtonTypeCustom];
        con.backgroundColor = [UIColor clearColor];
        con.tag = 0;
        con.frame = CGRectMake(0, 0, self.ivAll.width, W(60));
        [con addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        return con;
    }()];
    [self.ivAll addSubview:^(){
        UIButton * con = [UIButton buttonWithType:UIButtonTypeCustom];
        con.backgroundColor = [UIColor clearColor];
        con.tag = 1;
        con.frame = CGRectMake(0, W(60), self.ivAll.width, W(54));
        [con addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        return con;
    }()];
    [self.ivAll addSubview:^(){
        UIButton * con = [UIButton buttonWithType:UIButtonTypeCustom];
        con.backgroundColor = [UIColor clearColor];
        con.tag = 2;
        con.frame = CGRectMake(0, W(114), self.ivAll.width, W(54));
        [con addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        return con;
    }()];
}


#pragma mark 点击事件
- (void)btnClick:(UIControl *)sender{
    if (self.blockClick) {
        self.blockClick(sender.tag);
    }
    [self removeFromSuperview];
}
- (void)bgClick{
    [self removeFromSuperview];
}

@end
