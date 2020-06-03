//
//  ManageCarListVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/8.
//Copyright © 2019 ping. All rights reserved.
//

#import "ManageCarListVC.h"
//cell
#import "ManageCarListCell.h"
#import "BaseNavView+Logical.h"
//filter view
#import "CarFilterView.h"
//add car
#import "AddCarVC.h"
//request
#import "RequestApi+Company.h"
//location
#import "CarLocationVC.h"
//car detail
#import "CarDetailVC.h"
@interface ManageCarListVC ()
@property (nonatomic, strong) CarFilterView *filterView;
@property (nonatomic, strong) NSString *strFilterCarNo;
@property (nonatomic, strong) NSString *strFilterDriverName;
@property (nonatomic, strong) NSString *strFilterDriverPhone;
@property (nonatomic, assign) BOOL isNotFirstLoad;
@end

@implementation ManageCarListVC
@synthesize noResultView = _noResultView;
#pragma mark lazy init
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_car" title:@"暂无车辆信息"];
        _noResultView.backgroundColor = [UIColor clearColor];
    }
    return _noResultView;
}
- (CarFilterView *)filterView{
    if (!_filterView) {
        _filterView = [CarFilterView new];
        WEAKSELF
        _filterView.blockSearchClick = ^(NSString *strCarNo, NSString *strDriverName, NSString *strDriverPhone) {
            weakSelf.strFilterCarNo = isStr(strCarNo)?strCarNo:nil;
            weakSelf.strFilterDriverName = isStr(strDriverName)?strDriverName:nil;
            weakSelf.strFilterDriverPhone = isStr(strDriverPhone)?strDriverPhone:nil;
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
    [self.tableView registerClass:[ManageCarListCell class] forCellReuseIdentifier:@"ManageCarListCell"];
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
    BaseNavView * nav = [BaseNavView initNavTitle:@"车辆管理" leftImageName:@"nav_add" leftImageSize:CGSizeMake(W(25), W(25)) leftBlock:^{
        AddCarVC * addVC = [AddCarVC new];
        addVC.blockBack = ^(UIViewController *vc) {
            if (vc.requestState) {
                [weakSelf refreshHeaderAll];
            }
        };
        [GB_Nav pushViewController:addVC animated:true];
    } rightImageName:@"nav_filter_white" rightImageSize:CGSizeMake(W(25), W(25)) righBlock:^{
        [weakSelf.filterView show];
    }];
    [nav configBlackStyle];
    [self.view addSubview:nav];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ManageCarListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ManageCarListCell"];
    WEAKSELF
    cell.blockDelete = ^(ModelCar *modelCar) {
        ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_333];
        ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认删除" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
        modelConfirm.blockClick = ^(void){
            [weakSelf requestDelete:modelCar];
        };
        [BaseAlertView initWithTitle:@"提示" content:@"确认删除车辆？" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:weakSelf.view];
    };
    cell.blockEdit = ^(ModelCar *modelCar) {
        AddCarVC * addVC = [AddCarVC new];
        addVC.carID = modelCar.iDProperty;
        addVC.blockBack = ^(UIViewController *vc) {
            if (vc.requestState) {
                [weakSelf refreshHeaderAll];
            }
        };
        [GB_Nav pushViewController:addVC animated:true];
    };
    cell.blockTrack = ^(ModelCar *modelCar) {
        CarLocationVC * vc = [CarLocationVC new];
        vc.modelDriver = ^(){
            ModelDriver * item = [ModelDriver new];
            item.iDProperty = modelCar.driverUserId;
            item.truckNumber = modelCar.vehicleNumber;
            item.driverName = modelCar.driverName;
            return item;
        }();
        [GB_Nav pushViewController:vc animated:true];
    };
    cell.blockSubmitAdmit = ^(ModelCar *modelCar) {
        ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
        ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
        modelConfirm.blockClick = ^(void){
            [weakSelf requestSubmitAdmit:modelCar];
        };
        [BaseAlertView initWithTitle:@"提示" content:@"确认提交审核？" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:self.view];
    };
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ManageCarListCell fetchHeight:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CarDetailVC * detailVC = [CarDetailVC new];
    detailVC.model = self.aryDatas[indexPath.row];
    [GB_Nav pushViewController:detailVC animated:true];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestCarListWithDrivername:isStr(self.strFilterDriverName)?self.strFilterDriverName:nil driverPhone:isStr(self.strFilterDriverPhone)?self.strFilterDriverPhone:nil vehicleNumber:isStr(self.strFilterCarNo)?self.strFilterCarNo:nil page:self.pageNum count:50 entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty                  qualificationState:0 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelCar"];
        if (self.isRemoveAll) {
            [self.aryDatas removeAllObjects];
        }
        if (!isAry(aryRequest)) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.aryDatas addObjectsFromArray:aryRequest];
        [self.tableView reloadData];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestDelete:(ModelCar *)model{
    
    [RequestApi requestDeleteCarWithId:model.iDProperty entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self refreshHeaderAll];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestSubmitAdmit:(ModelCar *)model{
    [RequestApi requestResubmitCarWithId:model.iDProperty entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"提交审核成功"];
        [self refreshHeaderAll];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
#pragma mark status bar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
