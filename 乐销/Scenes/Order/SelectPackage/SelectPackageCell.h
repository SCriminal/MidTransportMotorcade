//
//  SelectPackageCell.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/8.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectPackageCell : UITableViewCell
//属性
@property (strong, nonatomic) UILabel *labelPackageType;
@property (strong, nonatomic) UILabel *labelPackageNum;
@property (strong, nonatomic) UILabel *labelPlumbemNum;
@property (strong, nonatomic) UILabel *labelWeight;
@property (strong, nonatomic) UILabel *labelPrice;
@property (strong, nonatomic) UILabel *labelName;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *ivSelect;
@property (nonatomic, strong) ModelPackageInfo *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelPackageInfo *)model;

@end


@interface SelectPackageBottomView : UIView
//属性
@property (strong, nonatomic) UILabel *labelSelectALl;
@property (strong, nonatomic) UIImageView *ivSelect;
@property (strong, nonatomic) UIButton *btnSend;
@property (nonatomic, strong) UIControl *conSelectAll;
@property (nonatomic, strong) void (^blockSend)(void);
@property (nonatomic, strong) void (^blockSelectAll)(BOOL);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end



