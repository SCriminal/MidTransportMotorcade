//
//  OrderAccountListVC.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/17.
//Copyright © 2019 ping. All rights reserved.
//

#import "OrderAccountListVC.h"
//cell
#import "OrderAccountListCell.h"
//input view
#import "InputAccountView.h"

@interface OrderAccountListVC ()
@property (nonatomic, strong) OrderAccountBottomView *bottomView;
@property (nonatomic, strong) OrderAccountBottomEditView *bottomEditView;
@property (nonatomic, strong) InputAccountView *inputView;
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) UIView *navRightManageView;
@property (nonatomic, strong) UIView *navRightCompleteView;

@end

@implementation OrderAccountListVC

#pragma mark lazy init

- (BaseNavView *)nav{
    if (!_nav) {
        _nav = [BaseNavView initNavBackTitle:@"运单记账列表" rightView:self.navRightManageView];
    }
    return _nav;
}
- (UIView *)navRightManageView{
    if (!_navRightManageView) {
        BaseNavView * nav = [BaseNavView initNavBackTitle:@"" rightTitle:@"管理" rightBlock:nil];
        _navRightManageView = nav.rightView;
        [_navRightManageView addTarget:self action:@selector(manageClick)];
    }
    return _navRightManageView;
}
- (UIView *)navRightCompleteView{
    if (!_navRightCompleteView) {
        BaseNavView * nav = [BaseNavView initNavBackTitle:@"" rightTitle:@"完成" rightBlock:nil];
        _navRightCompleteView = nav.rightView;
        [_navRightCompleteView addTarget:self action:@selector(completeClick)];
    }
    return _navRightCompleteView;
}
- (InputAccountView *)inputView{
    if (!_inputView) {
        _inputView = [InputAccountView new];
        _inputView.blockDownClick = ^{
            
        };
    }
    return _inputView;
}
- (OrderAccountBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [OrderAccountBottomView new];
        _bottomView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        _bottomView.blockClick = ^{
            [weakSelf.inputView show];
        };
    }
    return _bottomView;
}
- (OrderAccountBottomEditView *)bottomEditView{
    if (!_bottomEditView) {
        _bottomEditView = [OrderAccountBottomEditView new];
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
    [self.tableView registerClass:[OrderAccountListCell class] forCellReuseIdentifier:@"OrderAccountListCell"];
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
        [self.nav resetNavRightView:self.navRightManageView];
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
    OrderAccountListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderAccountListCell"];
    cell.isEditing = self.isEditing;
    [cell resetCellWithModel:nil];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [OrderAccountListCell fetchHeight:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isEditing) {
        OrderAccountListCell * cell = (OrderAccountListCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.ivSelected.highlighted = !cell.ivSelected.highlighted;
    }
}
#pragma mark click
- (void)completeClick{
    self.isEditing = false;
    [self reconfigView];
}
- (void)manageClick{
    self.isEditing = true;
    [self reconfigView];

}
#pragma mark request
- (void)requestList{
    self.aryDatas = @[@"",@"",@""].mutableCopy;
    [self.tableView reloadData];
}
@end
