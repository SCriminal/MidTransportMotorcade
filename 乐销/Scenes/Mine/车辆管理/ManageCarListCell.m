//
//  ManageCarListCell.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/8.
//Copyright © 2019 ping. All rights reserved.
//

#import "ManageCarListCell.h"
#import "ManageCellBtnView.h"

@interface ManageCarListCell ()
@property (nonatomic, strong) ManageCellBtnView *btnView;

@end

@implementation ManageCarListCell

- (UILabel *)labelCarNum{
    if (_labelCarNum == nil) {
        _labelCarNum = [UILabel new];
        _labelCarNum.textColor = COLOR_333;
        _labelCarNum.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightBold];
        _labelCarNum.numberOfLines = 1;
        _labelCarNum.lineSpace = 0;
    }
    return _labelCarNum;
}
- (ManageCellBtnView *)btnView{
    if (!_btnView) {
        _btnView = [ManageCellBtnView new];
        _btnView.isSmallBtnWidth = true;
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
- (UILabel *)labelName{
    if (_labelName == nil) {
        _labelName = [UILabel new];
        _labelName.textColor = COLOR_666;
        _labelName.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _labelName.numberOfLines = 1;
        _labelName.lineSpace = 0;
    }
    return _labelName;
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

        [self.contentView addSubview:self.labelCarNum];
        [self.contentView addSubview:self.labelName];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.btnView];
        [self.contentView addSubview:self.labelStatus];
    }
    return self;
}

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCar *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelCarNum fitTitle:UnPackStr(model.vehicleNumber) variable:SCREEN_WIDTH - W(50)];
    self.labelCarNum.leftTop = XY(W(25),W(25));
    
    [self.labelStatus fitTitle:model.authStatusShow variable:0];
    self.labelStatus.backgroundColor = model.authStatusColorShow;
    self.labelStatus.widthHeight = XY(self.labelStatus.width + W(8), self.labelCarNum.height);
    self.labelStatus.leftCenterY = XY(self.labelCarNum.right + W(5),self.labelCarNum.centerY);
    
    [self.labelName fitTitle:model.driverId?[NSString stringWithFormat:@"司机信息：%@ %@",UnPackStr(model.driverName),UnPackStr(model.driverPhone)]:@"暂未关联司机" variable:SCREEN_WIDTH - W(50)-W(10)];
    self.labelName.leftTop = XY(self.labelCarNum.left,self.labelCarNum.bottom+W(13));
    self.line.frame = CGRectMake(self.labelCarNum.left, self.labelName.bottom + W(20), SCREEN_WIDTH - self.labelCarNum.left*2 , 1);

    
  

    //设置总高度
    WEAKSELF
    [self.btnView resetViewWithAry:^(){
        NSMutableArray * aryDatas = [NSMutableArray arrayWithArray:@[^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"定位";
            model.color = COLOR_GREEN;
            model.blockClick = ^{
                if (weakSelf.blockTrack) {
                    weakSelf.blockTrack(weakSelf.model);
                }
            };
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"编辑";
            model.color = COLOR_BLUE;
            model.blockClick = ^{
                if (weakSelf.blockEdit) {
                    weakSelf.blockEdit(weakSelf.model);
                }
            };
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"删除";
            model.blockClick = ^{
                if (weakSelf.blockDelete) {
                    weakSelf.blockDelete(weakSelf.model);
                }
            };
            return model;
        }()]];
        if (model.qualificationState == 1 ||model.qualificationState == 10) {
            [aryDatas insertObject:^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"提交审核";
                model.color = COLOR_BLUE;
                model.blockClick = ^{
                    if (weakSelf.blockSubmitAdmit) {
                        weakSelf.blockSubmitAdmit(weakSelf.model);
                    }
                };
                return model;
            }() atIndex:2];
        }else if(model.qualificationState == 3 && isStr(weakSelf.model.driverPhone)){
            [aryDatas insertObject:^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"呼叫";
                model.color = COLOR_ORANGE;
                model.blockClick = ^{
                    [weakSelf callClick];
                };
                return model;
            }() atIndex:1];
        }
        return aryDatas;
    }()];
    self.btnView.top = self.line.bottom;
    //设置总高度
    self.height = self.btnView.bottom+W(9);
    self.ivBg.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height);
}


- (void)callClick{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.model.driverPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
@end
