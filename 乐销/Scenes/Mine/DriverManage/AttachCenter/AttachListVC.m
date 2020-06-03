//
//  AttachListVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/12/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "AttachListVC.h"
//cell
#import "AttachListCell.h"
//request
#import "RequestApi+Company.h"
//cancel view
#import "CancelAttachView.h"
//detailvc
#import "AttachDetailVC.h"

@interface AttachListVC ()

@end

@implementation AttachListVC
@synthesize noResultView = _noResultView;
#pragma mark lazy init
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_attach" title:@"暂无挂靠信息"];
        _noResultView.backgroundColor = [UIColor clearColor];
    }
    return _noResultView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //table
    [self.tableView registerClass:[AttachListCell class] forCellReuseIdentifier:@"AttachListCell"];
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AttachListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AttachListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockCancel = ^(AttachListCell *listCell) {
        [weakSelf cancelClick:listCell.model];
    };
    cell.blockDetail = ^(AttachListCell *listCell) {
        [weakSelf jumpToDetail:listCell.model];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AttachListCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self jumpToDetail:self.aryDatas[indexPath.row]];
}
- (void)jumpToDetail:(ModelAttachApplyList *)model{
    AttachDetailVC * detailVC = [AttachDetailVC new];
    detailVC.modelAttach = model;
    WEAKSELF
    detailVC.blockBack = ^(UIViewController *vc) {
        if (vc.requestState && weakSelf.blockRefreshAll) {
            weakSelf.blockRefreshAll();
        }
    };
    [GB_Nav pushViewController:detailVC animated:true];

}
#pragma mark request
- (void)requestList{
    if ([self.strState isEqualToString:@"10"]) {
        [RequestApi requestrequestAttachedDriverListWithEntidWithEntid:[GlobalData sharedInstance].GB_CompanyModel.iDProperty page:self.pageNum count:50 driverName:self.strFilterName driverPhone:self.strFilterPhone delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            if (![response isKindOfClass:NSDictionary.class]) {
                return ;
            }
            self.pageNum ++;
            NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelAttachApplyList"];
            for (ModelAttachApplyList* modelTmp in aryRequest) {
                modelTmp.state = 10;
            }
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
    }else{
        [RequestApi requestAttachApplyListWithEntid:[GlobalData sharedInstance].GB_CompanyModel.iDProperty cellPhone:self.strFilterPhone realName:self.strFilterName state:self.strState startTime:[self.dateStart timeIntervalSince1970] endTime:[self.dateEnd timeIntervalSince1970] page:self.pageNum count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            if (![response isKindOfClass:NSDictionary.class]) {
                return ;
            }
            self.pageNum ++;
            NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelAttachApplyList"];
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
   
    
}

- (void)cancelClick:(ModelAttachApplyList *)model{
    WEAKSELF
    CancelAttachView * cancelView = [CancelAttachView new];
    cancelView.blockComplete = ^(NSString *reason) {
        [weakSelf requestCancel:model reason:reason];
    };
    [cancelView show];
}
- (void)requestCancel:(ModelAttachApplyList *)model reason:(NSString *)reason{
    [RequestApi requestCancelAttachedDriverWithId:model.iDProperty entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty reason:reason delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self refreshHeaderAll];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
