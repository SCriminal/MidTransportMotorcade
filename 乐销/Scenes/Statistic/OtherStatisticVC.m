//
//  OtherStatisticVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/10.
//Copyright © 2019 ping. All rights reserved.
//

#import "OtherStatisticVC.h"
//nav
#import "BaseNavView+Logical.h"
//view
#import "OtherStatisticView.h"
@interface OtherStatisticVC ()
@property (nonatomic, strong) OtherStatisticDayView *dayView;
@property (nonatomic, strong) OtherStatisticMonthView *monthView;

@end

@implementation OtherStatisticVC

#pragma mark lazy init
- (OtherStatisticDayView *)dayView{
    if (!_dayView) {
        _dayView = [OtherStatisticDayView new];
    }
    return _dayView;
}
- (OtherStatisticMonthView *)monthView{
    if (!_monthView) {
        _monthView = [OtherStatisticMonthView new];
    }
    return _monthView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    self.tableView.tableHeaderView = self.dayView;
    self.tableView.tableFooterView = self.monthView;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self addNav];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:^(){
        BaseNavView * nav = [BaseNavView initNavBackTitle:@"其他统计" rightView:nil];
        [nav configBlackBackStyle];
        return nav;
    }()];
}


#pragma mark request
- (void)requestList{
    
}

#pragma mark statust bar
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
