//
//  AccountListCell.h
//  Driver
//
//  Created by 隋林栋 on 2019/4/16.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountListCell : UITableViewCell
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelBillNo;
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) UILabel *labelPrice;
@property (strong, nonatomic) UIImageView *ivSelected;
@property (nonatomic, assign) BOOL isEditing;
#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end


@interface AccountBottomView : UIView
//属性
@property (strong, nonatomic) UILabel *labelSum;
@property (strong, nonatomic) UIButton *btnManage;
@property (nonatomic, strong) void (^blockClick)();

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end

@interface AccountBottomEditView : UIView
//属性
@property (strong, nonatomic) UILabel *labelSum;
@property (strong, nonatomic) UIButton *btnManage;
@property (strong, nonatomic) UIImageView *ivSelected;
@property (nonatomic, strong) void (^blockClick)();
@property (nonatomic, strong) void (^blockSelectAllClick)(BOOL);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
