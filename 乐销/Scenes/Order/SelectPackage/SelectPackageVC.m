//
//  SelectPackageVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/8.
//Copyright © 2019 ping. All rights reserved.
//

#import "SelectPackageVC.h"
//cell
#import "SelectPackageCell.h"
#import "BaseNavView+Logical.h"
//request
#import "RequestApi+Order.h"
//select car vc
#import "SelectCarVC.h"

@interface SelectPackageVC ()
@property (nonatomic, strong) SelectPackageBottomView *bottomView;

@end

@implementation SelectPackageVC
@synthesize noResultView = _noResultView;
#pragma mark lazy init
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_package" title:@"暂无可派箱货"];
        _noResultView.backgroundColor = [UIColor clearColor];
    }
    return _noResultView;
}
//lazy init
- (SelectPackageBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [SelectPackageBottomView new];
        _bottomView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        _bottomView.blockSelectAll = ^(BOOL isSelectAll) {
            for (ModelPackageInfo * model in weakSelf.aryDatas) {
                model.isSelected = isSelectAll;
            }
            [weakSelf.tableView reloadData];
        };
        _bottomView.blockSend = ^{
            SelectCarVC * selectCarVC = [SelectCarVC new];
            selectCarVC.model = weakSelf.model;
            selectCarVC.aryPackages = [weakSelf.aryDatas fetchSelectModelsKeyPath:@"isSelected" value:@TRUE];
            if (!isAry(selectCarVC.aryPackages)) {
                [GlobalMethod showAlert:@"请先选择货物"];
                return ;
            }
            [GB_Nav pushViewController:selectCarVC animated:true];
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
    [self.tableView registerClass:[SelectPackageCell class] forCellReuseIdentifier:@"SelectPackageCell"];
    [self.view addSubview:self.bottomView];
    self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.bottomView.height;
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"选择箱量" rightView:nil];
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
    SelectPackageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectPackageCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SelectPackageCell fetchHeight:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectPackageCell * cell = (SelectPackageCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.ivSelect.highlighted = !cell.ivSelect.highlighted;
    cell.model.isSelected = cell.ivSelect.highlighted;
    BOOL isSelectAll = true;
    for (ModelPackageInfo * item in self.aryDatas) {
        if (!item.isSelected) {
            isSelectAll = false;
            break;
        }
    }
    self.bottomView.ivSelect.highlighted = isSelectAll;
}


#pragma mark status bar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//request
- (void)requestList{
    [RequestApi requestGoosListWithId:self.model.iDProperty entID:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.aryDatas = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelPackageInfo"];
        for (ModelPackageInfo * item in self.aryDatas.copy) {
            if (item.cargoState >4) {
                [self.aryDatas removeObject:item];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    } ];
}
@end
