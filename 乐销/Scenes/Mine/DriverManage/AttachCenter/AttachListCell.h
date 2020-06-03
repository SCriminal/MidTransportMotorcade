//
//  AttachListCell.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/12/9.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttachListCell : UITableViewCell
//属性
@property (strong, nonatomic) UILabel *labelIdentity;
@property (strong, nonatomic) UILabel *labelName;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *ivBg;
@property (strong, nonatomic) UILabel *labelStatus;
@property (nonatomic, strong) ModelAttachApplyList *model;
@property (nonatomic, strong) void (^blockCancel)(AttachListCell *);
@property (nonatomic, strong) void (^blockDetail)(AttachListCell *);

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelAttachApplyList *)model;
@end
