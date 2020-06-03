//
//  OrderDetailVC.m
//中车运
//
//  Created by 隋林栋 on 2018/10/19.
//Copyright © 2018年 ping. All rights reserved.
//

#import "OrderDetailVC.h"
//nav
#import "BaseNavView+Logical.h"
//sub view
#import "OrderDetailTopView.h"
#import "OrderDetailAccessoryView.h"
//request
#import "RequestApi+Order.h"
//package view
#import "OrderDetailPackageView.h"
//share
#import "ShareView.h"
//inputView
#import "InputNumView.h"
#import "InputPlumbumNumView.h"
//image select
#import "BaseVC+BaseImageSelectVC.h"
//upimage
#import "AliClient.h"

@interface OrderDetailVC ()
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) OrderDetailTopView *topView;
@property (nonatomic, strong) OrderDetailStatusView *statusView;
@property (nonatomic, strong) OrderDetailLoadView *loadInfoView;
@property (nonatomic, strong) OrderDetailStationView *stationView;
@property (nonatomic, strong) OrderDetailPackageView *packageView;
@property (nonatomic, strong) OrderDetailPathView *pathView;
@property (nonatomic, strong) OrderDetailRemarkView *remarkView;
@property (nonatomic, strong) NSArray *aryGoodsList;
@property (nonatomic, strong) OrderDetailAccessoryView *accessoryView;
//input view
@property (nonatomic, strong) InputNumView *inputPackageNoView;
@property (nonatomic, strong) InputPlumbumNumView *inputPlumbumNumView;
@property (nonatomic, assign) BOOL isInputSealNum;
@property (nonatomic, strong) ModelPackageInfo *packageInfoSelected;


@end

@implementation OrderDetailVC

#pragma mark lazy init
- (BaseNavView *)nav{
    if (!_nav) {
        WEAKSELF
        _nav = [BaseNavView initNavBackWithTitle:@"运单详情" rightImageName:@"share_white" rightImageSize:CGSizeMake(W(25), W(25)) righBlock:^{
            [ShareView show:weakSelf.modelOrder];
        }];
        _nav.line.hidden = true;
        [_nav configBlackBackStyle];
    }
    return _nav;
}

- (OrderDetailTopView *)topView{
    if (!_topView) {
        _topView = [OrderDetailTopView new];
        [_topView resetViewWithModel:self.modelOrder];
        _topView.topToUpView = W(15);
    }
    return _topView;
}
- (OrderDetailRemarkView *)remarkView{
    if (!_remarkView) {
        _remarkView = [OrderDetailRemarkView new];
        _remarkView.topToUpView = W(15);
        [_remarkView resetViewWithModel:self.modelOrder];
        
    }
    return _remarkView;
}
- (OrderDetailStatusView *)statusView{
    if (!_statusView) {
        _statusView = [OrderDetailStatusView new];
        _statusView.topToUpView = W(15);
    }
    return _statusView;
}

