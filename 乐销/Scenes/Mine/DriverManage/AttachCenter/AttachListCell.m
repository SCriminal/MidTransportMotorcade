//
//  AttachListCell.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/12/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "AttachListCell.h"
#import "ManageCellBtnView.h"
#import "CarLocationVC.h"
#import "AddDriverVC.h"

@interface AttachListCell ()
@property (nonatomic, strong) ManageCellBtnView *btnView;

@end

@implementation AttachListCell

- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        _labelName.textColor = COLOR_333;
        _labelName.font =  [UIFont systemFontOfSize:F(16) ];
        _labelName.numberOfLines = 1;
        _labelName.lineSpace = 0;
    }
    return _labelName;
}
- (ManageCellBtnView *)btnView{
    if (!_btnView) {
        _btnView = [ManageCellBtnView new];
    }
    return _btnView;
}
- (UIImageView *)ivBg{
    if (_ivBg == nil) {
        _ivBg = [UIImageView new];
        _ivBg.image = IMAGE_WHITE_BG;
        _ivBg.backgroundColor = [UIColor clearColor];
    }
    return _ivBg;
}
- (UILabel *)labelIdentity{
    if (_labelIdentity == nil) {
        _labelIdentity = [UILabel new];
        _labelIdentity.textColor = COLOR_666;
        _labelIdentity.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelIdentity.numberOfLines = 1;
        _labelIdentity.lineSpace = 0;
    }
    return _labelIdentity;
}


- (UIView *)line{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = COLOR_LINE;
    }
    return _line;
}
- (UILabel *)labelStatus{
    if (_labelStatus == nil) {
        _labelStatus = [UILabel new];
        _labelStatus.textColor = [UIColor whiteColor];
        _labelStatus.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        [GlobalMethod setRoundView:_labelStatus color:[UIColor clearColor] numRound:3 width:0];
        _labelStatus.numberOfLines = 1;
        _labelStatus.textAlignment = NSTextAlignmentCenter;
        _labelStatus.lineSpace = 0;
        _labelStatus.backgroundColor = COLOR_ORANGE;
    }
    return _labelStatus;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.ivBg];
        
        [self.contentView addSubview:self.labelName];
        [self.contentView addSubview:self.labelIdentity];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.labelStatus];
        [self.contentView addSubview:self.btnView];
        
    }
    return self;
}

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelAttachApplyList *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelName fitTitle:UnPackStr(model.realName) variable:SCREEN_WIDTH - W(50)];
    self.labelName.leftTop = XY(W(25),W(25));
    [self.labelStatus fitTitle:model.authStatusShow variable:0];
    self.labelStatus.backgroundColor = model.authStatusColorShow;
    self.labelStatus.widthHeight = XY(self.labelStatus.width + W(8), self.labelName.height);
    self.labelStatus.leftCenterY = XY(self.labelName.right + W(5),self.labelName.centerY);
    
    [self.labelIdentity fitTitle:[NSString stringWithFormat:@"身份证号：%@",model.driverLicense] variable:SCREEN_WIDTH - W(50)-W(10)];
    self.labelIdentity.leftTop = XY(self.labelName.left,self.labelName.bottom+W(13));
    
   
    self.line.frame = CGRectMake(self.labelName.left,(self.labelIdentity.bottom + W(20)), SCREEN_WIDTH - self.labelName.left*2 , 1);
    
    WEAKSELF
    NSMutableArray * aryBtns = @[].mutableCopy;
    //已挂靠
    if (model.state == 10) {
        [aryBtns insertObject:^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"呼叫";
            model.color = COLOR_ORANGE;
            model.blockClick = ^{
                [weakSelf callClick];
            };
            return model;
        }() atIndex:0];
        [aryBtns addObject:^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"取消挂靠";
            model.color = COLOR_999;
            model.blockClick = ^{
                [weakSelf cancelClick];
            };
            return model;
        }()];
       
    }else if(model.state == 1){
        [aryBtns insertObject:^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"查看操作";
            model.color = COLOR_BLUE;
            model.blockClick = ^{
                [weakSelf detailClick];
            };
            return model;
        }() atIndex:0];
    }
   
    [self.btnView resetViewWithAry:aryBtns];
    self.btnView.top = self.line.bottom;
    //设置总高度
    self.height = self.btnView.bottom+W(9);
    self.ivBg.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height);
}

- (void)callClick{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.model.cellPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)cancelClick{
    if (self.blockCancel) {
        self.blockCancel(self);
    }
}
- (void)detailClick{
    if (self.blockDetail) {
        self.blockDetail(self);
    }
}

@end
