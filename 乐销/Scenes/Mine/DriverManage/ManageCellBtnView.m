//
//  ManageCellBtnView.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/8.
//Copyright © 2019 ping. All rights reserved.
//

#import "ManageCellBtnView.h"

@interface ManageCellBtnView ()
@property (nonatomic, strong) NSArray *ary;

@end

@implementation ManageCellBtnView

#pragma mark 刷新view
- (void)resetViewWithAry:(NSArray *)ary{
    [self removeAllSubViews];//移除线
    //设置总高度
    self.height = W(60);
    self.ary = ary;
    CGFloat right = SCREEN_WIDTH - W(25);
    //重置视图坐标
    for (int i = 0; i<ary.count; i++) {
        ModelBtn * modelBtn = ary[i];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (self.isSmallBtnWidth && modelBtn.title.length<=2) {
            btn.widthHeight = XY(W(65), W(30));
        }else{
            btn.widthHeight = XY(W(80), W(30));
        }
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [btn setTitle:modelBtn.title forState:UIControlStateNormal];
        btn.titleLabel.fontNum = F(13);
        [btn setTitleColor:modelBtn.color?modelBtn.color:COLOR_666  forState:UIControlStateNormal];
        [GlobalMethod setRoundView:btn color:modelBtn.color?modelBtn.color:COLOR_666 numRound:btn.height/2.0 width:1];
        [self addSubview:btn];
        btn.rightCenterY = XY(right, self.height/2.0);
        right = btn.left  - W(15);
    }
    
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}


#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    if (!(self.ary.count > sender.tag)) {
        return;
    }
    ModelBtn * model = self.ary[sender.tag];
    if (model.blockClick) {
        model.blockClick();
    }
}

@end
