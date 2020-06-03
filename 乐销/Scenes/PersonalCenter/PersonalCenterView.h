//
//  PersonalCenterView.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/9.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCenterView : UIView
//属性
@property (strong, nonatomic) UIImageView *ivBG;
@property (strong, nonatomic) UIImageView *ivLogo;
@property (strong, nonatomic) UILabel *labelName;
@property (strong, nonatomic) UILabel *labelID;
@property (strong, nonatomic) UILabel *labelBrief;
@property (strong, nonatomic) UIControl *conCopyCode;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end


@interface PersonalCenterBottomView : UIView
//属性
@property (strong, nonatomic) UILabel *labelAuthorityStatus;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
