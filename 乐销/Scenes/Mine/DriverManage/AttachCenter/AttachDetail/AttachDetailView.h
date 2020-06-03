//
//  AttachDetailView.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/12/3.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttachDetailView : UIView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelAttachApplyList *)model;

@end

@interface AttachDetailImageView : UIView
@property (nonatomic, strong) NSArray *aryImages;

#pragma mark 刷新view
- (void)resetViewWithAryModels:(NSArray *)aryImages;
@end

@interface AttachDetailBottomView : UIView
//属性
@property (strong, nonatomic) UIButton *btnCancel;
@property (strong, nonatomic) UIButton *btnReject;
@property (strong, nonatomic) UIButton *btnAgree;
@property (nonatomic, strong) void (^blockCancel)(void);
@property (nonatomic, strong) void (^blockReject)(void);
@property (nonatomic, strong) void (^blockAgree)(void);

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelAttachApplyList *)model;

@end
