//
//  TransportCompanyAuthorityVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/6.
//  Copyright © 2019 ping. All rights reserved.
//

#import "TransportCompanyAuthorityVC.h"
//keyboard observe
#import "BaseTableVC+KeyboardObserve.h"
#import "BaseVC+BaseImageSelectVC.h"
#import "BaseTableVC+Authority.h"
#import "BaseNavView+Logical.h"
//select image
#import "AuthorityImageView.h"
//request
#import "RequestApi+Company.h"
//select district view
#import "SelectDistrictView.h"
//example vc
#import "AuthortiyExampleVC.h"
#import "ManageMotorcadeVC.h"

@interface TransportCompanyAuthorityVC ()
@property (nonatomic, strong) ModelBaseData *modelCompanyName;
@property (nonatomic, strong) ModelBaseData *modelCreditCode;
@property (nonatomic, strong) ModelBaseData *modelAdmitCode;
@property (nonatomic, strong) ModelBaseData *modelLegalPersonName;
@property (nonatomic, strong) ModelBaseData *modelLegalPersonNum;
@property (nonatomic, strong) ModelBaseData *modelPhone;
@property (nonatomic, strong) ModelBaseData *modelEmail;
@property (nonatomic, strong) ModelBaseData *modelAddress;
@property (nonatomic, strong) ModelBaseData *modelAddressDetail;
@property (nonatomic, strong) AuthorityImageView *bottomView;

@end

@implementation TransportCompanyAuthorityVC

