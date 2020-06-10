//
//  AddDriverVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/6.
//Copyright © 2019 ping. All rights reserved.
//

#import "AddDriverVC.h"
//keyboard observe
#import "BaseTableVC+KeyboardObserve.h"
#import "BaseVC+BaseImageSelectVC.h"
#import "BaseTableVC+Authority.h"
#import "BaseNavView+Logical.h"
//select image
#import "AuthorityImageView.h"
//request
#import "RequestApi+Company.h"
#import "RequestApi+UserApi.h"
//up image
#import "AliClient.h"
//example vc
#import "AuthortiyExampleVC.h"

@interface AddDriverVC ()
@property (nonatomic, strong) ModelBaseData *modelPhone;
@property (nonatomic, strong) ModelBaseData *modelPwd;
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelIdentityCode;
@property (nonatomic, strong) ModelBaseData *modelAddr;

@property (nonatomic, strong) AuthorityImageView *bottomView;
@end

@implementation AddDriverVC

#pragma mark lazy init
- (ModelBaseData *)modelPhone{
    if (!_modelPhone) {
        _modelPhone =^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"司机账号";
            model.subString = self.model.driverPhone;
            model.placeHolderString = @"输入司机手机号 (必填)";
            return model;
        }();
    }
    return _modelPhone;
}
- (ModelBaseData *)modelPwd{
    if (!_modelPwd) {
        _modelPwd = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"登录密码";
            model.placeHolderString = @"输入司机登录密码 (必填)";
            return model;
        }();
    }
    return _modelPwd;
}
- (ModelBaseData *)modelName{
    if (!_modelName) {
        _modelName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"司机姓名";
            model.placeHolderString = @"输入司机真实姓名 (必填)";
            model.subString = self.model.driverName;
            return model;
        }();
    }
    return _modelName;
}
- (ModelBaseData *)modelIdentityCode{
    if (!_modelIdentityCode) {
        _modelIdentityCode = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"身份证号";
            model.placeHolderString = @"输入司机身份证号 (必填)";
            model.subString = self.model.idNumber;
            return model;
        }();
    }
    return _modelIdentityCode;
}


- (ModelBaseData *)modelAddr{
    if (!_modelAddr) {
        _modelAddr = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"地        址";
            model.subString = self.model.addr;
            model.placeHolderString = @"输入身份证上地址 (开票必填)";
            return model;
        }();
    }
    return _modelAddr;
}
- (AuthorityImageView *)bottomView{
    if (!_bottomView) {
        _bottomView = [AuthorityImageView new];
        [_bottomView resetViewWithAryModels:@[^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加身份证人像面";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_身份证正"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            model.isEssential = true;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加身份证国徽面";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_身份证反"] url:nil];
            model.isEssential = true;
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加手持身份证人像面";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_手持身份证"] url:nil];
            model.isEssential = true;
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加驾驶证主页";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_驾驶证"] url:nil];
            model.isEssential = true;
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            return model;
        }()]];
    }
    return _bottomView;
}


#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    //    self.tableView.tableHeaderView = self.topView;
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    self.tableView.tableFooterView = self.bottomView;
    [self registAuthorityCell];
    
    //config data
    [self configData];
    //add keyboard observe
    [self addObserveOfKeyboard];
    //configImage
    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
    
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    BaseNavView *nav = [BaseNavView initNavBackTitle:self.model.driverId?@"编辑司机": @"添加司机" rightTitle:self.model.driverId?@"重新提交":@"提交" rightBlock:^{
        [weakSelf requestAdd];
    }];
    [nav configBlackBackStyle];
    [self.view addSubview:nav];
    //request
    [self requestInfo];
}

#pragma mark config data
- (void)configData{
    self.aryDatas = @[^(){
        ModelBaseData * model = [ModelBaseData new];
        model.enumType = ENUM_PERFECT_CELL_EMPTY;
        model.imageName = @"";
        model.string = @"基本信息";
        return model;
    }(),self.modelName,self.modelIdentityCode,self.modelAddr,^(){
        ModelBaseData * model = [ModelBaseData new];
        model.enumType = ENUM_PERFECT_CELL_EMPTY;
        model.imageName = @"";
        model.string = @"认证资料";
        model.isSelected = true;
        model.blocClick = ^(ModelBaseData *item) {
            AuthortiyExampleVC * vc = [AuthortiyExampleVC new];
            vc.aryDatas =@[^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"身份证人像面示例";
                model.imageName = @"authority_example_idcard";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"身份证国徽面示例";
                model.imageName = @"authority_example_idcardBack";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"手持身份证示例";
                model.imageName = @"authority_example_idcardHand";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"驾驶证主页示例";
                model.imageName = @"authority_example_driverlicense";
                return model;
            }()].mutableCopy;
            [GB_Nav pushViewController:vc animated:true];
        };
        return model;
    }()].mutableCopy;
    if (!self.model.driverId) {
        [self.aryDatas insertObject:self.modelPhone atIndex:1];
        [self.aryDatas insertObject:self.modelPwd atIndex:2];
    }
    [self.tableView reloadData];
}
#pragma mark image select
- (void)imageSelect:(BaseImage *)image{
}
#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self dequeueAuthorityCell:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self fetchAuthorityCellHeight:indexPath];
}



