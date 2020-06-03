//
//  StatisticView.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/13.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StatisticTopView;
@interface StatisticView : UIView
@property (strong, nonatomic) UIImageView *ivBg;
@property (nonatomic, strong) StatisticTopView *topDateView;
@property (nonatomic, strong) ModelStatistic *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelStatistic *)model;

@end



@interface StatisticTopView : UIView
//属性
@property (strong, nonatomic) UILabel *labelDateFrom;
@property (strong, nonatomic) UILabel *labelDateTo;
@property (strong, nonatomic) UIImageView *ivArrowDownFrom;
@property (strong, nonatomic) UIImageView *ivArrowDownTo;
@property (nonatomic, strong) void (^blockStartDateChange)(NSDate *);
@property (nonatomic, strong) void (^blockEndDateChange)(NSDate *);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end



@interface StatisticNavDateView : UIView
//属性
@property (strong, nonatomic) UIImageView *ivArrowDown;
@property (strong, nonatomic) UILabel *date;
@property (nonatomic, strong) void (^blockClick)();

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end



@interface StatisticFilterView : UIView<UIGestureRecognizerDelegate>
//属性
@property (strong, nonatomic) UIImageView *ivAll;

@property (nonatomic, strong) void (^blockClick)(int);

@end
