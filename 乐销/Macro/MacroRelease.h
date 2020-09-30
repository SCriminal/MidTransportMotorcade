//
//  MacroRelease.h
//中车运
//
//  Created by 隋林栋 on 2017/6/16.
//  Copyright © 2017年 ping. All rights reserved.
//

#ifndef MacroRelease_h
#define MacroRelease_h

//请求URL
#if DEBUG
#define URL_HEAD  @"http://112.253.1.72:10401"
#define URL_IMAGE @"http://112.253.1.72:10499"//image
#define URL_SHARE @"http://112.253.1.72:10201"
//#define URL_HEAD  @"https://api.zhongcheyun.cn"
//#define URL_IMAGE @"https://img.zhongcheyun.cn"//image
//#define URL_SHARE @"https://www.zhongcheyun.cn"
#else
#define URL_HEAD  @"https://api.zhongcheyun.cn"
#define URL_IMAGE @"https://img.zhongcheyun.cn"//image
#define URL_SHARE @"https://www.zhongcheyun.cn"

#endif
#if DEBUG
//#define SLD_TEST //sld_test
#endif



//聊天自定义属性
#define LX_UserName_Key @"LX_UserName"
#define LX_HeadImage_Key @"LX_HeadImage"

//阿里云文件地址
#define ENDPOINT @"http://oss-cn-beijing.aliyuncs.com"
#define ENDPOINT_VIDEO @"http://oss-cn-beijing.aliyuncs.com"

#define IMAGEURL_HEAD @"http://img.zhongcheyun.cn"
//微信 appid
#define WXAPPID @"wx5e4f324c73714937"
#define WXAPPLINK  @"https://www.zhongcheyun.cn/motorcade/"
#define WECHAT_UPDATE


//高德地图
#define MAPID @"4a9b77ddd5c58a673326883b8d1d57ab"

//闪登
#define FLASH_ID @"h9HQTEdK"
#define FLASH_KEY @"1sNSijQW"


#endif /* MacroRelease_h */
