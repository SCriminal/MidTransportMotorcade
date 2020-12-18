//
//  TestVC.m
//  中车运
//
//  Created by 隋林栋 on 2016/12/22.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "TestVC.h"
#import "BaseNavView+Logical.h"
#import "BaseVC+BaseImageSelectVC.h"
#import <CL_ShanYanSDK/CL_ShanYanSDK.h>
#import "ShareView.h"
#import "PersonalCarOwnerAuthorityVC.h"
#import "TransportCompanyAuthorityVC.h"

//import request
#import "RequestApi+UserApi.h"

@interface TestVC ()<UIWebViewDelegate,NSURLSessionDelegate>

@property (nonatomic, strong) UIWebView *web;
@property (nonatomic, strong) UILabel *labelShow;

@end

@implementation TestVC

- (UIWebView *)web{
    if (!_web) {
        _web = [UIWebView new];
        _web.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
        _web.delegate = self;
    }
    return _web;
}
- (UILabel *)labelShow{
    if (!_labelShow) {
        _labelShow = [UILabel new];
        _labelShow.fontNum = F(16);
        _labelShow.textColor = [UIColor blackColor];
        _labelShow.backgroundColor = [UIColor whiteColor];
        _labelShow.numberOfLines = 0;
    }
    return _labelShow;
}
#pragma mark view did load
- (void)viewDidLoad{
    [super viewDidLoad];
    
    WEAKSELF
    //config nav
    BaseNavView * nav =[BaseNavView initNavBackTitle:@"测试" rightTitle:@"FlashLogin" rightBlock:^{
        [weakSelf.view endEditing:true];
        [weakSelf jump];
    }];
    [nav configRedStyle];
    [self.view addSubview:nav];
    [self.view addSubview:self.labelShow];
    self.labelShow.leftTop = XY(0, NAVIGATIONBAR_HEIGHT);
    
//    [self.view addSubview:drawView];
//    [self.view addSubview:self.web];
//    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://e.cncike.com"]]];
//    [RequestApi requestNewsDetailWithId:@"7055eced15538bfb7c07f8a5b28fc5d0" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
//        NSLog(@"%@",response);
//    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
//    }];
    
    [CLShanYanSDKManager preGetPhonenumber];
    return;
}
// 快捷登录
- (void)quickLoginBtnClick {
    
    //耗时开始计时
    CFAbsoluteTime startButtonClick   = CFAbsoluteTimeGetCurrent();
    
//    [sender setEnabled:NO];e
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [sender setEnabled:YES];
//    });
    
    //电信定制界面
    CLCTCCUIConfigure * ctccUIConfigure = [CLCTCCUIConfigure new];
    ctccUIConfigure.viewController = self;
    
    //移动定制界面
    CLCMCCUIConfigure * cmccUIConfigure = [CLCMCCUIConfigure new];
    cmccUIConfigure.viewController = self;
    
    //联通定制界面
    CLCUCCUIConfigure * cuccUIConfigure = [CLCUCCUIConfigure new];
    cuccUIConfigure.viewController = self;
    
//    [SVProgressHUD setContainerView:self.view];
//    [SVProgressHUD show];
    
    [CLShanYanSDKManager quickAuthLoginWithConfigureCTCC:ctccUIConfigure CMCC:cmccUIConfigure CUCC:cuccUIConfigure timeOut:4 complete:^(CLCompleteResult * _Nonnull completeResult) {
        
//        [SVProgressHUD dismiss];
        
        if (completeResult.error) {
            
            //提示：错误无需提示给用户，可以在用户无感知的状态下直接切换登录方式
            //提示：错误无需提示给用户，可以在用户无感知的状态下直接切换登录方式
            //提示：错误无需提示给用户，可以在用户无感知的状态下直接切换登录方式
            
            if (completeResult.code == 1011){
                //用户取消登录（点返回）
                //处理建议：如无特殊需求可不做处理，仅作为交互状态回调，此时已经回到当前用户自己的页面
//                [SVProgressHUD showInfoWithStatus: @"用户取消免密登录"];
                [GlobalMethod mainQueueBlock:^{
                    [GlobalMethod showAlert:@"用户取消免密登录"];
                }];
            }else{
                //处理建议：其他错误代码表示闪验通道无法继续，可以统一走开发者自己的其他登录方式，也可以对不同的错误单独处理
                //1003    一键登录获取token失败
                //1008    未开启移动网络
                //1009    未检测到sim卡
                //其他     其他错误//
                dispatch_async(dispatch_get_main_queue(), ^{
//                    LoginResultController *vc = [LoginResultController new];
//                    vc.error = completeResult.error;
//                    [self.navigationController pushViewController:vc animated:YES];
//                    NSLog(@"%@",completeResult.error);
                    [GlobalMethod showAlert:@"登录失败"];

                });
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"quickAuthLogin Success:%@",completeResult.data);
                [GlobalMethod showAlert:@"登录成功"];
//                LoginResultController *vc = [LoginResultController new];
//                vc.completeResultData = completeResult.data;
//                vc.timesStart = startButtonClick;
//                if(self.navigationController){
//                    [self.navigationController pushViewController:vc animated:YES];
//                } else {
//                    [self presentViewController:vc animated:YES completion:^{
//
//                    }];
//                }
            });
        }
    }];
}
//授权页 点击自定义控件绑定的方法
-(void)otherLoginWayBtnCliced:(UIButton *)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        //建议使用授权页面配置对象传入的viewcontroller 调 dismiss
        if (self.navigationController.viewControllers.lastObject.navigationController) {
            [self.navigationController.viewControllers.lastObject dismissViewControllerAnimated:YES completion:nil];
        } else {
            UIViewController *topRootViewController = [[UIApplication  sharedApplication] keyWindow].rootViewController;
            // 在这里加一个这个样式的循环
            while (topRootViewController.presentedViewController) {
                // 这里固定写法
                topRootViewController = topRootViewController.presentedViewController;
            }
            // 然后再进行present操作
            [topRootViewController dismissViewControllerAnimated:YES completion:nil];
        }
    });
    [GlobalMethod showAlert:@"用户使用其他方式进行注册登录"];
}
/*
 
 */


