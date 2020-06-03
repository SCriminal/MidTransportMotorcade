//
//  DriverFilterView.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/14.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriverFilterView : UIView


@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UIView *viewBlackAlpha;
@property (nonatomic, strong) UITextField *tfBillNo;
@property (nonatomic, strong) UIButton *btnSearch;
@property (nonatomic, strong) UIButton *btnReset;
@property (nonatomic, strong) UITextField *tfPhone;

@property (nonatomic, strong) void (^blockSearchClick)(NSString * ,NSString *);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
- (void)show;

@end
