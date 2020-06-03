//
//  MsgCenterCell.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/6/26.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsgCenterCell : UITableViewCell
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelContent;
@property (nonatomic, strong) UIImageView *ivBg;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelMsg *)model;

@end
