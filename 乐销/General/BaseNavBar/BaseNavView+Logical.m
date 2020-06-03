//
//  BaseNavView+Logical.m
//中车运
//
//  Created by 隋林栋 on 2018/10/19.
//  Copyright © 2018年 ping. All rights reserved.
//

#import "BaseNavView+Logical.h"

@implementation BaseNavView (Logical)
//设置蓝色模式
- (void)configBlueStyle{
    self.backgroundColor = COLOR_BLUE;
    for (UIImageView * iv in self.leftView.subviews) {
        if ([iv isKindOfClass:[UIImageView class]]) {
            iv.image = [UIImage imageNamed:@"back_white"];
        }
    }
    self.labelTitle.textColor = [UIColor whiteColor];
    self.line.hidden = true;
}

//设置红色模式
- (void)configRedStyle{
    for (UIImageView * iv in self.leftView.subviews) {
        if ([iv isKindOfClass:[UIImageView class]]) {
            iv.image = [UIImage imageNamed:@"back_white"];
        }
    }
    UIImageView * ivRed = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT)];
    ivRed.backgroundColor = [UIColor clearColor];
    ivRed.image = [UIImage imageNamed:@"nav_redBG"];
    ivRed.clipsToBounds = true;
    ivRed.contentMode = UIViewContentModeScaleAspectFill;
    [self insertSubview:ivRed atIndex:0];
    self.line.hidden = true;
}



//设置黑色模式
- (void)configBlackBackStyle{
    for (UIImageView * iv in self.leftView.subviews) {
        if ([iv isKindOfClass:[UIImageView class]]) {
            iv.image = [UIImage imageNamed:@"back_white"];
        }
    }
    [self configBlackStyle];
}

- (void)configBlackStyle{
    for (UILabel * label in self.rightView.subviews) {
        if ([label isKindOfClass:[UILabel class]]) {
            label.textColor = [UIColor whiteColor];
        }
    }
    
    UIImageView * ivRed = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT)];
    ivRed.backgroundColor = [UIColor clearColor];
    ivRed.image = [UIImage imageNamed:@"nav_Bar"];
    ivRed.clipsToBounds = true;
    ivRed.contentMode = UIViewContentModeScaleAspectFill;
    [self insertSubview:ivRed atIndex:0];
    self.line.hidden = true;
    
    self.labelTitle.textColor = [UIColor whiteColor];
}
@end
