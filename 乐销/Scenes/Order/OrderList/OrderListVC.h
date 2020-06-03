//
//  OrderListVC.h
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import "BaseTableVC.h"

typedef NS_ENUM(NSUInteger, ENUM_ORDER_LIST_SORT) {
    ENUM_ORDER_LIST_SORT_ALL,
    ENUM_ORDER_LIST_SORT_WAIT_RECEIVE,
    ENUM_ORDER_LIST_SORT_WAIT_TRANSPORT,
    ENUM_ORDER_LIST_SORT_COMPLETE,
};

@interface OrderListVC : BaseTableVC
@property (nonatomic, assign) ENUM_ORDER_LIST_SORT sortType;
@property (nonatomic, strong) NSString *billNo;
@property (nonatomic, strong) NSDate *dateStart;
@property (nonatomic, strong) NSDate *dateEnd;
@property (nonatomic, assign) NSInteger dateTypeIndex;

@end
