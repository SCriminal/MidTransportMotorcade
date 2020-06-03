//
//  OtherStatisticView.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/10.
//Copyright © 2019 ping. All rights reserved.
//

#import "OtherStatisticView.h"

@interface OtherStatisticDayView ()

@end

@implementation OtherStatisticDayView
#pragma mark 懒加载

- (UIImageView *)ivBg{
    if (_ivBg == nil) {
        _ivBg = [UIImageView new];
        _ivBg.image = IMAGE_WHITE_BG;
        _ivBg.backgroundColor = [UIColor clearColor];
    }
    return _ivBg;
}

- (UIView *)viewLine{
    if (_viewLine == nil) {
        _viewLine = [UIView new];
        _viewLine.backgroundColor = COLOR_DARK;
    }
    return _viewLine;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_labelTitle fitTitle:@"今日统计" variable:0];
    }
    return _labelTitle;
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
    [self addSubview:self.ivBg];
    [self addSubview:self.viewLine];
    [self addSubview:self.labelTitle];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.labelTitle.leftTop = XY(W(35),W(35));

    self.viewLine.widthHeight = XY(W(3), self.labelTitle.height);
    [GlobalMethod setRoundView:self.viewLine color:[UIColor clearColor] numRound:self.viewLine.width/2.0 width:0];
    self.viewLine.rightCenterY = XY(self.labelTitle.left - W(10),self.labelTitle.centerY);
    
    [self addLineFrame:CGRectMake(W(35), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(70), 1)];

    //设置总高度
    CGFloat bottom = [OtherStatisticDayView addLabelToView:self ary:@[^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"合计运单";
        model.subTitle = @"50";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"待接运单";
        model.subTitle = @"10";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"在运运单";
        model.subTitle = @"18";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"完成运单";
        model.subTitle = @"20";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"在运车辆";
        model.subTitle = @"19";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"空闲车辆";
        model.subTitle = @"8";
        return model;
    }()] top:self.labelTitle.bottom + W(40)];
    self.height = bottom + W(10);
    self.ivBg.widthHeight = XY(SCREEN_WIDTH,self.height);

}


+ (CGFloat)addLabelToView:(UIView *)view ary:(NSArray *)aryModels top:(CGFloat)top{
    CGFloat bottom = 0;
    for (int i = 0; i<aryModels.count; i++) {
        ModelBtn * model = aryModels[i];
        
        UILabel * label = [UILabel new];
        label.textColor = COLOR_333;
        label.fontNum = F(15);
        [label fitTitle:model.title variable:0];
        label.left = (i%2==0)?W(35):W(212);
        label.top = top;
        [view addSubview:label];
        
        UILabel * sublabel = [UILabel new];
        sublabel.textColor = COLOR_333;
        sublabel.font = [UIFont systemFontOfSize:F(26) weight:UIFontWeightBold];
        [sublabel fitTitle:model.subTitle variable:0];
        sublabel.left = (i%2==0)?W(35):W(212);
        sublabel.top = label.bottom + W(20);
        [view addSubview:sublabel];
        bottom = sublabel.bottom + W(20);
        
        if (i%2 != 0) {
            top = sublabel.bottom + W(40);
        }
        if (i%2 != 0 && i!=aryModels.count -1) {
            [view addLineFrame:CGRectMake(W(35), sublabel.bottom + W(20), SCREEN_WIDTH - W(70), 1)];
        }
    }
    return bottom;
}
@end



@implementation OtherStatisticMonthView
#pragma mark 懒加载

- (UIImageView *)ivBg{
    if (_ivBg == nil) {
        _ivBg = [UIImageView new];
        _ivBg.image = IMAGE_WHITE_BG;
        _ivBg.backgroundColor = [UIColor clearColor];
    }
    return _ivBg;
}

- (UIView *)viewLine{
    if (_viewLine == nil) {
        _viewLine = [UIView new];
        _viewLine.backgroundColor = COLOR_DARK;
    }
    return _viewLine;
}
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_labelTitle fitTitle:@"本月统计" variable:0];
    }
    return _labelTitle;
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
    [self addSubview:self.ivBg];
    [self addSubview:self.viewLine];
    [self addSubview:self.labelTitle];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.labelTitle.leftTop = XY(W(35),W(35));
    
    self.viewLine.widthHeight = XY(W(3), self.labelTitle.height);
    [GlobalMethod setRoundView:self.viewLine color:[UIColor clearColor] numRound:self.viewLine.width/2.0 width:0];
    self.viewLine.rightCenterY = XY(self.labelTitle.left - W(10),self.labelTitle.centerY);
    
    [self addLineFrame:CGRectMake(W(35), self.labelTitle.bottom + W(20), SCREEN_WIDTH - W(70), 1)];

    //设置总高度
    CGFloat bottom = [OtherStatisticDayView addLabelToView:self ary:@[^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"合计运单";
        model.subTitle = @"5050";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"在运运单";
        model.subTitle = @"210";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"完成运单";
        model.subTitle = @"568";
        return model;
    }()] top:self.labelTitle.bottom + W(40)];
    self.height = bottom + W(10);
    self.ivBg.widthHeight = XY(SCREEN_WIDTH,self.height);
    
}


@end
