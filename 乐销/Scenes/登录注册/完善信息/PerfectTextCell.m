//
//  PerfectTextCell.m
//中车运
//
//  Created by 隋林栋 on 2018/10/24.
//Copyright © 2018年 ping. All rights reserved.
//

#import "PerfectTextCell.h"

@interface PerfectTextCell ()

@end

@implementation PerfectTextCell

#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_666;
        _title.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _title.numberOfLines = 0;
        _title.lineSpace = 0;
    }
    return _title;
}
- (UITextField *)textField{
    if (_textField == nil) {
        _textField = [UITextField new];
        _textField.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.textColor = COLOR_333;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.backgroundColor = [UIColor clearColor];
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFileAction:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _textField;
}
- (UILabel *)essential{
    if (_essential == nil) {
        _essential = [UILabel new];
        _essential.textColor = [UIColor redColor];
        _essential.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        [_essential fitTitle:@"*" variable:0];
    }
    return _essential;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.essential];
        [self.contentView addTarget:self action:@selector(cellClick)];
        
    }
    return self;
}
#pragma mark 刷新cell

- (void)resetCellWithModel:(ModelBaseData *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //设置总高度
    self.height = W(65);
    
    
    [self.title fitTitle:model.string variable:0];
    self.title.leftCenterY = XY(W(15),self.height/2.0);
    self.title.textColor = self.model.isChangeInvalid?COLOR_999:COLOR_666;

    self.essential.rightCenterY = XY(self.title.left-W(2), self.title.centerY);
    self.essential.hidden = !model.isRequired;

    CGFloat leftInterval = MAX(self.subTitleInterval, W(99));
    self.textField.widthHeight = XY(SCREEN_WIDTH - leftInterval - W(15), [GlobalMethod fetchHeightFromFont:self.textField.font.pointSize]);
    self.textField.leftCenterY = XY(leftInterval, self.title.centerY);
    self.textField.text = model.subString;
    self.textField.textColor = model.isChangeInvalid?COLOR_999:COLOR_333;
    self.textField.userInteractionEnabled = !model.isChangeInvalid;

    {
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = COLOR_999;
        attrs[NSFontAttributeName] = self.textField.font;
        NSMutableAttributedString *placeHolder = [[NSMutableAttributedString alloc]initWithString:self.model.isChangeInvalid?@"不可修改":UnPackStr(model.placeHolderString) attributes:attrs];
        self.textField.attributedPlaceholder = placeHolder;
    }
    if (!model.hideState) {
        [self.contentView addLineFrame:CGRectMake(W(15), self.height -1, SCREEN_WIDTH - W(15), 1)];
    }
}

#pragma mark cell click
- (void)cellClick{
    if (self.model.isChangeInvalid) {
        [GlobalMethod showAlert:@"不可修改"];
        return;
    }
    if (self.textField.userInteractionEnabled ) {
        [self.textField becomeFirstResponder];
    }
}
#pragma mark textfild change
- (void)textFileAction:(UITextField *)textField {
    self.model.subString = textField.text;
}

#pragma mark tf 代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textField resignFirstResponder];
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.model.string isEqualToString:@"车牌号码"]) {
        textField.text = textField.text.uppercaseString;
        self.model.subString = textField.text;
    }
}
@end



@implementation PerfectEmptyCell
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_666;
        _labelTitle.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineSpace = 0;
    }
    return _labelTitle;
}
- (UILabel *)labelExample{
    if (!_labelExample) {
        _labelExample = [UILabel new];
        _labelExample.textColor = COLOR_BLUE;
        _labelExample.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        [_labelExample fitTitle:@"示例" variable:0];
    }
    return _labelExample;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F3F4F8"];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.labelExample];
        [self.contentView addTarget:self action:@selector(cellClick)];
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //设置总高度
    self.height = W(48);

    //刷新view
    [self.labelTitle fitTitle:model.string variable:0];
    self.labelTitle.leftCenterY = XY(W(15),self.height/2.0);
    
    [self.labelExample fitTitle:isStr(model.subString)?model.subString:@"示例" variable:0];
    self.labelExample.rightCenterY = XY(SCREEN_WIDTH - W(15), self.labelTitle.centerY);
    self.labelExample.hidden = !model.isSelected;
}
//click
- (void)cellClick{
    if (self.model.blocClick ) {
        self.model.blocClick(nil);
    }
}
@end
