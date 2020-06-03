//
//  GlobalMethod+Version.m
//中车运
//
//  Created by 隋林栋 on 2016/12/15.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "GlobalMethod+Version.h"
//登陆vc
#import "LoginViewController.h"

//tabvc
#import "CustomTabBarController.h"
//window
#import "AppDelegate.h"
//baseNav
#import "BaseNavController.h"
//公共方法
#import "GlobalMethod+Data.h"
//slider vc
#import "IIViewDeckController.h"
//order detail
#import "OrderDetailVC.h"
#import "OrderListManagementVC.h"
//guide view
#import "GuideView.h"
//request company
#import "RequestApi+Company.h"
//select motorcade
#import "ManageMotorcadeVC.h"


@implementation GlobalMethod (Version)


//注销
+ (void)logoutSuccess{
    //logout
    
    [self requestUnBindDeviceToken];
    //清空数据
    [self clearUserInfo];
    //重置根视图
    [self createRootNav];
}

//清除全局数据
+ (void)clearUserInfo{
    //clear user default
    [self clearUserDefault];
    //clear  user global data
    GlobalData * gbData = [GlobalData sharedInstance];
    gbData.GB_UserModel = nil;
    gbData.GB_Key = nil;
    gbData.GB_CompanyModel = nil;
}

//登录
+ (void)requestLoginResponse:(NSDictionary *)response
                    delegate:(id)delegate
                        mark:(id)mark
                     success:(void (^)(NSDictionary * response, id mark))success
                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSString * strToken = [response stringValueForKey:@"token"];
    if (isStr(strToken)) {
        [GlobalData sharedInstance].GB_Key = strToken;
    }
    [GlobalData sharedInstance].GB_UserModel = [ModelUser modelObjectWithDictionary:response];
    [GlobalMethod requestBindDeviceToken];
    [GlobalMethod requestPackageType];
    [RequestApi requestCompanyListWithDelegate:delegate success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * aryResponse = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelCompanyList"];
        if (!isAry(aryResponse)) {
            [GB_Nav pushVCName:@"SelectCompanyTypeVC" animated:true];
        }else if(aryResponse.count == 1){
            ModelCompanyList * modelLast = aryResponse.lastObject;
            [RequestApi requestCompanyDetailWithId:modelLast.entId delegate:delegate success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
                [GlobalData sharedInstance].GB_CompanyModel = [GlobalMethod exchangeDicToModel:response modelName:@"ModelCompany"];
                if (success) {
                    success(response,mark);
                }
            } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
                
            }];
        }else{
            ManageMotorcadeVC * selectVC = [ManageMotorcadeVC new];
            selectVC.aryCompanyModels = aryResponse.mutableCopy;
            [GB_Nav pushViewController:selectVC animated:true];
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}


+ (void)relogin{
    //重新登陆
    if (![GlobalData sharedInstance].isLoginAnimation ) {
        [GlobalData sharedInstance].isLoginAnimation = true;
        [GlobalMethod clearUserInfo];
        [GlobalMethod showAlert:@"登陆已过期，请重新登陆"];
        if ([GB_Nav hasClass:@"LoginViewController"]) {
            [GB_Nav popToClass:@"LoginViewController"];
        }else{
            [GlobalMethod createRootNav];
        }
        [GlobalData sharedInstance].isLoginAnimation = false;
    }
}


//创建rootNav
+ (void)createRootNav{
    BaseNavController * navMain = [[BaseNavController alloc]initWithRootViewController:[CustomTabBarController new]];
    navMain.navigationBarHidden = YES;
    GB_Nav = navMain;
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [UIApplication sharedApplication].idleTimerDisabled=true;
    if (!window) {
        window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    window.rootViewController = GB_Nav;
    [window setBackgroundColor:[UIColor clearColor]];
    [window makeKeyAndVisible];

    AppDelegate * delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    delegate.window = window;
    //判断是否需要登陆
    if (![self isLoginSuccess]) {
        [GB_Nav pushViewController:[LoginViewController new] animated:false];
    }

    
    //显示广告页
    if (![GlobalMethod readBoolLocal:LOCAL_SHOWED_GUIDE_BEFORE exchangeKey:false]) {
        GuideView * guideView = [GuideView new];
        [guideView show];
        //第一次
        [GlobalMethod writeBool:true local:LOCAL_SHOWED_GUIDE_BEFORE exchangeKey:false];
    }

    //请求版本
    [GlobalMethod requestVersion:nil];
    //sld_test
#ifdef SLD_TEST
    [GB_Nav pushVCName:@"TestVC" animated:false];
#endif
}

//刷新tableviewVC
+ (void)refreshTabelVCWithView:(UIView *)view {
    BaseTableVC *vc= (BaseTableVC *)[view fetchVC];
    if (vc != nil && [vc isKindOfClass:[BaseTableVC class]]) {
        [vc.tableView reloadData];
    }
}


//是否可以侧滑
+ (BOOL)canLeftSlide{
    if (GB_Nav.viewControllers.count <=1) {
        return false;
    }
    UIViewController * vc = GB_Nav.lastVC;
    
    if ([vc isKindOfClass:[LoginViewController class]]) {
        return false;
    }
    return !vc.isNotCanSlideLeft;
  
 
}
// 异步执行
+ (void)asynthicBlock:(void (^)(void))block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}
// 异步执行
+ (void)mainQueueBlock:(void (^)(void))block{
    dispatch_async(dispatch_get_main_queue(), block);
}
//重复执行次数
+(void)applyRepeatNum:(int)num block:(void(^)(size_t time))block{
    dispatch_apply(num,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),block);
}

/**
 跳转到指定根视图
 
 @param index tabbarItem数值
 @param animated 是否有动画
 */
+(void)jumpToRootVC:(NSUInteger)index  animated:(BOOL)animated{
    
    [GB_Nav popToRootViewControllerAnimated:false];
    CustomTabBarController *tabBar = GB_Nav.viewControllers.firstObject;
    if ([tabBar isKindOfClass:[CustomTabBarController class]]) {
        if (tabBar.selectedIndex != index) {
            [tabBar setSelectedIndex:index];
        }
    }
}

+ (void)jumpToOrderDetailVC:(double )orderID{
    OrderDetailVC * detail = [OrderDetailVC new];
    detail.modelOrder = ^(){
        ModelOrderList * model = [ModelOrderList new];
        model.iDProperty = orderID;
        return model;
    }();
    if ([GB_Nav.lastVC isKindOfClass:OrderDetailVC.class]) {
        [GB_Nav popLastAndPushVC:detail];
    }else{
        [GB_Nav pushViewController:detail animated:true];
    }
}

+ (void)jumpToOrderList{
    if ([GlobalMethod isLoginSuccess]) {
        CustomTabBarController * tab = GB_Nav.viewControllers.firstObject;
        if ([tab isKindOfClass:[CustomTabBarController class]]) {
            tab.selectedIndex = 0;
        }
        
        [GB_Nav popToRootViewControllerAnimated:true];
       
    }

}
+ (void)jumpToMsgVC{
    if ([GlobalMethod isLoginSuccess]) {
        [GB_Nav popToClass:@"AttachListManagementVC"];
    }
    
}
@end
