//
//  DriverMangementCell.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/8.
//Copyright © 2019 ping. All rights reserved.
//

#import "DriverMangementCell.h"
#import "ManageCellBtnView.h"
#import "CarLocationVC.h"
#import "AddDriverVC.h"
@interface DriverMangementCell ()
@property (nonatomic, strong) ManageCellBtnView *btnView;

@end

@implementation DriverMangementCell

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

- (UILabel *)labelReason{
    if (_labelReason == nil) {
        _labelReason = [UILabel new];
        _labelReason.textColor = COLOR_666;
        _labelReason.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelReason.numberOfLines = 1;
        _labelReason.lineSpace = 0;
    }
    return _labelReason;
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
        [self.contentView addSubview:self.labelReason];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.labelStatus];
        [self.contentView addSubview:self.btnView];

    }
    return self;
}

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelDriver *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelName fitTitle:UnPackStr(model.driverName) variable:SCREEN_WIDTH - W(50)];
    self.labelName.leftTop = XY(W(25),W(25));
    [self.labelStatus fitTitle:model.authStatusShow variable:0];
    self.labelStatus.backgroundColor = model.authStatusColorShow;
    self.labelStatus.widthHeight = XY(self.labelStatus.width + W(8), self.labelName.height);
    self.labelStatus.leftCenterY = XY(self.labelName.right + W(5),self.labelName.centerY);
    
    [self.labelIdentity fitTitle:[NSString stringWithFormat:@"身份证号：%@",model.idNumber] variable:SCREEN_WIDTH - W(50)-W(10)];
    self.labelIdentity.leftTop = XY(self.labelName.left,self.labelName.bottom+W(13));
    
    [self.labelReason fitTitle:[NSString stringWithFormat:@"审核原因：%@",model.qualificationDescription] variable:SCREEN_WIDTH - W(50)-W(10)];
    self.labelReason.leftTop = XY(self.labelIdentity.left,self.labelIdentity.bottom+W(13));
    self.labelReason.hidden = model.reviewStatus.intValue != 10;
    
    self.line.frame = CGRectMake(self.labelName.left,!self.labelReason.hidden?(self.labelReason.bottom + W(20)):(self.labelIdentity.bottom + W(20)), SCREEN_WIDTH - self.labelName.left*2 , 1);
    
    WEAKSELF
    NSMutableArray * aryBtns = @[^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"删除";
        model.blockClick = ^{
            [weakSelf deleteClick];
        };
        return model;
    }()].mutableCopy;
    
    if (model.isAuthorityReject) {
        [aryBtns insertObject:^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"重新认证";
            model.color = COLOR_BLUE;
            model.blockClick = ^{
                AddDriverVC * addDriver = [AddDriverVC new];
                addDriver.model = weakSelf.model;
                addDriver.blockBack = ^(UIViewController *vc) {
                    if (vc.requestState) {
                        BaseTableVC * tableVC = (BaseTableVC *)[weakSelf.contentView fetchVC];
                        if ([tableVC isKindOfClass:[BaseTableVC class]]) {
                            [tableVC refreshHeaderAll];
                        }
                    }
                    
                };
                [GB_Nav pushViewController:addDriver animated:true];
            };
            return model;
        }() atIndex:0];
    }
    if (model.reviewStatus.intValue == 3 && isStr(model.driverPhone)) {
        [aryBtns insertObject:^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"呼叫";
            model.color = COLOR_ORANGE;
            model.blockClick = ^{
                [weakSelf callClick];
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
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.model.driverPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
- (void)trickClick{
    CarLocationVC * vc = [CarLocationVC new];
    vc.modelDriver = self.model;
    [GB_Nav pushViewController:vc animated:true];
}
- (void)deleteClick{
    if (self.blockDelete) {
        self.blockDelete(self);
    }
}
@end
