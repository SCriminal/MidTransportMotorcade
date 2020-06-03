//
//  SelectDriverCell.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/8.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectDriverCell : UITableViewCell

//属性
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UILabel *labelIdentity;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *ivSelect;
@property (nonatomic, strong) ModelDriver *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelDriver *)model;
@end

@interface SelectDriverTopView : UIView
//属性
@property (strong, nonatomic) UILabel *labelName;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *ivSelect;
@property (nonatomic, strong) void (^blockClick)();

@end

@interface SelectDriverBottomView : UIView

//属性
@property (strong, nonatomic) UIButton *btnSend;
@property (strong, nonatomic) UIButton *btnAdd;
@property (nonatomic, strong) void (^blockSend)();
@property (nonatomic, strong) void (^blockAdd)();

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
