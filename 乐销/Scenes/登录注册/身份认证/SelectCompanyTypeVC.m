//
//  SelectCompanyTypeVC
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/5.
//Copyright © 2019 ping. All rights reserved.
//

#import "SelectCompanyTypeVC.h"
//cell
#import "SelectAuthorityCell.h"

@interface SelectCompanyTypeVC ()
@property (nonatomic, strong) SelectAuthorityTopView *topView;

@end

@implementation SelectCompanyTypeVC


- (SelectAuthorityTopView *)topView{
    if (!_topView) {
        _topView = [SelectAuthorityTopView new];
        [_topView resetViewWithTitle:@"我要认证" subTitle:@"请选择认证身份"];
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
    [self requestList];
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
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SelectAuthorityCell fetchHeight:nil];
}

#pragma mark request
- (void)requestList{
    self.aryDatas = @[^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"我是运输公司";
        model.imageName = @"selectAuthority_Man";
        model.blockClick = ^{
            [GB_Nav pushVCName:@"TransportCompanyAuthorityVC" animated:true];
        };
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"我是个体车主";
        model.imageName = @"selectAuthority_Car";
        model.blockClick = ^{
            [GB_Nav pushVCName:@"PersonalCarOwnerAuthorityVC" animated:true];
        };
        return model;
    }()].mutableCopy;
    [self.tableView reloadData];
}
@end
