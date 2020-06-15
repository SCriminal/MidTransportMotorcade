//
//  CarDetailView.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/12/3.
//Copyright © 2019 ping. All rights reserved.
//

#import "CarDetailView.h"
#import "DriverDetailView.h"
//exchange type
#import "AddCarVC.h"
//image detail
#import "ImageDetailBigView.h"

@implementation CarDetailView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelCar *)modelDetail{
    [self removeAllSubViews];//移除线
    //重置视图坐标
    CGFloat bottom =  [DriverDetailView addDetailSubView:@[^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"当前状态";
        model.subTitle = modelDetail.authStatusShow;
        model.color = modelDetail.authStatusColorShow;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"关联司机";
        
        model.subTitle =isStr(modelDetail.driverName)||isStr(modelDetail.driverPhone)? [NSString stringWithFormat:@"%@ %@",modelDetail.driverName,modelDetail.driverPhone]:@"暂无关联司机";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"核定载质量";
        model.subTitle = modelDetail.vehicleLoad?[strDotF(modelDetail.vehicleLoad) stringByAppendingString:@"吨"]:@"暂无";
        
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"车拥有人";
        model.subTitle = modelDetail.vehicleOwner;
        
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"车辆类型";
        model.subTitle = [AddCarVC exchangeVehicleType:strDotF(modelDetail.vehicleType)];
        
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"牌照类型";
        model.subTitle = [AddCarVC exchangeLicenseType:strDotF(modelDetail.licenceType)];
        
        return model;
    }(),
                                                            //                                        ^(){
                                                            //            ModelBtn * model = [ModelBtn new];
                                                            //            model.title = @"车长";
                                                            //            model.subTitle =modelDetail.vehicleLength?[AddCarVC exchangeVehicleLength:strDotF(modelDetail.vehicleLength)]:@"暂无";
                                                            //            return model;
                                                            //        }(),
                                                            ^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"档案编号";
        model.subTitle = modelDetail.drivingNumber;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"运输证号";
        model.subTitle = modelDetail.roadTransportNumber;
        
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"总质量";
        model.subTitle = modelDetail.grossMass?[NSNumber.dou(modelDetail.grossMass).stringValue stringByAppendingString:@"kg"]:@"暂无";
        
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"车辆长度";
        NSString * strLength = modelDetail.length?[NSNumber.dou(modelDetail.length).stringValue stringByAppendingString:@"mm "]:@"";
        NSString * strWidth = modelDetail.weight?[NSNumber.dou(modelDetail.weight).stringValue stringByAppendingString:@"mm "]:@"";
        NSString * strHeight = modelDetail.height?[NSNumber.dou(modelDetail.height).stringValue stringByAppendingString:@"mm"]:@"";
        
        NSString * strAll = [NSString stringWithFormat:@"%@%@%@",strLength,strWidth,strHeight];
        model.subTitle = (modelDetail.length==0&&modelDetail.weight==0&&modelDetail.height==0)?@"暂无":strAll;
        
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"车轴数";
        model.subTitle = modelDetail.axle?NSNumber.dou(modelDetail.axle).stringValue:@"暂无";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"识别代码";
        model.subTitle = modelDetail.vin;
        
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"发动机号";
        model.subTitle = modelDetail.engineNumber;
        
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"品牌型号";
        model.subTitle = modelDetail.model;
        
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"使用性质";
        model.subTitle = modelDetail.useCharacter;
        
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"能源类型";
        model.subTitle = [AddCarVC exchangeEnergeyType:strDotF(modelDetail.energyType)];
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"挂车号码";
        model.subTitle = modelDetail.trailerNumber;
        
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"发证机关";
        model.subTitle = modelDetail.drivingAgency;
        
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"注册日期";
        model.subTitle = [GlobalMethod exchangeTimeWithStamp:modelDetail.drivingRegisterDate andFormatter:TIME_DAY_SHOW];
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"发证日期";
        model.subTitle = [GlobalMethod exchangeTimeWithStamp:modelDetail.drivingIssueDate andFormatter:TIME_DAY_SHOW];
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"有效日期";
        model.subTitle = [GlobalMethod exchangeTimeWithStamp:modelDetail.drivingEndDate andFormatter:TIME_DAY_SHOW];
        return model;
    }()] inView:self title:modelDetail.vehicleNumber];
    //设置总高度
    self.height = [self addLineFrame:CGRectMake(W(15), bottom, SCREEN_WIDTH - W(30), 1)];
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}


@end


@implementation CarDetailImageView

#pragma mark 刷新view
- (void)resetViewWithAryModels:(NSArray *)aryImages{
    self.aryImages = aryImages;
    [self removeAllSubViews];//移除线
    CGFloat left= W(15);
    CGFloat top = W(24);
    CGFloat bottom = 0;
    //重置视图坐标
    for (int i = 0; i<aryImages.count; i++) {
        ModelImage *model = aryImages[i];
        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(left, top, W(107), W(90))];
        [iv sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:model.image];
        [GlobalMethod setRoundView:iv color:[UIColor clearColor] numRound:5 width:0];
        iv.tag = i;
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.userInteractionEnabled = true;
        [iv addTarget:self action:@selector(imageClick:)];
        [self addSubview:iv];
        left = iv.right +W(12);
        bottom = iv.bottom + W(25);
        if ((i+1)%3 ==0) {
            left = W(15);
            top = iv.bottom + W(12);
        }
    }
    self.height = bottom;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}

#pragma mark click
- (void)imageClick:(UITapGestureRecognizer *)tap{
    UIImageView * view = (UIImageView *)tap.view;
    if (![view isKindOfClass:UIImageView.class]) {
        return;
    }
    ImageDetailBigView * detailView = [ImageDetailBigView new];
    [detailView resetView:self.aryImages.mutableCopy isEdit:false index: view.tag];
    [detailView showInView:[GB_Nav.lastVC view] imageViewShow:view];
}

@end
