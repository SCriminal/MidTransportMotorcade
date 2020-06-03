//
//  AttachDetailVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/12/3.
//Copyright © 2019 ping. All rights reserved.
//

#import "AttachDetailVC.h"
//detail view
#import "AttachDetailView.h"
//cancel view
#import "CancelAttachView.h"
//request
#import "RequestApi+Company.h"

@interface AttachDetailVC ()
@property (nonatomic, strong) AttachDetailView  *topView;
@property (nonatomic, strong) AttachDetailImageView *bottomView;
@property (nonatomic, strong) AttachDetailBottomView *btnView;

@end

@implementation AttachDetailVC

- (AttachDetailBottomView *)btnView{
    if (!_btnView) {
        _btnView = [AttachDetailBottomView new];
        [_btnView resetViewWithModel:self.modelAttach];
        _btnView.bottom  = SCREEN_HEIGHT;
        WEAKSELF
        _btnView.blockCancel = ^{
            [weakSelf cancelClick];
        };
        _btnView.blockAgree = ^{
            [weakSelf admitClick];

        };
        _btnView.blockReject = ^{
            [weakSelf rejectClick];

        };
    }
    return _btnView;
}
- (AttachDetailView *)topView{
    if (!_topView) {
        _topView = [AttachDetailView new];
    }
    return _topView;
}
- (AttachDetailImageView *)bottomView{
    if (!_bottomView) {
        _bottomView = [AttachDetailImageView new];
        
    }
    return _bottomView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.topView resetViewWithModel:self.modelAttach];
    self.tableView.tableHeaderView = self.topView;

    [self.view addSubview:self.btnView];
    self.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.btnView.height;
    //request
    [self requestInfo];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"挂靠详情" rightView:nil]];
}

#pragma mark request
- (void)requestInfo{
    if (self.modelAttach.state == 10) {

        [RequestApi requestDriveFileListPassWithDriverId:self.modelAttach.iDProperty
                                                   entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty
                                                delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                                                    if (!isDic(response)) {
                                                        return ;
                                                    }
                                                    self.tableView.tableHeaderView = self.topView;
                                                    
                                                    [self.bottomView resetViewWithAryModels:@[^(){
                                                        ModelImage * model = [ModelImage new];
                                                        model.desc = @"身份证人像面";
                                                        model.url = [response stringValueForKey:@"idCardFrontUrl"];
                                                        model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
                                                        model.isEssential = true;
                                                        model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
                                                        return model;
                                                    }(),^(){
                                                        ModelImage * model = [ModelImage new];
                                                        model.desc = @"身份证国徽面";
                                                        model.url = [response stringValueForKey:@"idCardBackUrl"];
                                                        model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
                                                        model.isEssential = true;
                                                        model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
                                                        return model;
                                                    }(),^(){
                                                        ModelImage * model = [ModelImage new];
                                                        model.desc = @"手持身份证人像面";
                                                        model.url = [response stringValueForKey:@"idCardHandelUrl"];
                                                        model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
                                                        model.isEssential = true;
                                                        model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
                                                        return model;
                                                    }(),^(){
                                                        ModelImage * model = [ModelImage new];
                                                        model.desc = @"驾驶证";
                                                        model.url = [response stringValueForKey:@"driverLicenseUrl"];
                                                        model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
                                                        model.isEssential = true;
                                                        model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
                                                        return model;
                                                    }()]];
                                                    self.tableView.tableFooterView = self.bottomView;
                                                    
                                                    
                                                } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                                                    
                                                }];
    }else{
        [RequestApi requestAttachInfoWithId:self.modelAttach.iDProperty entId:self.modelAttach.entId delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            if (!isDic(response)) {
                return ;
            }
            self.tableView.tableHeaderView = self.topView;
            
            [self.bottomView resetViewWithAryModels:@[^(){
                ModelImage * model = [ModelImage new];
                model.desc = @"身份证人像面";
                model.url = [response stringValueForKey:@"idCardFrontUrl"];
                model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
                model.isEssential = true;
                model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
                return model;
            }(),^(){
                ModelImage * model = [ModelImage new];
                model.desc = @"身份证国徽面";
                model.url = [response stringValueForKey:@"idCardBackUrl"];
                model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
                model.isEssential = true;
                model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
                return model;
            }(),^(){
                ModelImage * model = [ModelImage new];
                model.desc = @"手持身份证人像面";
                model.url = [response stringValueForKey:@"idCardHandelUrl"];
                model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
                model.isEssential = true;
                model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
                return model;
            }(),^(){
                ModelImage * model = [ModelImage new];
                model.desc = @"驾驶证";
                model.url = [response stringValueForKey:@"driverLicenseUrl"];
                model.image = [BaseImage imageWithImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT] url:[NSURL URLWithString:model.url]];
                model.isEssential = true;
                model.imageType = ENUM_UP_IMAGE_TYPE_USER_AUTHORITY;
                return model;
            }()]];
            self.tableView.tableFooterView = self.bottomView;
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }
}

- (void)cancelClick{
    WEAKSELF
    CancelAttachView * cancelView = [CancelAttachView new];
    cancelView.blockComplete = ^(NSString *reason) {
        [weakSelf requestCancel:reason];
    };
    [cancelView show];
}
- (void)rejectClick{
    WEAKSELF
    CancelAttachView * cancelView = [CancelAttachView new];
    cancelView.labelTitle.text = @"拒绝挂靠";
    cancelView.blockComplete = ^(NSString *reason) {
        [weakSelf requestReject:reason];
    };
    [cancelView show];
}
- (void)admitClick{
    WEAKSELF
    ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_333];
    ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"同意" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_BLUE];
    modelConfirm.blockClick = ^(void){
        [weakSelf requestAgree];
    };
    [BaseAlertView initWithTitle:@"提示" content:@"是否同意司机挂靠？" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:[UIApplication sharedApplication].keyWindow];
}

- (void)requestCancel:(NSString *)reason{
    [RequestApi requestCancelAttachedDriverWithId:self.modelAttach.iDProperty entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty reason:reason delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.requestState = 1;
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestAgree{
    [RequestApi requestAdmitAttachApplyWithEntid:self.modelAttach.entId ids:strDotF(self.modelAttach.iDProperty) reason:@"" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.requestState = 1;
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestReject:(NSString *)reason{
    [RequestApi requestRejectAttachApplyWithEntid:self.modelAttach.entId ids:strDotF(self.modelAttach.iDProperty) reason:reason delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.requestState = 1;
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

@end