#pragma mark status bar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark request
- (void)requestAdd{
    if (!isStr(self.modelPhone.subString)) {
        [GlobalMethod showAlert:@"请输入司机手机号"];
        return;
    }
    if (!self.model.driverId) {
        if (!isStr(self.modelPwd.subString)) {
            [GlobalMethod showAlert:@"请输入司机登录密码"];
            return;
        }
    }
    if (!isStr(self.modelName.subString)) {
        [GlobalMethod showAlert:@"请输入司机真实姓名"];
        return;
    }
    if (!isStr(self.modelIdentityCode.subString)) {
        [GlobalMethod showAlert:@"请输入司机身份证号"];
        return;
    }
    ModelImage * model0 = [self.bottomView.aryDatas objectAtIndex:0];
    ModelImage * model1 = [self.bottomView.aryDatas objectAtIndex:1];
    ModelImage * model2 = [self.bottomView.aryDatas objectAtIndex:2];
    ModelImage * model3 = [self.bottomView.aryDatas objectAtIndex:3];
    if (!isStr(model0.image.imageURL)) {
        [GlobalMethod showAlert:@"请添加身份证人像面"];
        return;
    }
    if (!isStr(model1.image.imageURL)) {
        [GlobalMethod showAlert:@"请添加身份证国徽面"];
        return;
    }
    if (!isStr(model2.image.imageURL)) {
        [GlobalMethod showAlert:@"请添加手持身份证人像面"];
        return;
    }
    if (!isStr(model3.image.imageURL)) {
        [GlobalMethod showAlert:@"请添加驾驶证主页"];
        return;
    }
    
    if (self.model.driverId) {
        [RequestApi requestEditDriverWithName:self.modelName.subString
                                       idCard:self.modelIdentityCode.subString
                                        entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty
                                           id:self.model.driverId
                                     bankName:nil
                                  bankAccount:nil
                                         addr:self.modelAddr.subString
                               idCardFrontUrl:UnPackStr(model0.image.imageURL)
                                idCardBackUrl:UnPackStr(model1.image.imageURL)
                             driverLicenseUrl:UnPackStr(model3.image.imageURL)
                              idCardHandelUrl:UnPackStr(model2.image.imageURL)
                                     delegate:self
                                      success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"编辑成功"];
            self.requestState = 1;
            [GB_Nav popViewControllerAnimated:true];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }else{
        [RequestApi requestAddDriverWithPhone:self.modelPhone.subString
                                          pwd:self.modelPwd.subString
                                         name:self.modelName.subString
                                       idCard:self.modelIdentityCode.subString
                                        entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty
                                     bankName:nil
                                  bankAccount:nil
                                         addr:self.modelAddr.subString
                               idCardFrontUrl:UnPackStr(model0.image.imageURL)
                                idCardBackUrl:UnPackStr(model1.image.imageURL)
                             driverLicenseUrl:UnPackStr(model3.image.imageURL)
                              idCardHandelUrl:UnPackStr(model2.image.imageURL)
                                     delegate:self
                                      success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"添加成功"];
            self.requestState = 1;
            [GB_Nav popViewControllerAnimated:true];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }
    
    
}

- (void)requestInfo{
    if (!self.model.driverId) {
        return;
    }
    [RequestApi requestDriveFileListPassWithDriverId:self.model.driverId
                                               entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty
                                            delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        if (!isDic(response)) {
            return ;
        }
        [self.bottomView resetViewWithAryModels:@[^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加身份证人像面";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_身份证正"] url:nil];
            model.isEssential = true;
            model.url = [response stringValueForKey:@"idCardFrontUrl"];
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加身份证国徽面";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_身份证反"] url:nil];
            model.isEssential = true;
            model.url = [response stringValueForKey:@"idCardBackUrl"];
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加手持身份证人像面";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_手持身份证"] url:nil];
            model.isEssential = true;
            model.url = [response stringValueForKey:@"idCardHandelUrl"];
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加驾驶证主页";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_驾驶证"] url:nil];
            model.isEssential = true;
            model.url = [response stringValueForKey:@"driverLicenseUrl"];
            model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
            return model;
        }()]];
        
        
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
