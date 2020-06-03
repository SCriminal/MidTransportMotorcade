//
//  SelectCarVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/8.
//Copyright © 2019 ping. All rights reserved.
//

#import "SelectCarVC.h"
//cell
#import "SelectCarCell.h"
#import "BaseNavView+Logical.h"
//request
#import "RequestApi+Company.h"

//add car
#import "AddCarVC.h"
//date select
#import "DatePicker.h"

@interface SelectCarVC ()
@property (nonatomic, strong) SelectCarBottomView *bottomView;
@property (nonatomic, strong) ModelCar *modelCarSelected;

@end

@implementation SelectCarVC
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
        _noResultView.btnAdd.hidden = false;
    }
    return _noResultView;
}
- (SelectCarBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [SelectCarBottomView new];
        _bottomView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        _bottomView.blockSend = ^{
            [weakSelf dispatchClick];
        };
        _bottomView.blockAdd = ^{
            AddCarVC * addVC = [AddCarVC new];
            addVC.blockBack = ^(UIViewController *vc) {
                if (vc.requestState) {
                    [weakSelf refreshHeaderAll];
                }
            };
            [GB_Nav pushViewController:addVC animated:true];
        };
    }
    return _bottomView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[SelectCarCell class] forCellReuseIdentifier:@"SelectCarCell"];
    [self.view addSubview:self.bottomView];
    self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.bottomView.height;
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"选择车辆" rightView:nil];
    [nav configBlackBackStyle];
    [self.view addSubview:nav];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectCarCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCarCell"];
    ModelCar * model = self.aryDatas[indexPath.row];
    [cell resetCellWithModel:model];
    cell.ivSelect.highlighted = model.iDProperty == self.modelCarSelected.iDProperty;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SelectCarCell fetchHeight:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectCarCell * cell = (SelectCarCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.modelCarSelected = cell.model;
    [self.tableView reloadData];
}
#pragma mark click
- (void)dispatchClick{
    if (!self.modelCarSelected.iDProperty) {
        [GlobalMethod showAlert:@"请先选择车辆"];
        return;
    }
    [GlobalMethod endEditing];
    WEAKSELF
    DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
        [weakSelf requestDispatch:date];
    } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR_MIN];
    [datePickerView.datePicker selectDate:self.model.placeTime?[GlobalMethod exchangeTimeStampToDate:self.model.placeTime]:[NSDate date]];
    [datePickerView configTitle:self.model.orderType == ENUM_ORDER_TYPE_INPUT? @"选择卸货时间":@"选择装货时间"];
    [weakSelf.view addSubview:datePickerView];
}

#pragma mark status bar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark request
- (void)requestList{
    [RequestApi requestCarListWithDrivername:nil driverPhone:nil vehicleNumber:nil page:1 count:500 entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty                  qualificationState:0
 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
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
- (void)requestDispatch:(NSDate *)datePlaceTime{
   
    
    NSString * strJson = [GlobalMethod exchangeModelsToJson:self.aryPackages];
    [RequestApi requestDispatchOrderWithWaybillcargos:strJson
                                          transportId:self.model.iDProperty
                                                entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty
                                            carrierId:self.modelCarSelected.driverId
                                              truckId:self.modelCarSelected.iDProperty
                                            placeTime: [datePlaceTime timeIntervalSince1970]
                                             delegate:self
                                              success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"派车成功"];
        [GB_Nav popMultiVC:2];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    } ];
}
@end
