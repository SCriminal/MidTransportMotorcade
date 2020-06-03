//
//  OrderDetailPackageView.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/7.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailPackageView : UIView

//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIImageView *ivBg;
@property (nonatomic, strong) NSArray *aryDatas;
@property (nonatomic, strong) ModelOrderList *modelOrder;
@property (nonatomic, strong) void (^blockInputNum)(ModelPackageInfo*,BOOL);

#pragma mark 刷新view
- (void)resetViewWithAry:(NSArray *)models;

@end


@interface OrderDetailPackageItemView : UIView
//属性
@property (strong, nonatomic) UILabel *labelPackageType;
@property (strong, nonatomic) UILabel *labelStatus;
@property (strong, nonatomic) UILabel *labelDriver;
@property (strong, nonatomic) UILabel *labelCar;
@property (strong, nonatomic) UILabel *labelPackageNum;
@property (strong, nonatomic) UILabel *labelPlumbemNum;
@property (strong, nonatomic) UILabel *labelWeight;
@property (strong, nonatomic) UILabel *labelPrice;
@property (strong, nonatomic) UILabel *labelName;
@property (nonatomic, strong) UIImageView * ivArrow;
@property (nonatomic, strong) UIImageView * ivInputNum;
@property (nonatomic, strong) UIImageView * ivInputSealNum;

@property (nonatomic, strong) UIButton *conInputNum;
@property (nonatomic, strong) UIButton *conInputSealNum;
@property (nonatomic, strong) void (^blockInputNum)(ModelPackageInfo*,BOOL);

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) ModelPackageInfo *model;
@property (nonatomic, strong) ModelOrderList *modelOrder;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelPackageInfo *)model;

@end
