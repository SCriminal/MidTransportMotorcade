//
//  MsgCenterVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/6/26.
//Copyright © 2019 ping. All rights reserved.
//

#import "MsgCenterVC.h"
#import "MsgCenterCell.h"
#import "BaseNavView+Logical.h"
//request
#import "RequestApi+Dictionary.h"

@interface MsgCenterVC ()

@end

@implementation MsgCenterVC
@synthesize noResultView = _noResultView;
#pragma mark lazy init
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_message" title:@"暂无消息"];
        _noResultView.backgroundColor = [UIColor clearColor];
    }
    return _noResultView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //notice
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshHeaderAll) name:NOTICE_ORDER_REFERSH object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshHeaderAll) name:NOTICE_MSG_REFERSH object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshHeaderAll) name:NOTICE_COMPANY_MODEL_CHANGE object:nil];

    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[MsgCenterCell class] forCellReuseIdentifier:@"MsgCenterCell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(W(10), 0, 0, 0);
    //request
    [self requestList];
    [self addRefreshFooter];
    [self addRefreshHeader];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:^(){
        BaseNavView * nav = [BaseNavView initNavBackTitle:@"消息中心" rightView:nil];
        [nav configBlackBackStyle];
        return nav;
    }()];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MsgCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MsgCenterCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MsgCenterCell fetchHeight:self.aryDatas[indexPath.row]];
}


#pragma mark request
- (void)requestList{
    [RequestApi requestMsgListWithSrc:0 state:0 type:0 content:nil page:self.pageNum count:50 isRead:1 entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelMsg"];
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
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
