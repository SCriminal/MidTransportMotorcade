//
//  AttachFilterView.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/12/11.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttachFilterView : UIView


@property (nonatomic, strong) void (^blockSearchClick)(NSString *, NSString *);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
- (void)show;

@end

@interface ApplyFilterView : UIView


@property (nonatomic, strong) void (^blockSearchClick)(NSString *, NSString *,NSDate *,NSDate *);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
- (void)show;

@end