#pragma mark lazy init
- (ModelBaseData *)modelCompanyName{
    if (!_modelCompanyName) {
        _modelCompanyName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"企业名称";
            model.placeHolderString = @"输入工商营业执照上的企业名称(必填)";
            return model;
        }();
    }
    return _modelCompanyName;
}
- (ModelBaseData *)modelCreditCode{
    if (!_modelCreditCode) {
        _modelCreditCode = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"信用代码";
            model.placeHolderString = @"输入统一社会信用代码(必填)";
            return model;
        }();
    }
    return _modelCreditCode;
}
- (ModelBaseData *)modelAdmitCode{
    if (!_modelAdmitCode) {
        _modelAdmitCode = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"许可证号";
            model.placeHolderString = @"输入道路运输许可证号(必填)";
            return model;
        }();
    }
    return _modelAdmitCode;
}
- (ModelBaseData *)modelLegalPersonName{
    if (!_modelLegalPersonName) {
        _modelLegalPersonName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"法人姓名";
            model.placeHolderString = @"输入法人真实姓名(必填)";
            return model;
        }();
    }
    return _modelLegalPersonName;
}
- (ModelBaseData *)modelLegalPersonNum{
    if (!_modelLegalPersonNum) {
        _modelLegalPersonNum = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"身份证号";
            model.placeHolderString = @"输入法人身份证号(必填)";
            return model;
        }();
    }
    return _modelLegalPersonNum;
}
- (ModelBaseData *)modelPhone{
    if (!_modelPhone) {
        _modelPhone = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"办公电话";
            model.placeHolderString = @"输入企业办公电话";
            return model;
        }();
    }
    return _modelPhone;
}
- (ModelBaseData *)modelEmail{
    if (!_modelEmail) {
        _modelEmail = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"办公邮箱";
            model.placeHolderString = @"输入企业办公邮箱";
            return model;
        }();
    }
    return _modelEmail;
}
- (ModelBaseData *)modelAddress{
    if (!_modelAddress) {
        WEAKSELF
        _modelAddress = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"办公地址";
            model.placeHolderString = @"选择办公地址(必填)";
            model.blocClick = ^(ModelBaseData *model) {
                SelectDistrictView * selectView = [SelectDistrictView new];
                selectView.blockCitySeleted = ^(ModelProvince *pro, ModelProvince *city, ModelProvince *area) {
                    weakSelf.modelAddress.subString = [NSString stringWithFormat:@"%@%@%@",pro.name,[pro.name isEqualToString:city.name]?@"":city.name,area.name];
                    weakSelf.modelAddress.identifier = strDotF(area.value);
                    [weakSelf configData];
                };
                [weakSelf.view addSubview:selectView];
            };
            return model;
        }();
    }
    return _modelAddress;
}
- (ModelBaseData *)modelAddressDetail{
    if (!_modelAddressDetail) {
        _modelAddressDetail = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"详细地址";
            model.placeHolderString = @"输入详细办公地址(必填)";
            model.hideState = true;
            return model;
        }();
    }
    return _modelAddressDetail;
}
- (AuthorityImageView *)bottomView{
    if (!_bottomView) {
        _bottomView = [AuthorityImageView new];
        [_bottomView resetViewWithAryModels:@[^(){
            ModelImage * model = [ModelImage new];
            model.desc =@"添加营业执照";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_营业执照"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY;
            model.isEssential = true;
            return model;
        }() ,^(){
            ModelImage * model = [ModelImage new];
            model.desc =@"添加道路运输许可证";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_运输许可证"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY;
            model.isEssential = true;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc =@"添加法人身份证人像面";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_身份证正"] url:nil];
             model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY;
            model.isEssential = true;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc =@"添加法人身份证国徽面";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_身份证反"] url:nil];
             model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY;
            model.isEssential = true;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc =@"添加企业LOGO";
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_logo"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_LOGO;
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
    if (self.model.iDProperty) {
        [self reqeustImageInfo];
    }
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    BaseNavView *nav = [BaseNavView initNavBackTitle:@"认证运输公司" rightTitle:@"提交" rightBlock:^{
        ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_333];
        ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认提交" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
        modelConfirm.blockClick = ^(void){
            [weakSelf requestAdd];
        };
        [BaseAlertView initWithTitle:@"提示" content:@"是否确认提交？" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:weakSelf.view];
    }];
    [nav configBlackBackStyle];
    [self.view addSubview:nav];
}

#pragma mark config data
- (void)configData{
    self.aryDatas = @[^(){
        ModelBaseData * model = [ModelBaseData new];
        model.enumType = ENUM_PERFECT_CELL_EMPTY;
        model.imageName = @"";
        model.string = @"基本信息";
        return model;
    }(),self.modelCompanyName,self.modelCreditCode,self.modelAdmitCode,self.modelLegalPersonName,self.modelLegalPersonNum,self.modelPhone,self.modelEmail,self.modelAddress,self.modelAddressDetail,^(){
        ModelBaseData * model = [ModelBaseData new];
        model.enumType = ENUM_PERFECT_CELL_EMPTY;
        model.imageName = @"";
        model.string = @"认证资料";
        model.isSelected = true;
        model.blocClick = ^(ModelBaseData *item) {
            AuthortiyExampleVC * vc = [AuthortiyExampleVC new];
            vc.aryDatas =@[^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"企业营业执照示例";
                model.imageName = @"营业执照";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"道路经营许可证示例";
                model.imageName = @"运输许可证";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"身份证人像面示例";
                model.imageName = @"authority_example_idcard";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"身份证国徽面示例";
                model.imageName = @"authority_example_idcardBack";
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
    ModelImage * model4 = [self.bottomView.aryDatas objectAtIndex:4];
    
    if (!isStr(model0.image.imageURL)) {
        [GlobalMethod showAlert:@"请添加营业执照"];
        return;
    }
    if (!isStr(model1.image.imageURL)) {
        [GlobalMethod showAlert:@"请添加道路运输许可证"];
        return;
    }
    if (!isStr(model2.image.imageURL)) {
        [GlobalMethod showAlert:@"请添加法人身份证人像面"];
        return;
    }
    if (!isStr(model3.image.imageURL)) {
        [GlobalMethod showAlert:@"请添加法人身份证国徽面"];
        return;
    }
    if (!isStr(self.modelCompanyName.subString)) {
        [GlobalMethod showAlert:@"请企业名称"];
        return;
    }
    if (!isStr(self.modelCreditCode.subString)) {
        [GlobalMethod showAlert:@"请统一社会信用代码"];
        return;
    }
    if (!isStr(self.modelAdmitCode.subString)) {
        [GlobalMethod showAlert:@"请道路运输许可证号"];
        return;
    }
    if (!isStr(self.modelLegalPersonName.subString)) {
        [GlobalMethod showAlert:@"请输入法人真实姓名"];
        return;
    }
    if (!isStr(self.modelLegalPersonNum.subString)) {
        [GlobalMethod showAlert:@"请输入法人身份证号"];
        return;
    }
    if (!isStr(self.modelAddress.subString)) {
        [GlobalMethod showAlert:@"请选择办公地址"];
        return;
    }
    if (!isStr(self.modelAddressDetail.subString)) {
        [GlobalMethod showAlert:@"请输入详细办公地址"];
        return;
    }
    
    if (self.model.iDProperty) {//resubmit
        [RequestApi requestReAddTransportCompanyWithLogourl:model4.image.imageURL
                                          businessLicense:self.modelCreditCode.subString
                                           identityNumber:self.modelLegalPersonNum.subString
                                           officeCountyId:self.modelAddress.identifier.doubleValue legalName:self.modelLegalPersonName.subString
                                              officeEmail:self.modelEmail.subString
                                              officePhone:self.modelPhone.subString
                                                     name:self.modelCompanyName.subString
                                         officeAddrDetail:self.modelAddressDetail.subString
                                          managementLicense:self.modelAdmitCode.subString
                                         businessLicenseUrl:UnPackStr(model0.image.imageURL)
                                             idCardFrontUrl:UnPackStr(model2.image.imageURL)
                                          idCardNegativeUrl:UnPackStr(model3.image.imageURL)
                                       managementLicenseUrl:UnPackStr(model1.image.imageURL)
                                                         id:self.model.iDProperty
                                                   delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                                                       BOOL isEnt = [GlobalData sharedInstance].GB_CompanyModel.isEnt;
                                                       [RequestApi requestCompanyDetailWithId:self.model.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                                                           if (isEnt) {
                                                               [GB_Nav popToRootViewControllerAnimated:true];
                                                               return ;
                                                           }
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
                                                   } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {}];
    }else{//create
        [RequestApi requestAddTransportCompanyWithLogourl:model4.image.imageURL
                                          businessLicense:self.modelCreditCode.subString
                                           identityNumber:self.modelLegalPersonNum.subString
                                           officeCountyId:self.modelAddress.identifier.doubleValue legalName:self.modelLegalPersonName.subString
                                              officeEmail:self.modelEmail.subString
                                              officePhone:self.modelPhone.subString
                                                     name:self.modelCompanyName.subString
                                         officeAddrDetail:self.modelAddressDetail.subString
                                        managementLicense:self.modelAdmitCode.subString
                                       businessLicenseUrl:UnPackStr(model0.image.imageURL)
                                           idCardFrontUrl:UnPackStr(model2.image.imageURL)
                                        idCardNegativeUrl:UnPackStr(model3.image.imageURL)
                                     managementLicenseUrl:UnPackStr(model1.image.imageURL)                                         delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
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

- (void)reqeustImageInfo{
    self.modelCompanyName.subString = self.model.name;
    self.modelCreditCode.subString = self.model.businessLicense;
    self.modelAdmitCode.subString = self.model.managementLicense;
    self.modelLegalPersonName.subString = self.model.legalName;
    self.modelLegalPersonNum.subString = self.model.identityNumber;
    self.modelPhone.subString = self.model.officePhone;
    self.modelEmail.subString = self.model.officeEmail;
    self.modelAddress.subString = [NSString stringWithFormat:@"%@%@%@",UnPackStr(self.model.officeProvinceName),UnPackStr(self.model.officeCityName),UnPackStr(self.model.officeCountyName)];
    self.modelAddress.identifier = strDotF(self.model.officeCountyId);
    self.modelAddressDetail.subString = self.model.officeAddrDetail;
    [self.tableView reloadData];
    
    [RequestApi requestAuthorityImageWithEntid:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        if (![response isKindOfClass:NSDictionary.class]) {
            return ;
        }
        [self.bottomView resetViewWithAryModels:@[^(){
            ModelImage * model = [ModelImage new];
            model.desc =@"添加营业执照";
            model.url = [response stringValueForKey:@"businessLicenseUrl"];
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_营业执照"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY;
            return model;
        }() ,^(){
            ModelImage * model = [ModelImage new];
            model.desc =@"添加道路运输许可证";
            model.url = [response stringValueForKey:@"managementLicenseUrl"];
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_运输许可证"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc =@"添加法人身份证人像面";
            model.url = [response stringValueForKey:@"idCardFrontUrl"];
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_身份证正"] url:nil];
             model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc =@"添加法人身份证国徽面";
            model.url = [response stringValueForKey:@"idCardNegativeUrl"];
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_身份证反"] url:nil];
             model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_AUTHORITY;
            return model;
        }(),^(){
            ModelImage * model = [ModelImage new];
            model.desc =@"添加企业LOGO";
            model.url = self.model.logoUrl;
            model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_logo"] url:nil];
            model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_LOGO;
            return model;
        }()]];
        [self.tableView reloadData];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
@end
