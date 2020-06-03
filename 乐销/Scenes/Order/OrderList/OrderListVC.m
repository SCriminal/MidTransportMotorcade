//
//  OrderListVC.m
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import "OrderListVC.h"
//cell
#import "OrderListCell.h"
//request
#import "RequestApi+Order.h"
//detail
#import "OrderDetailVC.h"
//select package vc
#import "SelectPackageVC.h"

@interface OrderListVC ()

@end

@implementation OrderListVC
@synthesize noResultView = _noResultView;
#pragma mark lazy init
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_waybill_default" title:@"暂无运单信息"];
        _noResultView.backgroundColor = [UIColor clearColor];
    }
    return _noResultView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //table
    
    [self.tableView registerClass:[OrderListDateCell class] forCellReuseIdentifier:@"OrderListDateCell"];
    [self.tableView registerClass:[OrderListCell class] forCellReuseIdentifier:@"OrderListCell"];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, W(10), 0);
    self.tableView.backgroundColor = [UIColor clearColor];
    [self addRefreshHeader];
    [self addRefreshFooter];
    //request
    [self requestList];
}


#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListCell"];
    [cell resetCellWithModel: self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockAcceptClick = ^(ModelOrderList *item) {
        ModelBtn * modelDismiss = [ModelBtn   modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
        ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
        modelConfirm.blockClick = ^(void){
            [weakSelf requestAccept:item];
        };
        [BaseAlertView initWithTitle:@"提示" content:@"确认接单?" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:[UIApplication sharedApplication].keyWindow];
    };
    cell.blockRejectClick = ^(ModelOrderList *item) {
        ModelBtn * modelDismiss = [ModelBtn   modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
        ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
        modelConfirm.blockClick = ^(void){
            [weakSelf requestReject:item];
        };
        [BaseAlertView initWithTitle:@"提示" content:@"确认拒单?" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:[UIApplication sharedApplication].keyWindow];

    };
    cell.blockReturnClick = ^(ModelOrderList *item) {
        ModelBtn * modelDismiss = [ModelBtn   modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
        ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
        modelConfirm.blockClick = ^(void){
            [weakSelf requestReturn:item];
        };
        [BaseAlertView initWithTitle:@"提示" content:@"确认退单?" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:[UIApplication sharedApplication].keyWindow];
    };
    cell.blockDispatchClick = ^(ModelOrderList *item) {
        [weakSelf requestDispatch:item];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [OrderListCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailVC * detail = [OrderDetailVC new];
    detail.modelOrder = self.aryDatas[indexPath.row];
    [GB_Nav pushViewController:detail animated:true];
}
#pragma mark request
- (void)requestList{
    NSString * strOrderType = nil;
    int sortCreateTime = 1;
    int sortAcceptTime = 1;
    int sortFinishTime = 1;
    switch (self.sortType) {
        case ENUM_ORDER_LIST_SORT_ALL:
            strOrderType = nil;
            sortCreateTime = 3;
            break;
        case ENUM_ORDER_LIST_SORT_WAIT_RECEIVE:
            strOrderType = @"401";
            sortCreateTime = 3;
            break;
        case ENUM_ORDER_LIST_SORT_WAIT_TRANSPORT:
            strOrderType = @"402";
            sortAcceptTime = 3;
            break;
        case ENUM_ORDER_LIST_SORT_COMPLETE:
            strOrderType = @"410";
            sortFinishTime = 3;
            break;
        default:
            break;
    }
//    @[@"下单时间",@"接单时间",@"完成时间"];
    [RequestApi requestOrderListWithWaybillnumber:nil
                                       categoryId:0
                                            state:strOrderType
                                         blNumber:self.billNo
                                 shippingLineName:nil
                                       oceanVesel:nil
                                     voyageNumber:nil
                                     startContact:nil
                                       startPhone:nil
                                       endContact:nil
                                         endPhone:nil
                                 closingStartTime:0
                                   closingEndTime:0
                                     placeEnvName:0
                                   placeStartTime:0
                                     placeEndTime:0
                                     placeContact:nil
                                  createStartTime:self.dateTypeIndex == 0? [self.dateStart timeIntervalSince1970]:0
                                    createEndTime:self.dateTypeIndex == 0?[self.dateEnd timeIntervalSince1970]:0
                                  acceptStartTime:self.dateTypeIndex == 1? [self.dateStart timeIntervalSince1970]:0
                                    acceptEndTime:self.dateTypeIndex == 1?[self.dateEnd timeIntervalSince1970]:0
                                  finishStartTime:self.dateTypeIndex == 2? [self.dateStart timeIntervalSince1970]:0
                                    finishEndTime:self.dateTypeIndex == 2?[self.dateEnd timeIntervalSince1970]:0
                                             page:self.pageNum
                                            count:50
                                            entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty
                                   sortAcceptTime:sortAcceptTime
                                   sortFinishTime:sortFinishTime
                                   sortCreateTime:sortCreateTime
                                         delegate:self
                                          success:^(NSDictionary * _Nonnull response, id  _Nonnull mark)
        {
            if (![response isKindOfClass:NSDictionary.class]) {
                return ;
            }
            self.pageNum ++;
            NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelOrderList"];
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
- (void)requestAccept:(ModelOrderList *)model{
    [RequestApi requestGoosListWithId:model.iDProperty entID:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * aryItems = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelPackageInfo"];
        NSArray * aryIds = [aryItems fetchValues:@"waybillCargoId"];
       NSString * strCargoId =  [aryIds componentsJoinedByString:@","];
        [RequestApi requestAcceptOrderWithSelectids:strCargoId entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty id:model.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"接单成功"];
            [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_ORDER_REFERSH object:nil];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    } ];
   
}
- (void)requestReject:(ModelOrderList *)model{
    [RequestApi requestRejectOrderWithEntid:[GlobalData sharedInstance].GB_CompanyModel.iDProperty id:model.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        
        [GlobalMethod showAlert:@"拒单成功"];
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_ORDER_REFERSH object:nil];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];

    
}
- (void)requestReturn:(ModelOrderList *)model{
    [RequestApi requestGoosListWithId:model.iDProperty entID:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * aryItems = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelPackageInfo"];
        NSArray * aryIds = [aryItems fetchValues:@"waybillCargoId"];
        NSString * strCargoId =  [aryIds componentsJoinedByString:@","];
        [RequestApi requestReturnOrderWithSelectids:strCargoId entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty fees:nil id:model.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"退单成功"];
            [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_ORDER_REFERSH object:nil];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    } ];
}
- (void)requestDispatch:(ModelOrderList *)model{
    SelectPackageVC * selectVC = [SelectPackageVC new];
    selectVC.model = model;
    WEAKSELF
    selectVC.blockBack = ^(UIViewController *vc) {
        [weakSelf refreshHeaderAll];
    };
    [GB_Nav pushViewController:selectVC animated:true];
}
@end
