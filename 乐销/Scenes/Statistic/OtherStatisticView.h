//
//  OtherStatisticView.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/10.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherStatisticDayView : UIView

@property (strong, nonatomic) UIImageView *ivBg;
@property (nonatomic, strong) UIView *viewLine;
@property (strong, nonatomic) UILabel *labelTitle;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
+ (CGFloat)addLabelToView:(UIView *)view ary:(NSArray *)aryModels top:(CGFloat)top;
@end

@interface OtherStatisticMonthView : UIView

@property (strong, nonatomic) UIImageView *ivBg;
@property (nonatomic, strong) UIView *viewLine;
@property (strong, nonatomic) UILabel *labelTitle;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
