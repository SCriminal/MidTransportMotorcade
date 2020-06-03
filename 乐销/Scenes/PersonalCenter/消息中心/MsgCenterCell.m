//
//  MsgCenterCell.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/6/26.
//Copyright © 2019 ping. All rights reserved.
//

#import "MsgCenterCell.h"

@interface MsgCenterCell ()

@end

@implementation MsgCenterCell
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelTitle.numberOfLines = 1;
        _labelTitle.lineSpace = 0;
    }
    return _labelTitle;
}
- (UILabel *)labelContent{
    if (_labelContent == nil) {
        _labelContent = [UILabel new];
        _labelContent.textColor = COLOR_666;
        _labelContent.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        _labelContent.numberOfLines = 0;
        _labelContent.lineSpace = W(10);
    }
    return _labelContent;
}
- (UIImageView *)ivBg{
    if (_ivBg == nil) {
        _ivBg = [UIImageView new];
        _ivBg.image = IMAGE_WHITE_BG;
        _ivBg.backgroundColor = [UIColor clearColor];
    }
    return _ivBg;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.ivBg];
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.labelContent];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelMsg *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelTitle fitTitle: [GlobalMethod exchangeTimeWithStamp:model.createTime andFormatter:TIME_SEC_SHOW] variable:SCREEN_WIDTH - W(50)];
    self.labelTitle.leftTop = XY(W(25),W(15));
    [self.labelContent fitTitle:UnPackStr(model.content) variable:SCREEN_WIDTH - W(50)];
    self.labelContent.leftTop = XY(W(25),self.labelTitle.bottom+W(15));
    
    //设置总高度
    self.height = self.labelContent.bottom + W(25);
    
    self.ivBg.frame = CGRectMake(0, self.labelTitle.top - W(25), SCREEN_WIDTH, self.height+ W(10));
    
}

@end
