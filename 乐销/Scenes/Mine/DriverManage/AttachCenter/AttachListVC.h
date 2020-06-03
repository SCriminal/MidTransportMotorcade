//
//  AttachListVC.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/12/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface AttachListVC : BaseTableVC
@property (nonatomic, strong) NSString *strFilterName;
@property (nonatomic, strong) NSString *strFilterPhone;
@property (nonatomic, strong) NSDate *dateStart;
@property (nonatomic, strong) NSDate *dateEnd;
@property (nonatomic, strong) NSString *strState;
@property (nonatomic, strong) void (^blockRefreshAll)(void);


@end
