//
//  DriverMangementVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/8.
//Copyright © 2019 ping. All rights reserved.
//

#import "DriverMangementVC.h"
//cell
#import "DriverMangementCell.h"
#import "BaseNavView+Logical.h"
//filter view
#import "DriverFilterView.h"
//add driver vc
#import "AddDriverVC.h"
//request
#import "RequestApi+Company.h"
//detail vc
#import "DriverDetailVC.h"

@interface DriverMangementVC ()
@property (nonatomic, strong) DriverFilterView *filterView;
@property (nonatomic, strong) NSString *strFilterName;
@property (nonatomic, strong) NSString *strFilterPhone;
@property (nonatomic, assign) BOOL isNotFirstLoad;
@end

@implementation DriverMangementVC
@synthesize noResultView = _noResultView;
#pragma mark lazy init
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_driver" title:@"暂无司机信息"];
        _noResultView.backgroundColor = [UIColor clearColor];
    }
    return _noResultView;
}
- (DriverFilterView *)filterView{
    if (!_filterView) {
        _filterView = [DriverFilterView new];
        WEAKSELF
        _filterView.blockSearchClick = ^(NSString *strFilterName, NSString *phone) {
            weakSelf.strFilterName = isStr(strFilterName)?strFilterName:nil;
            weakSelf.strFilterPhone = isStr(phone)?phone:nil;
            [weakSelf refreshHeaderAll];
        };
    }
    return _filterView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[DriverMangementCell class] forCellReuseIdentifier:@"DriverMangementCell"];
    self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - TABBAR_HEIGHT;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self addRefreshFooter];
    [self addRefreshHeader];
    //notice
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshHeaderAll) name:NOTICE_COMPANY_MODEL_CHANGE object:nil];

    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    BaseNavView * nav =  [BaseNavView initNavBackTitle:@"司机管理" rightTitle:@"挂靠管理" rightBlock:^{
        [GB_Nav pushVCName:@"AttachListManagementVC" animated:true];
    }];
    [nav resetNavLeftView:^(){
        UIView * viewItem = [UIView new];
        CGFloat viewItemHeight = NAVIGATIONBAR_HEIGHT-STATUSBAR_HEIGHT;
        viewItem.frame = CGRectMake(0, 0, W(90), viewItemHeight);
        viewItem.backgroundColor = [UIColor clearColor];
        
        UIImageView * iconFilter = [UIImageView new];
        iconFilter.image = [UIImage imageNamed:@"nav_filter_white"];
        iconFilter.widthHeight = XY(W(25), W(25));
        iconFilter.leftBottom = XY(W(15), viewItemHeight - W(9.5));
        [viewItem addSubview:iconFilter];
        
        [viewItem addControlFrame:CGRectMake(0, 0, W(50), viewItemHeight) belowView:iconFilter target:weakSelf action:@selector(filterClick)];
        
        UIImageView * icon = [UIImageView new];
        icon.image = [UIImage imageNamed:@"nav_add"];
        icon.widthHeight = XY(W(25), W(25));
        icon.leftBottom = XY(W(60), viewItemHeight - W(9.5));
        [viewItem addSubview:icon];
        
        [viewItem addControlFrame:CGRectMake(W(50), 0, W(50), viewItemHeight) belowView:iconFilter target:weakSelf action:@selector(addClick)];

        return viewItem;
    }()];
    [nav configBlackStyle];
    [self.view addSubview:nav];
}

- (void)filterClick{
    [self.filterView show];

}
- (void)addClick{
    AddDriverVC * addDriver = [AddDriverVC new];
    WEAKSELF
    addDriver.blockBack = ^(UIViewController *vc) {
        if (vc.requestState) {
            [weakSelf refreshHeaderAll];
        }
    };
    [GB_Nav pushViewController:addDriver animated:true];
}
#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DriverMangementCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DriverMangementCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockDelete = ^(DriverMangementCell *cellClick) {
        ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_333];
        ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认删除" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
        modelConfirm.blockClick = ^(void){
            [weakSelf requestDelete:cellClick.model];
        };
        [BaseAlertView initWithTitle:@"提示" content:@"确认删除司机？" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:[UIApplication sharedApplication].keyWindow];
    };
    cell.blockTrick = ^(DriverMangementCell *cellClick) {
        
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DriverMangementCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelDriver * model = self.aryDatas[indexPath.row];
    DriverDetailVC * vc = [DriverDetailVC new];
    vc.model = model;
    [GB_Nav pushViewController:vc animated:true];
}

#pragma mark request
- (void)requestList{
//    [self showNoResult];
//    self.aryDatas = @[@"",@""].mutableCopy;
//    [self.tableView reloadData];
    [RequestApi requestDriverListWithEntid:[GlobalData sharedInstance].GB_CompanyModel.iDProperty page:self.pageNum count:50 name:self.strFilterName  phone:self.strFilterPhone delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        if (![response isKindOfClass:NSDictionary.class]) {
            return ;
        }
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelDriver"];
        if (self.isRemoveAll) {
            [self.aryDatas removeAllObjects];
        }
        if (!isAry(aryRequest)) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.aryDatas addObjectsFromArray:aryRequest];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    } ];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//request
- (void)requestDelete:(ModelDriver *)model{
    [RequestApi requestDeleteDriverWithId:model.driverId entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self refreshHeaderAll];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];

}
@end
