//
//  SelectDriverVC.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/8.
//Copyright © 2019 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface SelectDriverVC : BaseTableVC
@property (nonatomic, strong) ModelDriver *modelSelected;

@property (nonatomic, strong) void (^blockSelected)(ModelDriver *);

@end
