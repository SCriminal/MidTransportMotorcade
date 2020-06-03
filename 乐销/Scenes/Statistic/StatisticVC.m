//
//  StatisticVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/13.
//Copyright © 2019 ping. All rights reserved.
//

#import "StatisticVC.h"
//nav
#import "BaseNavView+Logical.h"
//view
#import "StatisticView.h"
//cahrt view
#import "ORChartView.h"
//request
#import "RequestApi+Order.h"
//list view
#import "ListAlertView.h"

@interface StatisticVC ()
@property (nonatomic, strong) StatisticView *topView;
@property (nonatomic, strong) StatisticNavDateView *navDateView;
@property (nonatomic, strong) ORChartView *chartView;
@property (nonatomic, strong) UIImageView *ivBg;
@property (nonatomic, strong) StatisticFilterView *filterView;
@property (nonatomic, assign) int filterIndex;
@property (nonatomic, strong) ModelStatistic *model;
@property (nonatomic, strong) NSDate *dateStart;
@property (nonatomic, strong) NSDate *dateEnd;

@end

@implementation StatisticVC

#pragma mark lazy init
- (StatisticView *)topView{
    if (!_topView) {
        _topView = [StatisticView new];
        WEAKSELF
        _topView.topDateView.blockStartDateChange = ^(NSDate *date) {
            weakSelf.dateStart = date;
            [weakSelf requestList];
        };
        _topView.topDateView.blockEndDateChange  = ^(NSDate *date) {
            weakSelf.dateEnd = date;
            [weakSelf requestList];
        };
    }
    return _topView;
}
- (StatisticFilterView *)filterView{
    if (!_filterView) {
        _filterView = [StatisticFilterView new];
        WEAKSELF
        _filterView.blockClick = ^(int index) {
            switch (index) {
                case 0:
                    weakSelf.navDateView.date.text = @"接单时间";
                    break;
                case 1:
                    weakSelf.navDateView.date.text = @"下单时间";
                    break;
                case 2:
                    weakSelf.navDateView.date.text = @"装卸时间";
                    break;
                default:
                    break;
            }
            weakSelf.filterIndex = index;
            [weakSelf requestList];
        };
    }
    return _filterView;
}
- (StatisticNavDateView *)navDateView{
    if (!_navDateView) {
        _navDateView = [StatisticNavDateView new];
        WEAKSELF
        _navDateView.blockClick = ^{
            [GlobalMethod endEditing];
            [weakSelf.view addSubview:weakSelf.filterView];
        };
    }
    return _navDateView;
}
- (UIImageView *)ivBg{
    if (_ivBg == nil) {
        _ivBg = [UIImageView new];
        _ivBg.image = IMAGE_WHITE_BG;
        _ivBg.backgroundColor = [UIColor clearColor];
    }
    return _ivBg;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateStart = ^(){
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = nil;
        comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
        NSDateComponents *adcomps = [[NSDateComponents alloc] init];
        [adcomps setYear:0];
        [adcomps setMonth:-1];
        [adcomps setDay:0];
        return [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    }();
    self.dateEnd = [NSDate date];
    //添加导航栏
    self.tableView.tableHeaderView = self.topView;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - TABBAR_HEIGHT;
    [self addNav];
//    [self resetChartView];
    //request
    [self requestList];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self requestList];
}
#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"统计分析" rightTitle:@"" rightBlock:^{
    }];

    [nav configBlackBackStyle];
    [self.view addSubview:nav];
    [nav resetNavLeftView:self.navDateView];
    
    
}

- (void)resetChartView{
    NSMutableArray * aryPrice = [NSMutableArray array];
    NSMutableArray * aryDate  = [NSMutableArray array];
    /*
    for (ModelAttentionPathRoute * modelRoute in self.modelDetail.line) {
        NSString *strPrice = self.sliderView.selectSliderIndex == 0?modelRoute.smallOnePrice:self.sliderView.selectSliderIndex == 1?modelRoute.bigOnePrice:modelRoute.doubleOnePrice;
        [aryPrice addObject:strPrice];
        NSString * strDate =  [GlobalMethod timestampSwitchTime:modelRoute.effectiveStartAt.doubleValue andFormatter:@"MM-dd"];
        [aryDate addObject:strDate];
    }
     */
    aryPrice = @[@"100",@"150",@"120",@"100"].mutableCopy;
    aryDate = @[@"05-01",@"05-02",@"05-03",@"05-04"].mutableCopy;
    [self.chartView removeFromSuperview];
    self.chartView = [[ORChartView alloc]initWithFrame:CGRectMake(W(20),W(20), [UIScreen mainScreen].bounds.size.width - W(40), 280) dataSource:aryPrice countFoyY:7 ];
    self.chartView.backgroundColor = [UIColor clearColor];
    self.chartView.titleForX = @"日期";
    self.chartView.titleForY = @"价格趋势";
    self.chartView.style = ChatViewStyleSingleBroken;
    self.chartView.dataArrOfX = aryDate;
    [self.chartView pointDidTapedCompletion:^(NSString *value, NSInteger index) {
        NSLog(@"....%@....%ld", value, (long)index);
    }];
    [self.chartView resetUIAndData];
    self.ivBg.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.chartView.height + self.chartView.top * 2);
    [self.ivBg addSubview:self.chartView];
    self.tableView.tableFooterView = self.ivBg;
}

#pragma mark request
- (void)requestList{
    double acceptstarttime= 0;
    double acceptEndTime= 0;
    double createStartTime= 0;
    double createEndTime= 0;
    double placeStartTime= 0;
    double placeEndTime= 0;
    switch (self.filterIndex) {
        case 0:
            acceptstarttime = [self.dateStart timeIntervalSince1970];
            acceptEndTime = [self.dateEnd timeIntervalSince1970];
            break;
        case 1:
            createStartTime = [self.dateStart timeIntervalSince1970];
            createEndTime = [self.dateEnd timeIntervalSince1970];
            break;
        case 2:
            placeStartTime = [self.dateStart timeIntervalSince1970];
            placeEndTime = [self.dateEnd timeIntervalSince1970];
            break;
        default:
            break;
    }

    [RequestApi requestStatisticWithAcceptstarttime:acceptstarttime acceptEndTime:acceptEndTime createStartTime:createStartTime createEndTime:createEndTime placeStartTime:placeStartTime placeEndTime:placeEndTime entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.model = [ModelStatistic modelObjectWithDictionary:response];
        [self.topView resetViewWithModel:self.model];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

#pragma mark statust bar
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
