//
//  DriverMangementCell.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/8.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriverMangementCell : UITableViewCell
//属性
@property (strong, nonatomic) UILabel *labelIdentity;
@property (strong, nonatomic) UILabel *labelReason;
@property (strong, nonatomic) UILabel *labelName;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *ivBg;
@property (strong, nonatomic) UILabel *labelStatus;
@property (nonatomic, strong) ModelDriver *model;
@property (nonatomic, strong) void (^blockDelete)(DriverMangementCell *);
@property (nonatomic, strong) void (^blockTrick)(DriverMangementCell *);

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelDriver *)model;

@end
