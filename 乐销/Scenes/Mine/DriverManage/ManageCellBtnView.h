//
//  ManageCellBtnView.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/8.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageCellBtnView : UIView
@property (nonatomic, assign) BOOL isSmallBtnWidth;
#pragma mark 刷新view
- (void)resetViewWithAry:(NSArray *)ary;

@end
