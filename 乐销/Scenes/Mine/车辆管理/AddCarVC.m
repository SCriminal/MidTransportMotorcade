//
//  AddCarVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/6.
//Copyright © 2019 ping. All rights reserved.
//

#import "AddCarVC.h"
//keyboard observe
#import "BaseTableVC+KeyboardObserve.h"
#import "BaseVC+BaseImageSelectVC.h"
#import "BaseTableVC+Authority.h"
#import "BaseNavView+Logical.h"
//select image
#import "AuthorityImageView.h"
//select driver
#import "SelectDriverVC.h"
//select date
#import "DatePicker.h"
//request
#import "RequestApi+Company.h"
//list view
#import "ListAlertView.h"
//up image
#import "AliClient.h"
//example vc
#import "AuthortiyExampleVC.h"
#import "SelectCarTypeVC.h"
#import "SelectCarNumberView.h"
@interface AddCarVC ()
@property (nonatomic, strong) ModelBaseData *modelCarNum;
@property (nonatomic, strong) ModelBaseData *modelHangCode;
@property (nonatomic, strong) ModelBaseData *modelOwner;
@property (nonatomic, strong) ModelBaseData *modelDriver;
@property (nonatomic, strong) ModelBaseData *modelDriverPhone;
@property (nonatomic, strong) ModelBaseData *modelCarIdentityCode;
@property (nonatomic, strong) ModelBaseData *modelEngineCode;
@property (nonatomic, strong) ModelBaseData *modelDrivingNumber;
@property (nonatomic, strong) ModelBaseData *modelVehicleLength;
@property (nonatomic, strong) ModelBaseData *modelVehicleWidth;
@property (nonatomic, strong) ModelBaseData *modelVehicleHeight;
@property (nonatomic, strong) ModelBaseData *modelVehicleType;
@property (nonatomic, strong) ModelBaseData *modelVehicleLoad;
@property (nonatomic, strong) ModelBaseData *modelAllQuality;
@property (nonatomic, strong) ModelBaseData *modelAxle;
@property (nonatomic, strong) ModelBaseData *modelUnbindDriver;
@property (nonatomic, strong) ModelBaseData *modelLicenseType;
@property (nonatomic, strong) ModelBaseData *modelCarModel;
@property (nonatomic, strong) ModelBaseData *modelUsage;
@property (nonatomic, strong) ModelBaseData *modelEnergyType;
@property (nonatomic, strong) ModelBaseData *modelRoadTransportNum;
@property (nonatomic, strong) ModelBaseData *modelAgency;
@property (nonatomic, strong) ModelBaseData *modelDrivingResignDate;
@property (nonatomic, strong) ModelBaseData *modelDrivingIssueDate;
@property (nonatomic, strong) ModelBaseData *modelDrivingEndDate;

@property (nonatomic, strong) AuthorityImageView *bottomView;
@property (nonatomic, strong) ModelCar *modelDetail;
@end

@implementation AddCarVC

