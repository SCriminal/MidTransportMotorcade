//
//  CarLocationVC.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "BaseVC.h"

@interface CarLocationVC : BaseVC

@property (nonatomic, strong) ModelPackageInfo *modelPackage;
@property (nonatomic, strong) ModelDriver *modelDriver;



@end

@interface CarLocationBottomView : UIView
//属性
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UILabel *labelAddress;
@property (strong, nonatomic) UIImageView *ivBg;

#pragma mark 刷新view
- (void)resetViewWithName:(NSString *)strName carNumber:(NSString *)carNumber;
- (void)resetViewWithAddress:(NSString *)address;
@end
