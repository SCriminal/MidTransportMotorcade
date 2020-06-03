//
//  AttachListManagementVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/12/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "AttachListManagementVC.h"
//滑动view
#import "SliderView.h"
//list vc
#import "AttachListVC.h"
//deck view
#import "UIViewController+IIViewDeckAdditions.h"
#import "IIViewDeckController.h"
//filter view
#import "OrderFilterView.h"
//nav
#import "BaseNavView+Logical.h"
//filter view
#import "AttachFilterView.h"

@interface AttachListManagementVC ()<SliderViewDelegate,UIScrollViewDelegate>
@property (strong, nonatomic) SliderView *sliderView;
@property (nonatomic, strong) UIScrollView *scAll;
@property (nonatomic, strong) NSArray *arySliderDatas;
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) ApplyFilterView *applyFilterView;
@property (nonatomic, strong) AttachFilterView *attachFilterView;

@property (nonatomic, strong) AttachListVC *applyVC;
@property (nonatomic, strong) AttachListVC *attachVC;


@end

@implementation AttachListManagementVC
#pragma mark lazy init
- (UIScrollView *)scAll{
    if (_scAll == nil) {
        _scAll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.sliderView.bottom +1, SCREEN_WIDTH, SCREEN_HEIGHT - self.sliderView.height-NAVIGATIONBAR_HEIGHT)];
        _scAll.contentSize = CGSizeMake(SCREEN_WIDTH * self.arySliderDatas.count, 0);
        _scAll.backgroundColor = [UIColor clearColor];
        _scAll.delegate = self;
        _scAll.pagingEnabled = true;
        _scAll.showsVerticalScrollIndicator = false;
        _scAll.showsHorizontalScrollIndicator = false;
    }
    return _scAll;
}
- (ApplyFilterView *)applyFilterView{
    if (!_applyFilterView) {
        _applyFilterView = [ApplyFilterView new];
        WEAKSELF
        _applyFilterView.blockSearchClick = ^(NSString *phone, NSString *name, NSDate *dateStart, NSDate *dateEnd) {
            weakSelf.applyVC.strFilterPhone = phone;
            weakSelf.applyVC.strFilterName = name;
            weakSelf.applyVC.dateStart = dateStart;
            weakSelf.applyVC.dateEnd = dateEnd;
            [weakSelf.applyVC refreshHeaderAll];
            
        };
    }
    return _applyFilterView;
}
- (AttachFilterView *)attachFilterView{
    if (!_attachFilterView) {
        _attachFilterView = [AttachFilterView new];
        WEAKSELF
        _attachFilterView.blockSearchClick = ^(NSString * phone, NSString *name) {
            weakSelf.attachVC.strFilterPhone = phone;
            weakSelf.attachVC.strFilterName = name;
            [weakSelf.attachVC refreshHeaderAll];
        };
        
    }
    return _attachFilterView;
}
- (NSArray *)arySliderDatas{
    if (!_arySliderDatas) {
        _arySliderDatas = @[^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"申请管理";
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"挂靠管理";
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
        _nav = [BaseNavView initNavBackWithTitle:@"挂靠中心" rightImageName:@"nav_filter_white" rightImageSize:CGSizeMake(W(25), W(25)) righBlock:^{
            NSInteger index = [weakSelf.sliderView selectSliderIndex];
            if (index == 0) {
                [weakSelf.applyFilterView show];
            }else{
                [weakSelf.attachFilterView show];

            }
        }];
        [_nav configBlackBackStyle];
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
    //add refresh
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshAll) name:NOTICE_MSG_REFERSH object:nil];
}
#pragma mark 初始化子控制器
- (void)setupChildVC
{
    WEAKSELF
    for (int i = 0; i <self.arySliderDatas.count; i++) {
        AttachListVC *sourceVC = [[AttachListVC alloc] init];
        if (i == 0) {
            self.applyVC = sourceVC;
            self.applyVC.strState = @"1";
        }else{
            self.attachVC = sourceVC;
            self.attachVC.strState = @"10";
        }
        sourceVC.blockRefreshAll = ^{
            [weakSelf refreshAll];
        };
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