#pragma mark lazy init
- (ModelBaseData *)modelUnbindDriver{
    if (!_modelUnbindDriver) {
        _modelUnbindDriver = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_EMPTY;
            model.imageName = @"";
            model.string = @"基本信息";
            model.subString = @"解绑司机";
            return model;
        }();
    }
    return _modelUnbindDriver;
}
- (ModelBaseData *)modelCarNum{
    if (!_modelCarNum) {
        _modelCarNum = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"车牌号码";
            model.placeHolderString = @"输入车牌号码";
            model.isRequired = true;
            WEAKSELF
            model.blocClick = ^(ModelBaseData *item) {
                [GlobalMethod endEditing];
                for (PerfectSelectCell * cell in weakSelf.tableView.visibleCells) {
                    if ([cell isKindOfClass:[PerfectSelectCell class]] && [cell.model.string isEqualToString: weakSelf.modelCarNum.string]) {
                        CGRect rectOrigin = [cell convertRect:cell.frame toView:[UIApplication sharedApplication].keyWindow];
                        if (CGRectGetMinY(rectOrigin)>SCREEN_HEIGHT/2.0) {
                            [weakSelf.tableView setContentOffset:CGPointMake(0, cell.top) animated:true];
                        }
                        break;
                    }
                }
                
                SelectCarNumberView * selectNumView = [SelectCarNumberView new];
                [selectNumView resetViewWithContent:weakSelf.modelCarNum.subString];
                [weakSelf.view addSubview:selectNumView];
                selectNumView.blockSelected = ^(NSString *str) {
                    weakSelf.modelCarNum.subString = str;
                    [weakSelf.tableView reloadData];
                };
            };
            return model;
        }();
    }
    return _modelCarNum;
}
- (ModelBaseData *)modelOwner{
    if (!_modelOwner) {
        _modelOwner = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"车辆所有人";
            model.placeHolderString = @"输入行驶证上车辆所有人";
            model.isRequired = true;
            return model;
        }();
    }
    return _modelOwner;
}
- (ModelBaseData *)modelVehicleType{
    if (!_modelVehicleType) {
        WEAKSELF
        _modelVehicleType = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"车辆类型";
            model.placeHolderString = @"选择车辆类型";
            model.isRequired = true;
            model.blocClick = ^(ModelBaseData *modelClick) {
                [GlobalMethod endEditing];
                SelectCarTypeVC * selectVC = [SelectCarTypeVC new];
                selectVC.blockSelected = ^(NSString *type, NSNumber *idNumber) {
                    weakSelf.modelVehicleType.subString = type;
                    weakSelf.modelVehicleType.identifier = idNumber.stringValue;
                    [weakSelf.tableView reloadData];
                };
                [GB_Nav pushViewController:selectVC animated:true];
            };
            return model;
        }();
    }
    return _modelVehicleType;
}
- (ModelBaseData *)modelVehicleLoad{
    if (!_modelVehicleLoad) {
        _modelVehicleLoad = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"核定载质量";
            model.placeHolderString = @"选择核定载质量";
            model.isRequired = true;
            WEAKSELF
            model.blocClick = ^(ModelBaseData *modelClick) {
                [GlobalMethod endEditing];
                ListAlertView * listNew = [ListAlertView new];
                NSMutableArray * aryWeight = [NSMutableArray array];
                for (int i = 0; i<55; i++) {
                    [aryWeight addObject:[NSString stringWithFormat:@"%d吨",i+1]];
                }
                for (PerfectSelectCell * cell in weakSelf.tableView.visibleCells) {
                    if ([cell isKindOfClass:[PerfectSelectCell class]] && [cell.model.string isEqualToString: weakSelf.modelVehicleLoad.string]) {
                        [weakSelf.tableView setContentOffset:CGPointMake(0, cell.top) animated:true];
                        [listNew showWithPoint:CGPointMake(W(15), NAVIGATIONBAR_HEIGHT + cell.height)  width:SCREEN_WIDTH - W(30) ary:aryWeight];
                        listNew.alpha = 0;
                        [UIView animateWithDuration:0.3 animations:^{
                            listNew.alpha = 1;
                        }];
                        break;
                    }
                }
                listNew.blockSelected = ^(NSInteger index) {
                    weakSelf.modelVehicleLoad.subString = aryWeight[index];
                    [weakSelf.tableView reloadData];
                };
            };
            
            return model;
        }();
    }
    return _modelVehicleLoad;
}
- (ModelBaseData *)modelLicenseType{
    if (!_modelLicenseType) {
        WEAKSELF
        _modelLicenseType = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"牌照类型";
            model.placeHolderString = @"选择牌照类型";
            model.isRequired = true;
            model.blocClick = ^(ModelBaseData *modelClick) {
                [GlobalMethod endEditing];
                ListAlertView * listNew = [ListAlertView new];
                NSString * strPath = [[NSBundle mainBundle]pathForResource:@"LicenseType" ofType:@"json"];
                NSArray * ary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:strPath] options:0 error:nil];
                NSMutableArray * aryDateTypes = [NSMutableArray array];
                NSMutableArray * aryDateId =[NSMutableArray array];
                for (NSDictionary * dic in ary) {
                    int status = [dic doubleValueForKey:@"status"];
                    if (status != 0) {
                        [aryDateTypes addObject:[dic stringValueForKey:@"label"]];
                        [aryDateId addObject:[dic numberValueForKey:@"value"]];
                    }
                }
                
                for (PerfectSelectCell * cell in weakSelf.tableView.visibleCells) {
                    if ([cell isKindOfClass:[PerfectSelectCell class]] && [cell.model.string isEqualToString: weakSelf.modelLicenseType.string]) {
                        [weakSelf.tableView setContentOffset:CGPointMake(0, cell.top) animated:true];
                        [listNew showWithPoint:CGPointMake(W(15), NAVIGATIONBAR_HEIGHT + cell.height)  width:SCREEN_WIDTH - W(30) ary:aryDateTypes];
                        listNew.alpha = 0;
                        [UIView animateWithDuration:0.3 animations:^{
                            listNew.alpha = 1;
                        }];
                        break;
                    }
                }
                listNew.blockSelected = ^(NSInteger index) {
                    weakSelf.modelLicenseType.subString = aryDateTypes[index];
                    weakSelf.modelLicenseType.identifier = [NSString stringWithFormat:@"%@", aryDateId[index]];
                    [weakSelf.tableView reloadData];
                };
            };
            
            return model;
        }();
    }
    return _modelLicenseType;
}

