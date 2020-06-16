//
//  DriverDetailView.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/12/3.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriverDetailView : UIView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelDriver *)model;
+ (CGFloat)addDetailSubView:(NSArray *)aryBtns inView:(UIView *)viewSuper title:(NSString *)title;
@end

