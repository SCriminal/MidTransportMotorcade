//
//  SelectCompanyTypeVC
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/5.
//Copyright © 2019 ping. All rights reserved.
//

#import "ManageMotorcadeVC.h"
//cell
#import "SelectAuthorityCell.h"
//request company
#import "RequestApi+Company.h"
@interface ManageMotorcadeVC ()
@property (nonatomic, strong) SelectAuthorityTopView *topView;

@end

@implementation ManageMotorcadeVC


- (SelectAuthorityTopView *)topView{
    if (!_topView) {
        _topView = [SelectAuthorityTopView new];
        [_topView resetViewWithTitle:@"管理车队" subTitle:@"请选择管理车队"];
    }
    return _topView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[SelectAuthorityCell class] forCellReuseIdentifier:@"SelectAuthorityCell"];
    self.tableView.tableHeaderView = self.topView;
    //request
    if (isAry(self.aryCompanyModels)) {
        [self configData];
    }else{
        [self requestList];
    }
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"" rightView:nil];
    nav.line.hidden = true;
    [self.view addSubview:nav];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectAuthorityCell * cell =[tableView dequeueReusableCellWithIdentifier:@"SelectAuthorityCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.cellClick = ^(SelectAuthorityCell *clickCell) {
        [weakSelf requestDetail:clickCell.model.subTitle.doubleValue];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SelectAuthorityCell fetchHeight:nil];
}


#pragma mark request
- (void)configData{
    [self.aryDatas removeAllObjects];
    for (ModelCompanyList * model  in self.aryCompanyModels) {
        ModelBtn * modelBtn = [ModelBtn new];
        modelBtn.title = model.entName;
        modelBtn.imageName = IMAGE_HEAD_COMPANY_DEFAULT;
        modelBtn.highImageName = model.logoUrl;
        modelBtn.subTitle = strDotF(model.entId);
        [self.aryDatas addObject:modelBtn];
    }
    [self.tableView reloadData];
}
- (void)requestList{
    [RequestApi requestCompanyListWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.aryCompanyModels = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelCompanyList"];
        [self configData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestDetail:(double)entId{
    [RequestApi requestCompanyDetailWithId:entId delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalData sharedInstance].GB_CompanyModel = [GlobalMethod exchangeDicToModel:response modelName:@"ModelCompany"];
        [ModelUser jumpToAuthorityStateVCSuccessBlock:^{
            [GB_Nav popToRootViewControllerAnimated:true];
        }];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
