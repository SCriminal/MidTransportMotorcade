//
//  OrderListManagementVC.m
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import "OrderListManagementVC.h"
//滑动view
#import "SliderView.h"
//list vc
#import "OrderListVC.h"
//deck view
#import "UIViewController+IIViewDeckAdditions.h"
#import "IIViewDeckController.h"
//filter view
#import "OrderFilterView.h"

@interface OrderListManagementVC ()<SliderViewDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) SliderView *sliderView;
@property (nonatomic, strong) UIScrollView *scAll;
@property (nonatomic, assign) BOOL isNotFirstLoad;
@property (nonatomic, strong) NSArray *arySliderDatas;
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) OrderFilterView *filterView;

@end

@implementation OrderListManagementVC
#pragma mark lazy init
- (UIScrollView *)scAll{
    if (_scAll == nil) {
        _scAll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.sliderView.bottom +1, SCREEN_WIDTH, SCREEN_HEIGHT - self.sliderView.height-NAVIGATIONBAR_HEIGHT - TABBAR_HEIGHT)];
        _scAll.contentSize = CGSizeMake(SCREEN_WIDTH * self.arySliderDatas.count, 0);
        _scAll.backgroundColor = [UIColor clearColor];
        _scAll.delegate = self;
        _scAll.pagingEnabled = true;
        _scAll.showsVerticalScrollIndicator = false;
        _scAll.showsHorizontalScrollIndicator = false;
    }
    return _scAll;
}
- (OrderFilterView *)filterView{
    if (!_filterView) {
        _filterView = [OrderFilterView new];
        WEAKSELF
        _filterView.blockSearchClick = ^(NSInteger index, NSString *billNo, NSDate *dateStart, NSDate *dateEnd) {
            for (OrderListVC * vc in weakSelf.childViewControllers) {
                if ([vc isKindOfClass:OrderListVC.class]) {
                    vc.billNo = isStr(billNo)?billNo:nil;
                    vc.dateStart = dateStart;
                    vc.dateEnd = dateEnd;
                    vc.dateTypeIndex = index;
                    [vc refreshHeaderAll];
                }
            }
        };
    }
    return _filterView;
}
- (NSArray *)arySliderDatas{
    if (!_arySliderDatas) {
        _arySliderDatas = @[^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"全部";
            model.num = ENUM_ORDER_LIST_SORT_ALL;
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"待接单";
            model.num = ENUM_ORDER_LIST_SORT_WAIT_RECEIVE;
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"运输中";
            model.num = ENUM_ORDER_LIST_SORT_WAIT_TRANSPORT;
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"已完成";
            model.num = ENUM_ORDER_LIST_SORT_COMPLETE;
            return model;
        }()];
    }
    return _arySliderDatas;
}
- (SliderView *)sliderView{
    if (_sliderView == nil) {
        _sliderView = ^(){
            SliderView * sliderView = [SliderView new];
            sliderView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, W(50));
            sliderView.isHasSlider = true;
            sliderView.isScroll = false;
            sliderView.isLineVerticalHide = true;
            sliderView.viewSlidColor = [UIColor whiteColor];
            sliderView.viewSlidWidth = W(45);
            sliderView.delegate = self;
            sliderView.line.hidden = true;
            sliderView.backgroundColor = [UIColor clearColor];
            [sliderView resetWithAry:self.arySliderDatas];
            return sliderView;
        }();
    }
    return _sliderView;
}
- (BaseNavView *)nav{
    if (!_nav) {
        WEAKSELF
        _nav = [BaseNavView initNavTitle:@"运单中心" leftImageName:@"" leftImageSize:CGSizeMake(W(25), W(25)) leftBlock:^{
        } rightImageName:@"nav_filter_white" rightImageSize:CGSizeMake(W(25), W(25)) righBlock:^{
            [weakSelf.filterView show];
        }];
        _nav.backgroundColor = [UIColor clearColor];
        _nav.line.hidden = true;
        _nav.labelTitle.textColor = [UIColor whiteColor];
    }
    return _nav;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self.view addSubview:^(){
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.clipsToBounds = true;
        iv.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.sliderView.bottom);
        iv.image = [UIImage imageNamed:@"nav_Bar"];
        iv.contentMode = UIViewContentModeScaleAspectFill;
        return iv;
    }()];
    [self addNav];
    [self.view addSubview:self.sliderView];
    [self.view addSubview:self.scAll];
    [self setupChildVC];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshAll) name:NOTICE_ORDER_REFERSH object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshAll) name:NOTICE_COMPANY_MODEL_CHANGE object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshAll) name:UIApplicationDidBecomeActiveNotification object:nil];

    [GlobalMethod requestBindDeviceToken];
    [GlobalMethod requestExtendToken];
}
#pragma mark view did appear
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!self.isNotFirstLoad) {
        self.isNotFirstLoad = true;
        return;
    }
    [self refreshAll];
}
#pragma mark 初始化子控制器
- (void)setupChildVC
{
    for (int i = 0; i <self.arySliderDatas.count; i++) {
        ModelBtn * model = self.arySliderDatas[i];
        OrderListVC *sourceVC = [[OrderListVC alloc] init];
        sourceVC.sortType = model.num;
        sourceVC.view.frame = CGRectMake(SCREEN_WIDTH*i, 0, self.scAll.width, self.scAll.height);
        sourceVC.tableView.height = sourceVC.view.height;
        [self addChildViewController:sourceVC];
        [self.scAll addSubview:sourceVC.view];
    }
}
#pragma mark refresh all
- (void)refreshAll{
    for (BaseTableVC * tableVC in self.childViewControllers) {
        if (tableVC && [tableVC isKindOfClass:[BaseTableVC class]]) {
            [tableVC refreshHeaderAll];
        }
    }
}

#pragma mark scrollview delegat
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self fetchCurrentView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [self fetchCurrentView];
    }
}
- (void)fetchCurrentView {
    // 获取已经滚动的比例
    double ratio = self.scAll.contentOffset.x / SCREEN_WIDTH;
    int    page  = (int)(ratio + 0.5);
    // scrollview 到page页时 将toolbar调至对应按钮
    [self.sliderView sliderToIndex:page noticeDelegate:NO];
}
#pragma mark slider delegate
- (void)protocolSliderViewBtnSelect:(NSUInteger)tag btn:(CustomSliderControl *)control{
    [UIView animateWithDuration:0.5 animations:^{
        self.scAll.contentOffset = CGPointMake(SCREEN_WIDTH * tag, 0);
    } completion:^(BOOL finished) {
        
    }];
    
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:self.nav];
}

#pragma mark status bar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
