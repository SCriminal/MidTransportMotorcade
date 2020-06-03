//
//  SelectAuthorityCell.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/5.
//Copyright © 2019 ping. All rights reserved.
//

#import "SelectAuthorityCell.h"

@interface SelectAuthorityCell ()

@end
@implementation SelectAuthorityCell
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineSpace = 0;
    }
    return _labelTitle;
}
- (UIImageView *)logo{
    if (_logo == nil) {
        _logo = [UIImageView new];
        _logo.image = [UIImage imageNamed:IMAGE_HEAD_COMPANY_DEFAULT];
        _logo.widthHeight = XY(W(50),W(50));
        [GlobalMethod setRoundView:_logo color:COLOR_LINE numRound:_logo.width/2.0 width:1];
        _logo.backgroundColor = [UIColor clearColor];
    }
    return _logo;
}
- (UIImageView *)ivBG{
    if (_ivBG == nil) {
        _ivBG = [UIImageView new];
        _ivBG.image = IMAGE_WHITE_BG;
        _ivBG.widthHeight = XY(SCREEN_WIDTH - W(30),W(87)+W(20));
    }
    return _ivBG;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.ivBG];
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.logo];
        [self.contentView addTarget:self action:@selector(click)];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model{
    self.model = model;
    //设置总高度
    self.height = self.ivBG.height +W(20);

    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelTitle fitTitle:model.title variable:0];
    self.labelTitle.leftCenterY = XY(W(45),self.height/2.0);
    
    [self.logo sd_setImageWithURL:[NSURL URLWithString:model.highImageName] placeholderImage:[UIImage imageNamed:model.imageName]];
    self.logo.rightCenterY = XY(SCREEN_WIDTH - W(45),self.height/2.0);
    
    self.ivBG.centerXCenterY = XY(SCREEN_WIDTH/2.0,self.height/2.0);
    
}

- (void)click{
    if (self.model.blockClick) {
        self.model.blockClick();
    }else if(self.cellClick){
        self.cellClick(self);
    }
}
@end




@implementation SelectAuthorityTopView
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(25)];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineSpace = 0;
    }
    return _labelTitle;
}
- (UILabel *)labelSubTitle{
    if (_labelSubTitle == nil) {
        _labelSubTitle = [UILabel new];
        _labelSubTitle.textColor = COLOR_666;
        _labelSubTitle.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _labelSubTitle.numberOfLines = 0;
        _labelSubTitle.lineSpace = 0;
    }
    return _labelSubTitle;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.labelTitle];
    [self addSubview:self.labelSubTitle];
    
}

#pragma mark 刷新view
- (void)resetViewWithTitle:(NSString *)title subTitle:(NSString *)subtitle{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelTitle fitTitle:title variable:0];
    self.labelTitle.leftTop = XY(W(25),W(25));
    [self.labelSubTitle fitTitle:subtitle variable:0];
    self.labelSubTitle.leftTop = XY(W(25),self.labelTitle.bottom+W(20));
    
    //设置总高度
    self.height = self.labelSubTitle.bottom + W(15);
}

@end
