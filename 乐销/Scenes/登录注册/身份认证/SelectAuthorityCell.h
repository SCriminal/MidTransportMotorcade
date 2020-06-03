//
//  SelectAuthorityCell.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/5.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectAuthorityCell : UITableViewCell
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UIImageView *ivBG;
@property (nonatomic, strong) ModelBtn *model;
@property (nonatomic, strong) void (^cellClick)(SelectAuthorityCell *);

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end


@interface SelectAuthorityTopView : UIView
//属性
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UILabel *labelSubTitle;

#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)title subTitle:(NSString *)subtitle;

@end
