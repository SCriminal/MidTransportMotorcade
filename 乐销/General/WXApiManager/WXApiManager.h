

#import <Foundation/Foundation.h>
#import <WXApi.h>
//model
#import "ModelWXApiReq.h"


@interface WXApiManager : NSObject<WXApiDelegate>
//单例
+ (instancetype)sharedManager;
//注册
+ (void)registerApp;

@end