//选择图片
- (void)imageSelect:(BaseImage *)image{

   
}

#pragma mark nav right click
- (void)jump{
    //    [self showImageVC:1];
//        [self orc:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554282970924&di=7bf3be94e56958da7913d04098374671&imgtype=0&src=http%3A%2F%2Fwww.nbskylark.com%2Fpictures%2F201410%2F30%2FXH20141030090410806F.jpg"];
    //    [self quickLoginBtnClick];
    [GB_Nav pushVCName:@"PersonalCarOwnerAuthorityVC" animated:true];
    //    [ShareView show];
//    [self addVersion];
}

/*
 residence manufacture
 */
- (void)orc:(NSString *)imageurl{
    //    [GB_Nav pushVCName:@"MainBlackVC" animated:true];
    NSString *appcode = @"e5125b82866442b8ab5ecaa2a6caa89f";
    NSString *host = @"https://api.zhongcheyun.cn/zhongcheyun/containertype/list/option";
    NSString *path = @"";
    NSString *method = @"GET";
    NSString *querys = @"";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
//    NSString *bodys = [NSString stringWithFormat:@"{\"url\":\"%@\",\"prob\":false,\"charInfo\":false,\"rotate\":false,\"table\":false}",imageurl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    //根据API的要求，定义相对应的Content-Type
    [request addValue: @"application/json; charset=UTF-8" forHTTPHeaderField: @"Content-Type"];
//    NSData *data = [bodys dataUsingEncoding: NSUTF8StringEncoding];
//    [request setHTTPBody: data];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       
                                                       NSLog(@"Response object: %@" , response);
                                                       NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                                       NSDictionary * dic = [GlobalMethod exchangeStringToDic:bodyString];
                                                       NSArray * aryAll = [dic arrayValueForKey:@"prism_wordsInfo"];
                                                       for (NSDictionary * dicWord in aryAll) {
                                                           NSString * strWord = [dicWord stringValueForKey:@"word"];
                                                           if (isStr(strWord)&& strWord.length > 3) {
                                                               [GlobalMethod mainQueueBlock:^{
                                                               }];
                                                               return ;
                                                           }
                                                       }
                                                       [GlobalMethod mainQueueBlock:^{
                                                           [GlobalMethod showAlert:@"图片解析失败"];
                                                       }];
                                                       
                                                       
                                                   }];
    [task resume];
    
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    NSURLCredential *card = [[NSURLCredential alloc] initWithTrust:challenge.protectionSpace.serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential,card);
}

- (void)addVersion{
//    [RequestApi requestAddVersionWithForceUpdate:false versionNumber:@"1.13" description:@"1.优化车辆添加和编辑的内容\n2.优化司机添加和编辑的内容\n3.增加个人中心企业码显示和复制功能\n" delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
//        NSLog(@"success");
//    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
//
//    }];
//    {
//    PersonalCarOwnerAuthorityVC * vc = [PersonalCarOwnerAuthorityVC new];
//    vc.model = [GlobalData sharedInstance].GB_CompanyModel;
//    [GB_Nav pushViewController:vc animated:true];
//    }
//    return;
    {
    TransportCompanyAuthorityVC * vc = [TransportCompanyAuthorityVC new];
    vc.model = [GlobalData sharedInstance].GB_CompanyModel;
    [GB_Nav pushViewController:vc animated:true];
//        vc.model.name.uppercaseString
    }
//    [GB_Nav pushVCName:@"AddCarVC" animated:true];
}
/*
 */

@end



