//
//  SelectCarCell.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/8.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCarCell : UITableViewCell

//属性
@property (strong, nonatomic) UILabel *labelCarNum;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UILabel *labelStatus;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *ivSelect;
@property (nonatomic, strong) ModelCar *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCar *)model;

@end


@interface SelectCarBottomView : UIView
//属性
@property (strong, nonatomic) UIButton *btnSend;
@property (strong, nonatomic) UIButton *btnAdd;
@property (nonatomic, strong) void (^blockSend)();
@property (nonatomic, strong) void (^blockAdd)();

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
