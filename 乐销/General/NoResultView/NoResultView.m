//
//  NoResultView.m
//中车运
//
//  Created by mengxi on 17/1/19.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "NoResultView.h"

@implementation NoResultView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.fontNum = F(17);
        _labelTitle.textColor = [UIColor colorWithHexString:@"BABABA"];

    }
    return _labelTitle;
}

- (UIImageView *)ivNoResult{
    if (!_ivNoResult) {
        _ivNoResult = [UIImageView new];
        _ivNoResult.backgroundColor = [UIColor clearColor];
        _ivNoResult.widthHeight = XY(W(200), W(200));
    }
    return _ivNoResult;
}
-(UIButton *)btnAdd{
    if (_btnAdd == nil) {
        _btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAdd addTarget:self action:@selector(btnAddClick) forControlEvents:UIControlEventTouchUpInside];
        _btnAdd.backgroundColor = COLOR_DARK;
        _btnAdd.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        [_btnAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [GlobalMethod setRoundView:_btnAdd color:[UIColor clearColor] numRound:5 width:0];
        [_btnAdd setTitle:@"立即添加" forState:(UIControlStateNormal)];
        _btnAdd.widthHeight = XY(W(235),W(45));
        _btnAdd.hidden = true;
    }
    return _btnAdd;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubView];
    }
    return self;
}

//添加subview
- (void)addSubView{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.labelTitle];
    [self addSubview:self.ivNoResult];
    [self addSubview:self.btnAdd];

}

#pragma mark show 
- (void)showInView:(UIView *)viewShow frame:(CGRect)frame{
    self.frame = frame;
    [self resetView];
    [viewShow addSubview:self];
}

#pragma mark 创建
+ (instancetype)initWithFrame:(CGRect)frame{
    NoResultView * view = [NoResultView new];
    view.frame = frame;
    [view resetView];
    return view;
}

#pragma mark 刷新view
- (void)resetView{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.ivNoResult.centerXTop = XY(self.width/2.0, W(122));
    self.labelTitle.centerXTop = XY(self.width / 2,self.ivNoResult.bottom + W(10));
    self.btnAdd.centerXTop = XY(self.width / 2,self.ivNoResult.bottom + W(80));

}

//reset with image
- (void)resetWithImageName:(NSString *)imageName title:(NSString *)title{
    self.ivNoResult.image = [UIImage imageNamed:imageName];
    [self.labelTitle fitTitle:title variable:0];
}

- (void)btnAddClick{
    if (self.blockAdd) {
        self.blockAdd();
    }
}
@end
