//
//  DriverDetailView.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/12/3.
//Copyright © 2019 ping. All rights reserved.
//

#import "DriverDetailView.h"
//image detail
#import "ImageDetailBigView.h"

@implementation DriverDetailView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelDriver *)modelDriver{
    [self removeAllSubViews];//移除线
    //重置视图坐标
    NSMutableArray * aryBtns = @[^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"身份证号";
        model.subTitle = modelDriver.idNumber;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"当前状态";
        model.subTitle = modelDriver.authStatusShow;
        model.color = modelDriver.authStatusColorShow;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"联系方式";
        model.subTitle = modelDriver.driverPhone;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"从业资格证号";
        model.subTitle = modelDriver.roadTransportNumber;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"驾驶证-发证机关";
        model.subTitle = modelDriver.driverAgency;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"准驾车型";
        NSArray * aryType = @[@"A1",@"A2",@"A3",@"B1",@"B2",@"C1",@"C2",@"C3",@"C4",@"D",@"E",@"F",@"M",@"N",@"P"];
        int index = (int)modelDriver.driverClass;
        if (index<aryType.count) {
            model.subTitle = aryType[index];
        }
        return model;
    }(),].mutableCopy;
    if (modelDriver.isAuthorityReject) {
        [aryBtns insertObject:^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"失败原因";
            model.subTitle = modelDriver.qualificationDescription;
            model.color = COLOR_RED;
            return model;
        }() atIndex:2];
    }
    CGFloat bottom =  [DriverDetailView addDetailSubView:aryBtns inView:self title:modelDriver.driverName];
    //设置总高度
    self.height = [self addLineFrame:CGRectMake(W(15), bottom, SCREEN_WIDTH - W(30), 1)];
}
+ (CGFloat)addDetailSubView:(NSArray *)aryBtns inView:(UIView *)viewSuper title:(NSString *)title{
    UILabel * labelTitle = [UILabel new];
    labelTitle.font = [UIFont systemFontOfSize:F(16) weight:UIFontWeightMedium];
    labelTitle.textColor = COLOR_333;
    labelTitle.numberOfLines = 1;
    [labelTitle fitTitle:UnPackStr(title) variable:SCREEN_WIDTH - W(30)];
    labelTitle.leftTop = XY(W(15), W(25));
    [viewSuper addSubview:labelTitle];
    CGFloat bottom = labelTitle.bottom + W(25);
    
    for (ModelBtn * model in aryBtns) {
        UILabel * labelTitle = [UILabel new];
        labelTitle.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        labelTitle.textColor = COLOR_666;
        labelTitle.numberOfLines = 1;
        [labelTitle fitTitle:UnPackStr(model.title) variable:SCREEN_WIDTH/2.0 - W(60)];
        labelTitle.leftTop = XY(W(15), bottom);
        [viewSuper addSubview:labelTitle];
        
        UILabel * labelSubTitle = [UILabel new];
        labelSubTitle.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        labelSubTitle.textColor = model.color?model.color:COLOR_666;
        labelSubTitle.numberOfLines = 1;
        [labelSubTitle fitTitle:isStr(model.subTitle)?model.subTitle:@"暂无" variable:SCREEN_WIDTH/2.0 + W(25)];
        labelSubTitle.rightCenterY = XY(SCREEN_WIDTH - W(15), labelTitle.centerY);
        [viewSuper addSubview:labelSubTitle];
        
        bottom = labelTitle.bottom + W(20);
    }
    return bottom+ W(5);
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


