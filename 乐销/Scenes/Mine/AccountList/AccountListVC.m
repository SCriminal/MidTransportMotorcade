//
//  AccountListVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/16.
//Copyright © 2019 ping. All rights reserved.
//

#import "AccountListVC.h"
//cell
#import "AccountListCell.h"
//filter
#import "AccountFilterView.h"
@interface AccountListVC ()
@property (nonatomic, strong) AccountBottomView *bottomView;
@property (nonatomic, strong) AccountBottomEditView *bottomEditView;

@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) UIView *navRightFilterView;
@property (nonatomic, strong) UIView *navRightCompleteView;
@property (nonatomic, strong) AccountFilterView *filterView;


@end

@implementation AccountListVC

#pragma mark lazy init
- (AccountFilterView *)filterView{
    if (!_filterView) {
        _filterView = [AccountFilterView new];
    }
    return _filterView;
}
- (BaseNavView *)nav{
    if (!_nav) {
        _nav = [BaseNavView initNavBackTitle:@"记账本" rightView:self.navRightFilterView];
    }
    return _nav;
}
- (UIView *)navRightFilterView{
    if (!_navRightFilterView) {
        BaseNavView * nav = [BaseNavView initNavBackWithTitle:@"" rightImageName:@"nav_filter" rightImageSize:CGSizeMake(W(25), W(25)) righBlock:nil];
        _navRightFilterView = nav.rightView;
        [_navRightFilterView addTarget:self action:@selector(filterClick)];
    }
    return _navRightFilterView;
}
- (UIView *)navRightCompleteView{
    if (!_navRightCompleteView) {
        BaseNavView * nav = [BaseNavView initNavBackTitle:@"" rightTitle:@"完成" rightBlock:nil];
        _navRightCompleteView = nav.rightView;
        [_navRightCompleteView addTarget:self action:@selector(completeClick)];
    }
    return _navRightCompleteView;
}
- (AccountBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [AccountBottomView new];
        _bottomView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        _bottomView.blockClick = ^{
            weakSelf.isEditing = !weakSelf.isEditing;
            [weakSelf reconfigView];
        };
    }
    return _bottomView;
}
- (AccountBottomEditView *)bottomEditView{
    if (!_bottomEditView) {
        _bottomEditView = [AccountBottomEditView new];
        _bottomEditView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        _bottomEditView.blockClick = ^{
            weakSelf.isEditing = false;
            [weakSelf reconfigView];
        };
    }
    return _bottomEditView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[AccountListCell class] forCellReuseIdentifier:@"AccountListCell"];
    self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.bottomView.height;
    [self.view addSubview:self.bottomView];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:self.nav];
}
#pragma mark reconfigView
- (void)reconfigView{
    if (self.isEditing) {
        [self.bottomView removeFromSuperview];
        [self.view addSubview:self.bottomEditView];
        [self.nav resetNavRightView:self.navRightCompleteView];
    }else{
        [self.bottomEditView removeFromSuperview];
        [self.view addSubview:self.bottomView];
        [self.nav resetNavRightView:self.navRightFilterView];
    }
    [self.tableView reloadData];
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
    AccountListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AccountListCell"];
    cell.isEditing = self.isEditing;
    [cell resetCellWithModel:nil];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AccountListCell fetchHeight:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isEditing) {
        AccountListCell * cell = (AccountListCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.ivSelected.highlighted = !cell.ivSelected.highlighted;
    }
}
#pragma mark click
- (void)completeClick{
    self.isEditing = false;
    [self reconfigView];
}
- (void)filterClick{
    [self.filterView show];
}
#pragma mark request
- (void)requestList{
    self.aryDatas = @[@"",@"",@""].mutableCopy;
    [self.tableView reloadData];
}
@end