- (OrderDetailLoadView *)loadInfoView{
    if (!_loadInfoView) {
        _loadInfoView = [OrderDetailLoadView new];
        [_loadInfoView resetViewWithModel:self.modelOrder];
        _loadInfoView.topToUpView = W(15);
    }
    return _loadInfoView;
}
- (OrderDetailStationView *)stationView{
    if (!_stationView) {
        _stationView = [OrderDetailStationView new];
        [_stationView resetViewWithModel:self.modelOrder];
        _stationView.topToUpView = W(15);
    }
    return _stationView;
}
- (OrderDetailPackageView *)packageView{
    if (!_packageView) {
        _packageView = [OrderDetailPackageView new];
        _packageView.modelOrder = self.modelOrder;
        _packageView.topToUpView = W(15);
        WEAKSELF
        _packageView.blockInputNum = ^(ModelPackageInfo *modelPackage, BOOL isNum) {
            weakSelf.packageInfoSelected = modelPackage;
            if (isNum) {
                if (modelPackage.cargoState == 7 ||modelPackage.cargoState == 8||modelPackage.cargoState == 9) {
                    [weakSelf.inputPackageNoView showWithAry:@[modelPackage]];
                    return ;
                }
                [GlobalMethod showAlert:@"当前状态不可录入箱号"];
            }else{
                if (modelPackage.cargoState == 7 ||modelPackage.cargoState == 8||modelPackage.cargoState == 9) {
                    [weakSelf.inputPlumbumNumView showWithAry:@[modelPackage]];
                    return ;
                }
                [GlobalMethod showAlert:@"当前状态不可录入铅封号"];
            }
        };
       
    }
    return _packageView;
}
- (OrderDetailPathView *)pathView{
    if (!_pathView) {
        _pathView = [OrderDetailPathView new];
        [_pathView resetViewWithModel:self.modelOrder];
        _pathView.topToUpView = W(15);
    }
    return _pathView;
}
- (OrderDetailAccessoryView *)accessoryView{
    if (!_accessoryView) {
        _accessoryView = [OrderDetailAccessoryView new];
        _accessoryView.topToUpView = W(15);
    }
    return _accessoryView;
}
- (InputNumView *)inputPackageNoView{
    if (!_inputPackageNoView) {
        _inputPackageNoView = [InputNumView new];
        WEAKSELF
        _inputPackageNoView.blockComplete = ^(ModelPackageInfo * modelSelected) {
            [weakSelf reqeustInputPackageNum:modelSelected];
        };
        _inputPackageNoView.blockORCClick = ^{
            weakSelf.isInputSealNum = false;
            [weakSelf showImageVC:1];
        };
    }
    return _inputPackageNoView;
}
- (InputPlumbumNumView *)inputPlumbumNumView{
    if (!_inputPlumbumNumView) {
        _inputPlumbumNumView = [InputPlumbumNumView new];
        WEAKSELF
        _inputPlumbumNumView.blockComplete = ^(ModelPackageInfo * modelSelected) {
            [weakSelf reqeustInputPackageNum:modelSelected];
        };
        _inputPlumbumNumView.blockORCClick = ^{
            weakSelf.isInputSealNum = true;
            [weakSelf showImageVC:1];
        };
    }
    return _inputPlumbumNumView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableBackgroundView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self reconfigTableHeaderView];
    self.tableView.tableFooterView = ^(){
        UIView * view = [UIView new];
        view.height = W(20);
        view.backgroundColor = [UIColor clearColor];
        return view;
    }();
    [self addRefreshHeader];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:self.nav];
}
#pragma mark refresh table header view
- (void)reconfigTableHeaderView{
    self.tableView.tableHeaderView = [UIView initWithViews:@[self.topView,self.pathView,self.loadInfoView,isAry(self.statusView.aryDatas)?self.statusView:[NSNull null],self.stationView,isStr(self.modelOrder.iDPropertyDescription)?self.remarkView:[NSNull null],isAry(self.accessoryView.aryDatas)?self.accessoryView:[NSNull null],self.packageView]];


}
#pragma mark request
- (void)requestPackageInfo{
    [RequestApi requestGoosListWithId:self.modelOrder.iDProperty entID:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.aryGoodsList = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelPackageInfo"];
        [self.packageView resetViewWithAry:self.aryGoodsList];
        [self reconfigTableHeaderView];
        [self requestTimeAxle];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    } ];
}
- (void)requestTimeAxle{
    [RequestApi requestOrderTimeAxleWithFormid:self.modelOrder.iDProperty entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelOrderOperateTimeItem"];
        [self.statusView resetViewWithAry:ary];
        [self reconfigTableHeaderView];
        [self requestAccessory];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestAccessory{
    [RequestApi requestAccessoryListWithFormid:self.modelOrder.iDProperty formType:0 entId:self.modelOrder.shipperId delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelAccessoryItem"];
        [self.accessoryView resetViewWithAry:ary modelOrder:self.modelOrder];
        [self reconfigTableHeaderView];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestList{
    [RequestApi requestOrderDetailWithId:self.modelOrder.iDProperty entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelOrder = [ModelOrderList modelObjectWithDictionary:response];
        [self.topView resetViewWithModel:self.modelOrder];
        [self.loadInfoView resetViewWithModel:self.modelOrder];
        [self.stationView resetViewWithModel:self.modelOrder];
        self.packageView.modelOrder = self.modelOrder;
        [self.pathView resetViewWithModel:self.modelOrder];
        [self.remarkView resetViewWithModel:self.modelOrder];

        [self reconfigTableHeaderView];
        
        [self requestPackageInfo];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)reqeustInputPackageNum:(ModelPackageInfo *)modelPackage{
    [RequestApi requestInputPackageNumWithWaybillcargoid:modelPackage.cargoId containerNumber:modelPackage.containerNumber sealNumber:modelPackage.sealNumber entId:[GlobalData sharedInstance].GB_CompanyModel.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"上传成功"];
        [self requestPackageInfo];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
#pragma mark image select
- (void)imageSelect:(BaseImage *)image{
    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_ORDER;
    [[AliClient sharedInstance]updateImageAry:@[image] storageSuccess:^{
        
    } upSuccess:^{
        //        [self orc:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1560938536783&di=8b92560c9e218d67534a9cb75e360676&imgtype=0&src=http%3A%2F%2Fen.pan-asia.hk%2Fimages%2Fershou%2FSAM_1035_big.jpg"];
        [self orc:image.imageURL];
    } fail:^{
        
    }];
}

- (void)orc:(NSString *)imageurl{
    //    [GB_Nav pushVCName:@"MainBlackVC" animated:true];
    NSString *appcode = @"e5125b82866442b8ab5ecaa2a6caa89f";
    NSString *host = @"https://ocrapi-advanced.taobao.com";
    NSString *path = @"/ocrservice/advanced";
    NSString *method = @"POST";
    NSString *querys = @"";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = [NSString stringWithFormat:@"{\"url\":\"%@\",\"prob\":false,\"charInfo\":false,\"rotate\":false,\"table\":false}",imageurl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    //根据API的要求，定义相对应的Content-Type
    [request addValue: @"application/json; charset=UTF-8" forHTTPHeaderField: @"Content-Type"];
    NSData *data = [bodys dataUsingEncoding: NSUTF8StringEncoding];
    [request setHTTPBody: data];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       
                                                       NSLog(@"Response object: %@" , response);
                                                       NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                                       NSDictionary * dic = [GlobalMethod exchangeStringToDic:bodyString];
                                                       NSArray * aryAll = [dic arrayValueForKey:@"prism_wordsInfo"];
                                                       NSMutableArray * aryStrings = [NSMutableArray array];
                                                       NSString * strReturn = nil;
                                                       for (NSDictionary * dicWord in aryAll) {
                                                           NSString * strWord = [dicWord stringValueForKey:@"word"];
                                                           if (isStr(strWord)&& strWord.length > 3) {
                                                               strReturn = strWord;
                                                               break;
                                                           }
                                                           if ([aryAll indexOfObject:dicWord]<5) {
                                                               [aryStrings addObject:strWord];
                                                           }
                                                       }
                                                       if (!isStr(strReturn)) {
                                                           strReturn = [aryStrings componentsJoinedByString:@""];
                                                       }
                                                       if (isStr(strReturn)) {
                                                           [GlobalMethod mainQueueBlock:^{
                                                               if (self.isInputSealNum) {
                                                                   self.inputPlumbumNumView.tfNum.text = strReturn;
                                                               }else{
                                                                   self.inputPackageNoView.tfNum.text = strReturn;
                                                               }
                                                           }];
                                                       }else{
                                                           [GlobalMethod mainQueueBlock:^{
                                                               [GlobalMethod showAlert:@"图片解析失败"];
                                                           }];
                                                       }
                                                   }];
    [task resume];
    
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    NSURLCredential *card = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential,card);
}

#pragma mark statust bar
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