- (ModelBaseData *)modelAllQuality{
    if (!_modelAllQuality) {
        _modelAllQuality = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"车辆总质量";
            model.placeHolderString = @"输入车辆总质量（kg）";
            return model;
        }();
    }
    return _modelAllQuality;
}
- (ModelBaseData *)modelAxle{
    if (!_modelAxle) {
        _modelAxle = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"车轴数";
            model.placeHolderString = @"输入车轴数";
            return model;
        }();
    }
    return _modelAxle;
}
- (ModelBaseData *)modelHangCode{
    if (!_modelHangCode) {
        _modelHangCode = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"挂车号码";
            model.placeHolderString = @"输入挂车号码";
            WEAKSELF
            model.blocClick = ^(ModelBaseData *item) {
                [GlobalMethod endEditing];
                for (PerfectSelectCell * cell in weakSelf.tableView.visibleCells) {
                    if ([cell isKindOfClass:[PerfectSelectCell class]] && [cell.model.string isEqualToString: weakSelf.modelHangCode.string]) {
                        CGRect rectOrigin = [cell convertRect:cell.frame toView:[UIApplication sharedApplication].keyWindow];
                        if (CGRectGetMinY(rectOrigin)>SCREEN_HEIGHT/2.0) {
                            [weakSelf.tableView setContentOffset:CGPointMake(0, cell.top) animated:true];
                        }
                        break;
                    }
                }
                
                SelectCarNumberView * selectNumView = [SelectCarNumberView new];
                [selectNumView resetViewWithContent:weakSelf.modelHangCode.subString];
                [weakSelf.view addSubview:selectNumView];
                selectNumView.blockSelected = ^(NSString *str) {
                    weakSelf.modelHangCode.subString = str;
                    [weakSelf.tableView reloadData];
                };
            };
            return model;
        }();
    }
    return _modelHangCode;
}
- (ModelBaseData *)modelEngineCode{
    if (!_modelEngineCode) {
        _modelEngineCode = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"发动机号";
            model.placeHolderString = @"输入车辆发动机号";
            return model;
        }();
    }
    return _modelEngineCode;
}
- (ModelBaseData *)modelCarIdentityCode{
    if (!_modelCarIdentityCode) {
        _modelCarIdentityCode = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"识别代码";
            model.placeHolderString = @"输入车辆识别代码";
            return model;
        }();
    }
    return _modelCarIdentityCode;
}
- (ModelBaseData *)modelDriver{
    if (!_modelDriver) {
        WEAKSELF
        _modelDriver = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"关联司机";
            model.placeHolderString = @"选择关联司机";
            model.blocClick = ^(ModelBaseData *modelClick) {
                SelectDriverVC * selectVC = [SelectDriverVC new];
                selectVC.modelSelected = ^(){
                    ModelDriver * model = [ModelDriver new];
                    model.driverId = weakSelf.modelDriver.identifier.doubleValue;
                    return model.driverId?model:nil;
                }();
                selectVC.blockSelected = ^(ModelDriver *modelDriver) {
                    weakSelf.modelDriver.subString = modelDriver.driverName;
                    weakSelf.modelDriver.identifier = strDotF(modelDriver.driverId);
                    weakSelf.modelDriverPhone.subString = modelDriver.driverPhone;
                    [weakSelf configData];
                };
                [GB_Nav pushViewController:selectVC animated:true];
            };
            return model;
        }();
    }
    return _modelDriver;
}
- (ModelBaseData *)modelDriverPhone{
    if (!_modelDriverPhone) {
        _modelDriverPhone = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"司机电话";
            model.placeHolderString = @"输入司机电话";
            return model;
        }();
    }
    return _modelDriverPhone;
}
- (ModelBaseData *)modelVehicleLength{
    if (!_modelVehicleLength) {
        _modelVehicleLength = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"车长(mm)";
            model.placeHolderString = @"输入车辆长度";
            return model;
        }();
    }
    return _modelVehicleLength;
}
- (ModelBaseData *)modelVehicleWidth{
    if (!_modelVehicleWidth) {
        _modelVehicleWidth = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"车宽(mm)";
            model.placeHolderString = @"输入车辆宽度";
            return model;
        }();
    }
    return _modelVehicleWidth;
}
- (ModelBaseData *)modelVehicleHeight{
    if (!_modelVehicleHeight) {
        _modelVehicleHeight = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"车高(mm)";
            model.placeHolderString = @"输入车辆高度";
            return model;
        }();
    }
    return _modelVehicleHeight;
}
- (ModelBaseData *)modelDrivingNumber{
    if (!_modelDrivingNumber) {
        _modelDrivingNumber = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"档案编号";
            model.placeHolderString = @"输入档案编号";
            return model;
        }();
    }
    return _modelDrivingNumber;
}
- (ModelBaseData *)modelCarModel{
    if (!_modelCarModel) {
        _modelCarModel = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"品牌型号";
            model.placeHolderString = @"输入品牌型号";
            return model;
        }();
    }
    return _modelCarModel;
}
- (ModelBaseData *)modelUsage{
    if (!_modelUsage) {
        _modelUsage = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"使用性质";
            model.placeHolderString = @"输入使用性质";
            return model;
        }();
    }
    return _modelUsage;
}
- (ModelBaseData *)modelEnergyType{
    if (!_modelEnergyType) {
        _modelEnergyType = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"能源类型";
            model.placeHolderString = @"选择能源类型";
            WEAKSELF
            model.blocClick = ^(ModelBaseData *modelClick) {
                [GlobalMethod endEditing];
                ListAlertView * listNew = [ListAlertView new];
                NSString * strPath = [[NSBundle mainBundle]pathForResource:@"EnergyType" ofType:@"json"];
                NSArray * ary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:strPath] options:0 error:nil];
                NSMutableArray * aryDateTypes = [NSMutableArray array];
                NSMutableArray * aryDateId =[NSMutableArray array];
                for (NSDictionary * dic in ary) {
                    [aryDateTypes addObject:[dic stringValueForKey:@"label"]];
                    [aryDateId addObject:[dic numberValueForKey:@"value"]];
                }
                for (PerfectSelectCell * cell in weakSelf.tableView.visibleCells) {
                    if ([cell isKindOfClass:[PerfectSelectCell class]] && [cell.model.string isEqualToString: weakSelf.modelEnergyType.string]) {
                        [weakSelf.tableView setContentOffset:CGPointMake(0, cell.top) animated:true];
                        [listNew showWithPoint:CGPointMake(W(15), NAVIGATIONBAR_HEIGHT + cell.height)  width:SCREEN_WIDTH - W(30) ary:aryDateTypes];
                        listNew.alpha = 0;
                        [UIView animateWithDuration:0.3 animations:^{
                            listNew.alpha = 1;
                        }];
                        break;
                    }
                }
                listNew.blockSelected = ^(NSInteger index) {
                    weakSelf.modelEnergyType.subString = aryDateTypes[index];
                    weakSelf.modelEnergyType.identifier = [NSString stringWithFormat:@"%@", aryDateId[index]];
                    [weakSelf.tableView reloadData];
                };
            };
            return model;
        }();
    }
    return _modelEnergyType;
}
- (ModelBaseData *)modelRoadTransportNum{
    if (!_modelRoadTransportNum) {
        _modelRoadTransportNum = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"车辆道路运输证";
            model.placeHolderString = @"输入车辆道路运输证";
            return model;
        }();
    }
    return _modelRoadTransportNum;
}
- (ModelBaseData *)modelAgency{
    if (!_modelAgency) {
        _modelAgency = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"发证机关";
            model.placeHolderString = @"输入发证机关";
            return model;
        }();
    }
    return _modelAgency;
}
- (ModelBaseData *)modelDrivingResignDate{
    if (!_modelDrivingResignDate) {
        _modelDrivingResignDate = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"行驶证注册日期";
            model.placeHolderString = @"选择行驶证注册日期";
            WEAKSELF
            model.blocClick = ^(ModelBaseData *data) {
                [GlobalMethod endEditing];
                DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
                    weakSelf.modelDrivingResignDate.subString =  [GlobalMethod exchangeDate:date formatter:TIME_DAY_SHOW];
                    [weakSelf.tableView reloadData];
                } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
                [GB_Nav.lastVC.view addSubview:datePickerView];
            };
            return model;
        }();
    }
    return _modelDrivingResignDate;
}
- (ModelBaseData *)modelDrivingIssueDate{
    if (!_modelDrivingIssueDate) {
        _modelDrivingIssueDate = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"行驶证发证日期";
            model.placeHolderString = @"选择行驶证发证日期";
            WEAKSELF
            model.blocClick = ^(ModelBaseData *data) {
                [GlobalMethod endEditing];
                DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
                    weakSelf.modelDrivingIssueDate.subString =  [GlobalMethod exchangeDate:date formatter:TIME_DAY_SHOW];
                    [weakSelf.tableView reloadData];
                } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
                [GB_Nav.lastVC.view addSubview:datePickerView];
            };
            return model;
        }();
    }
    return _modelDrivingIssueDate;
}
- (ModelBaseData *)modelDrivingEndDate{
    if (!_modelDrivingEndDate) {
        _modelDrivingEndDate = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"行驶证有效日期";
            model.placeHolderString = @"选择行驶证有效日期";
            WEAKSELF
            model.blocClick = ^(ModelBaseData *data) {
                [GlobalMethod endEditing];
                DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
                    weakSelf.modelDrivingEndDate.subString =  [GlobalMethod exchangeDate:date formatter:TIME_DAY_SHOW];
                    [weakSelf.tableView reloadData];
                } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY];
                [GB_Nav.lastVC.view addSubview:datePickerView];
            };
            return model;
        }();
    }
    return _modelDrivingEndDate;
}
- (AuthorityImageView *)bottomView{
    if (!_bottomView) {
        _bottomView = [AuthorityImageView new];
        [self refreshBottomView:nil];
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
    self.subTitleInterval = W(135);
    
    //config data
    [self configData];
    //add keyboard observe
    [self addObserveOfKeyboard];
    //request
    [self requestDetail];
    //configImage
    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    BaseNavView *nav = [BaseNavView initNavBackTitle:self.carID?@"编辑车辆":@"添加车辆" rightTitle:@"提交" rightBlock:^{
        [weakSelf requestAdd];
    }];
    [nav configBlackBackStyle];
    [self.view addSubview:nav];
}

#pragma mark config data
- (void)configData{
    self.aryDatas = @[self.modelUnbindDriver,self.modelCarNum,self.modelOwner,self.modelVehicleType,self.modelVehicleLoad,self.modelLicenseType,self.modelDrivingNumber,self.modelAllQuality,self.modelAxle,self.modelHangCode,self.modelEngineCode,self.modelCarIdentityCode,self.modelDriver,self.modelDriverPhone,self.modelVehicleLength,self.modelVehicleWidth,self.modelVehicleHeight,self.modelCarModel,self.modelUsage,self.modelEnergyType,self.modelRoadTransportNum,self.modelAgency,self.modelDrivingResignDate,self.modelDrivingIssueDate,self.modelDrivingEndDate,^(){
        ModelBaseData * model = [ModelBaseData new];
        model.enumType = ENUM_PERFECT_CELL_EMPTY;
        model.imageName = @"";
        model.string = @"认证资料";
        model.isSelected = true;
        model.blocClick = ^(ModelBaseData *item) {
            AuthortiyExampleVC * vc = [AuthortiyExampleVC new];
            vc.aryDatas =@[^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"行驶证主页示例";
                model.imageName = @"行驶证正";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"行驶证副页示例";
                model.imageName = @"行驶证反";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"车辆交强险保单示例";
                model.imageName = @"交强险保单";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"车辆三者险保单示例";
                model.imageName = @"三者险保单";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"挂车交强险保单示例";
                model.imageName = @"挂车交强险保单";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"挂车三者险保单示例";
                model.imageName = @"挂车三者险保单";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"挂车箱货险保单示例";
                model.imageName = @"挂车箱货险保单";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"道路运输经营许可证示例";
                model.imageName = @"运输许可证";
                return model;
            }(),^(){
                ModelBaseData * model = [ModelBaseData new];
                model.string = @"行驶证检验页示例";
                model.imageName = @"检验页";
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
    ModelImage * mod3 = [self.bottomView.aryDatas objectAtIndex:3];
    ModelImage * mod4 = [self.bottomView.aryDatas objectAtIndex:4];
    ModelImage * mod5 = [self.bottomView.aryDatas objectAtIndex:5];
    ModelImage * mod6 = [self.bottomView.aryDatas objectAtIndex:6];
    ModelImage * mod7 = [self.bottomView.aryDatas objectAtIndex:7];
    ModelImage * mod9 = [self.bottomView.aryDatas objectAtIndex:9];
    ModelImage * mod8 = [self.bottomView.aryDatas objectAtIndex:8];

    if (!isStr(model0.image.imageURL)) {
        [GlobalMethod showAlert:@"请添加行驶证主页"];
        return;
    }
    if (!isStr(model1.image.imageURL)) {
           [GlobalMethod showAlert:@"请添加行驶证副页"];
           return;
       }
    if (!isStr(model2.image.imageURL)) {
           [GlobalMethod showAlert:@"请添加行驶证机动车相片页"];
           return;
       }
    if (!isStr(mod3.image.imageURL)) {
           [GlobalMethod showAlert:@"请添加行驶证检验页"];
           return;
       }
    self.modelCarNum.subString = self.modelCarNum.subString.uppercaseString;
    [RequestApi requestAddCarWithVin:self.modelCarIdentityCode.subString
                        engineNumber:self.modelEngineCode.subString
                       vehicleNumber:self.modelCarNum.subString
                         licenceType:self.modelLicenseType.identifier.doubleValue
                       trailerNumber:self.modelHangCode.subString
                      vehicleLicense:nil
                       vehicleLength:self.modelVehicleLength.identifier.doubleValue
                         vehicleType:self.modelVehicleType.identifier.doubleValue
                         vehicleLoad:self.modelVehicleLoad.subString.doubleValue
                                axle:self.modelAxle.subString.doubleValue
                        vehicleOwner:self.modelOwner.subString
              drivingLicenseFrontUrl:UnPackStr(model0.image.imageURL)
           drivingLicenseNegativeUrl:UnPackStr(model1.image.imageURL)
                 vehicleInsuranceUrl:UnPackStr(mod8.image.imageURL)
       vehicleTripartiteInsuranceUrl:UnPackStr(mod4.image.imageURL)
                 trailerInsuranceUrl:UnPackStr(mod5.image.imageURL)
       trailerTripartiteInsuranceUrl:UnPackStr(mod6.image.imageURL)
            trailerGoodsInsuranceUrl:UnPackStr(mod7.image.imageURL)
                     vehiclePhotoUrl:UnPackStr(model2.image.imageURL)
                managementLicenseUrl:UnPackStr(mod9.image.imageURL)
                              length:self.modelVehicleLength.subString.doubleValue
                              weight:self.modelVehicleWidth.subString.doubleValue
                              height:self.modelVehicleHeight.subString.doubleValue
                           grossMass:self.modelAllQuality.subString.doubleValue
                       drivingNumber:self.modelDrivingNumber.subString
                               model:self.modelCarModel.subString
                        useCharacter:self.modelUsage.subString
                          energyType:self.modelEnergyType.identifier.doubleValue
                 roadTransportNumber:self.modelRoadTransportNum.subString
                       drivingAgency:self.modelAgency.subString
                 drivingRegisterDate:isStr(self.modelDrivingResignDate.subString)?[GlobalMethod exchangeStringToDate:self.modelDrivingResignDate.subString formatter:TIME_DAY_SHOW].timeIntervalSince1970:0
                    drivingIssueDate:isStr(self.modelDrivingIssueDate.subString)?[GlobalMethod exchangeStringToDate:self.modelDrivingIssueDate.subString formatter:TIME_DAY_SHOW].timeIntervalSince1970:0
                      drivingEndDate:isStr(self.modelDrivingEndDate.subString)?[GlobalMethod exchangeStringToDate:self.modelDrivingEndDate.subString formatter:TIME_DAY_SHOW].timeIntervalSince1970:0
                 driving2NegativeUrl:UnPackStr(mod3.image.imageURL)
                            identity:self.carID
                               entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty
                            driverId:self.modelDriver.identifier.doubleValue
                         driverPhone:self.modelDriverPhone.subString
                            delegate:self
                             success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"提交成功"];
        self.requestState = 1;
        [GB_Nav popViewControllerAnimated:true];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}

- (void)requestDetail{
    if (!self.carID) {
        return;
    }
    [RequestApi requestCarDetailWithId:self.carID entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelCar * modelDetail = [ModelCar modelObjectWithDictionary:response];
        self.modelDetail = modelDetail;
        
        [self refreshBottomView:modelDetail];
        //config info
        //change invalid
        self.modelCarNum.subString = modelDetail.vehicleNumber;
        self.modelCarNum.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        
        self.modelOwner.subString = modelDetail.vehicleOwner;
        self.modelOwner.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        
        self.modelDrivingNumber.subString = modelDetail.drivingNumber;
        
        //转化车辆类型
        self.modelVehicleType.identifier = NSNumber.dou(modelDetail.vehicleType).stringValue;
        self.modelVehicleType.subString = [AddCarVC exchangeVehicleType:self.modelVehicleType.identifier];
        self.modelVehicleType.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        
        //解绑司机
        WEAKSELF
        self.modelUnbindDriver.isSelected = modelDetail.driverId;
        self.modelUnbindDriver.blocClick = modelDetail.driverId?^(ModelBaseData *m) {
            ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
            ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
            modelConfirm.blockClick = ^(void){
                weakSelf.modelDriver.subString = nil;
                weakSelf.modelDriver.identifier = 0;
                weakSelf.modelDriverPhone.subString = nil;
                [weakSelf configData];
                [weakSelf requestAdd];
            };
            [BaseAlertView initWithTitle:@"提示" content:@"确认解绑司机？" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:weakSelf.view];
        }:nil;
        
        self.modelLicenseType.subString = [AddCarVC exchangeLicenseType:NSNumber.dou(modelDetail.licenceType).stringValue];
        self.modelLicenseType.identifier = NSNumber.dou(modelDetail.licenceType).stringValue;
        
        self.modelAllQuality.subString = NSNumber.dou(modelDetail.grossMass).stringValue;
        
        self.modelHangCode.subString = modelDetail.trailerNumber;
        
        self.modelDriver.subString = modelDetail.driverName;
        self.modelDriver.identifier = modelDetail.driverId?strDotF(modelDetail.driverId):nil;
        
        self.modelDriverPhone.subString = modelDetail.driverPhone;
        self.modelCarIdentityCode.subString = modelDetail.vin;
        self.modelEngineCode.subString = modelDetail.engineNumber;
        self.modelVehicleLoad.subString = modelDetail.vehicleLoad? strDotF(modelDetail.vehicleLoad):nil;
        self.modelAxle.subString = modelDetail.axle?NSNumber.dou(modelDetail.axle).stringValue:nil;
        self.modelVehicleLength.subString = NSNumber.dou(modelDetail.length).stringValue;
        self.modelVehicleWidth.subString = NSNumber.dou(modelDetail.weight).stringValue;
        self.modelVehicleHeight.subString = NSNumber.dou(modelDetail.height).stringValue;
        self.modelCarModel.subString = modelDetail.model;
        self.modelUsage.subString = modelDetail.useCharacter;
        self.modelEnergyType.subString = [AddCarVC exchangeEnergeyType:NSNumber.dou(modelDetail.energyType).stringValue];
        self.modelEnergyType.identifier = NSNumber.dou(modelDetail.energyType).stringValue;
        self.modelRoadTransportNum.subString = modelDetail.roadTransportNumber;
        self.modelAgency.subString = modelDetail.drivingAgency;
        self.modelDrivingResignDate.subString = modelDetail.drivingRegisterDate?[GlobalMethod exchangeDate:[NSDate dateWithTimeIntervalSince1970:modelDetail.drivingRegisterDate] formatter:TIME_DAY_SHOW]:nil;
        self.modelDrivingIssueDate.subString = modelDetail.drivingIssueDate?[GlobalMethod exchangeDate:[NSDate dateWithTimeIntervalSince1970:modelDetail.drivingIssueDate] formatter:TIME_DAY_SHOW]:nil;
        self.modelDrivingEndDate.subString = modelDetail.drivingEndDate?[GlobalMethod exchangeDate:[NSDate dateWithTimeIntervalSince1970:modelDetail.drivingEndDate] formatter:TIME_DAY_SHOW]:nil;
        
        
        [self configData];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)refreshBottomView:(ModelCar *)modelDetail{
//    WEAKSELF
    [self.bottomView resetViewWithAryModels:@[^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"添加行驶证主页";
        model.url = modelDetail.drivingLicenseFrontUrl;
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_行驶证正"] url:[NSURL URLWithString:model.url]];
        model.isEssential = true;
        model.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
        model.cameraType = ENUM_CAMERA_ROAD;
        return model;
    }(),^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"添加行驶证副页";
        model.isEssential = true;
        model.url = modelDetail.drivingLicenseNegativeUrl;
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_行驶证反"] url:[NSURL URLWithString:model.url]];
        model.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
        return model;
    }(),^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"添加行驶证机动车相片页";
        model.url = modelDetail.vehiclePhotoUrl;
        model.isEssential = true;
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_车辆照片"] url:[NSURL URLWithString:model.url]];
        model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
        return model;
    }(),^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"行驶证检验页";
        model.url = modelDetail.driving2NegativeUrl;
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_检验页"] url:[NSURL URLWithString:model.url]];
        model.isEssential = true;
        model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
        model.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        return model;
    }(),^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"添加车辆三者险保单";
        model.url = modelDetail.vehicleTripartiteInsuranceUrl;
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_交强险保单"] url:[NSURL URLWithString:model.url]];
        model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
        return model;
    }(),^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"添加挂车交强险保单";
        model.url = modelDetail.trailerInsuranceUrl;
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_交强险保单"] url:[NSURL URLWithString:model.url]];
        model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
        return model;
    }(),^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"添加挂车三者险保单";
        model.url = modelDetail.trailerTripartiteInsuranceUrl;
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_交强险保单"] url:[NSURL URLWithString:model.url]];
        model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
        return model;
    }(),^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"添加挂车箱货险保单";
        model.url = modelDetail.trailerGoodsInsuranceUrl;
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_交强险保单"] url:[NSURL URLWithString:model.url]];
        model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
        return model;
    }(),^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"添加车辆交强险保单";
        model.url = modelDetail.vehicleInsuranceUrl;
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_交强险保单"] url:[NSURL URLWithString:model.url]];
        model.isChangeInvalid = modelDetail.isAuthorityAcceptOrAuthering;
        model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
        return model;
    }(),^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"添加道路运输许可证";
        model.url = modelDetail.managementLicenseUrl;
        model.image = [BaseImage imageWithImage:[UIImage imageNamed:@"camera_运输许可证"] url:[NSURL URLWithString:model.url]];
        model.imageType = ENUM_UP_IMAGE_TYPE_COMPANY_CAR;
        return model;
    }()]];
}
#pragma mark exchange type
+ (NSString *)exchangeVehicleType:(NSString *)identity{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:@"CarType" ofType:@"json"];
    NSArray * ary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:strPath] options:0 error:nil];
    for (NSDictionary * dic in ary) {
        if (identity.doubleValue == [dic doubleValueForKey:@"value"]) {
            return [dic stringValueForKey:@"label"];
        }
    }
    return nil;
}
+ (NSString *)exchangeLicenseType:(NSString *)identity{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:@"LicenseType" ofType:@"json"];
    NSArray * ary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:strPath] options:0 error:nil];
    for (NSDictionary * dic in ary) {
        if (identity.doubleValue == [dic doubleValueForKey:@"value"]) {
            return [dic stringValueForKey:@"label"];
        }
    }
    return nil;
}
+ (NSString *)exchangeEnergeyType:(NSString *)identity{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:@"EnergyType" ofType:@"json"];
    NSArray * ary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:strPath] options:0 error:nil];
    for (NSDictionary * dic in ary) {
        if (identity.doubleValue == [dic doubleValueForKey:@"value"]) {
            return [dic stringValueForKey:@"label"];
        }
    }
    return nil;
}

@end
