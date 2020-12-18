//
//  PersonalCarOwnerAuthorityVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/6.
//Copyright © 2019 ping. All rights reserved.
//

#import "PersonalCarOwnerAuthorityVC.h"
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
//example vc
#import "AuthortiyExampleVC.h"
#import "ManageMotorcadeVC.h"
@interface PersonalCarOwnerAuthorityVC ()
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelIdentityCode;
@property (nonatomic, strong) AuthorityImageView *bottomView;
@property (strong, nonatomic) ModelBaseInfo *modelBaseInfo;

@end

@implementation PersonalCarOwnerAuthorityVC

#pragma mark lazy init
- (ModelBaseData *)modelName{
    if (!_modelName) {
        _modelName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"真实姓名";
            model.placeHolderString = @"输入身份证上的真实姓名(必填)";
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
            model.placeHolderString = @"输入身份证号码(必填)";
            model.hideState = true;
            return model;
        }();
    }
    return _modelIdentityCode;
}
- (AuthorityImageView *)bottomView{
    if (!_bottomView) {
        _bottomView = [AuthorityImageView new];
        [_bottomView resetViewWithAryModels:@[^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加身份证人像面";
            model.isEssential = true;
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_身份证正"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加身份证国徽面";
            model.isEssential = true;
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_身份证反"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加手持身份证人像面";
            model.isEssential = false;
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_手持身份证"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加驾驶证主页";
            model.isEssential = true;
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_驾驶证"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY;
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
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    BaseNavView *nav = [BaseNavView initNavBackTitle:@"认证个体车主" rightTitle:@"提交" rightBlock:^{
        ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_333];
        ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认提交" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
        modelConfirm.blockClick = ^(void){
            [weakSelf requestAdd];
        };
        [BaseAlertView initWithTitle:@"提示" content:@"是否确认提交？" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:weakSelf.view];
    }];
    [nav configBlackBackStyle];
    [self.view addSubview:nav];
    if (self.model.iDProperty) {
        [self requestBaseInfo];
    }
}

#pragma mark config data
- (void)configData{
    self.aryDatas = @[^(){
        ModelBaseData * model = [ModelBaseData new];
        model.enumType = ENUM_PERFECT_CELL_EMPTY;
        model.imageName = @"";
        model.string = @"基本信息";
        return model;
    }(),self.modelName,self.modelIdentityCode,^(){
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
    
    ModelImage * model0 = [self.bottomView.aryDatas objectAtIndex:0];
    ModelImage * model1 = [self.bottomView.aryDatas objectAtIndex:1];
    ModelImage * model2 = [self.bottomView.aryDatas objectAtIndex:2];
    ModelImage * model3 = [self.bottomView.aryDatas objectAtIndex:3];
    
    if (!isStr(model0.image.imageURL)) {
        [GlobalMethod showAlert:@"请添加身份证人像面图片"];
        return;
    }
    if (!isStr(model1.image.imageURL)) {
        [GlobalMethod showAlert:@"请添加身份证国徽面图片"];
        return;
    }
//    if (!isStr(model2.image.imageURL)) {
//        [GlobalMethod showAlert:@"请添加手持身份证图片"];
//        return;
//    }
    if (!isStr(model3.image.imageURL)) {
        [GlobalMethod showAlert:@"请添加驾驶证主页"];
        return;
    }
    
    
    if (self.model.iDProperty) {//resubmit
        [ RequestApi requestReAddSelfCompanyWithBusinesslicense:self.modelIdentityCode.subString name:self.modelName.subString idCardFrontUrl:UnPackStr(model0.image.imageURL) idCardNegativeUrl:UnPackStr(model1.image.imageURL) idCardHandheldUrl:UnPackStr(model2.image.imageURL)
                                               driverLicenseUrl:UnPackStr(model3.image.imageURL)
                                                             id:self.model.iDProperty
                                                       delegate:self
                                                        success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            BOOL isEnt = [GlobalData sharedInstance].GB_CompanyModel.isEnt;
            [RequestApi requestCompanyDetailWithId:self.model.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                NSMutableArray * ary = [NSMutableArray array];
                if (isEnt) {
                    [GB_Nav popToRootViewControllerAnimated:true];
                    return ;
                }
                for (UIViewController * vc in GB_Nav.viewControllers) {
                    if ([vc isKindOfClass:NSClassFromString(@"LoginViewController")]) {
                        [ary addObject:vc];
                        [ary addObject:[NSClassFromString(@"AuthorityVerifyingVC") new]];
                        [GB_Nav setViewControllers:ary animated:true];
                        [GlobalMethod showAlert:@"资料提交成功"];
                        return;
                    }else{
                        [ary addObject:vc];
                    }
                }
                [GlobalMethod clearUserInfo];
                [GlobalMethod createRootNav];
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
            
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {}];
    }else{//create
        [RequestApi requestAddSelfCompanyWithBusinesslicense:self.modelIdentityCode.subString name:self.modelName.subString idCardFrontUrl:UnPackStr(model0.image.imageURL) idCardNegativeUrl:UnPackStr(model1.image.imageURL) idCardHandheldUrl:UnPackStr(model2.image.imageURL)                                driverLicenseUrl:UnPackStr(model3.image.imageURL)
                                                    delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [RequestApi requestCompanyListWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                NSArray * aryResponse = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelCompanyList"];
                if (!isAry(aryResponse)) {
                    [GB_Nav pushVCName:@"SelectCompanyTypeVC" animated:true];
                }else if(aryResponse.count == 1){
                    ModelCompanyList * modelLast = aryResponse.lastObject;
                    [RequestApi requestCompanyDetailWithId:modelLast.entId delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                        NSMutableArray * ary = [NSMutableArray array];
                        
                        for (UIViewController * vc in GB_Nav.viewControllers) {
                            if ([vc isKindOfClass:NSClassFromString(@"LoginViewController")]) {
                                [ary addObject:vc];
                                [ary addObject:[NSClassFromString(@"AuthorityVerifyingVC") new]];
                                [GB_Nav setViewControllers:ary animated:true];
                                [GlobalMethod showAlert:@"资料提交成功"];
                                return;
                            }else{
                                [ary addObject:vc];
                            }
                        }
                        [GlobalMethod clearUserInfo];
                        [GlobalMethod createRootNav];
                    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                        
                    }];
                    
                }else{
                    ManageMotorcadeVC * selectVC = [ManageMotorcadeVC new];
                    selectVC.aryCompanyModels = aryResponse.mutableCopy;
                    [GB_Nav pushViewController:selectVC animated:true];
                }
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {}];
    }
    
}

- (void)requestBaseInfo{
    self.modelName.subString = self.model.name;
    self.modelIdentityCode.subString = self.model.businessLicense;
    [self.tableView reloadData];
    [self reqeustImageInfo];
}

- (void)reqeustImageInfo{
    
    [RequestApi requestAuthorityImageWithEntid:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        if (![response isKindOfClass:NSDictionary.class]) {
            return ;
        }
        [self.bottomView resetViewWithAryModels:@[^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加身份证人像面";
            model.isEssential = true;
            model.url = [response stringValueForKey:@"idCardFrontUrl"];
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_身份证正"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加身份证国徽面";
            model.isEssential = true;
            model.url = [response stringValueForKey:@"idCardNegativeUrl"];
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_身份证反"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加手持身份证人像面";
            model.isEssential = false;
            model.url = [response stringValueForKey:@"idCardHandheldUrl"];
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_手持身份证"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc = @"添加驾驶证主页";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_驾驶证"] url:nil];
            model.isEssential = true;
            model.url = [response stringValueForKey:@"driverLicenseUrl"];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY;
            return model;
        }()]];
        [self.tableView reloadData];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
@end
