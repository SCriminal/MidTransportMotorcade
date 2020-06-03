//
//  ManageCarListCell.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/8.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageCarListCell : UITableViewCell

//属性
@property (strong, nonatomic) UILabel *labelCarNum;
@property (strong, nonatomic) UILabel *labelName;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *ivBg;
@property (nonatomic, strong) ModelCar *model;
@property (strong, nonatomic) UILabel *labelStatus;
@property (nonatomic, strong) void (^blockTrack)(ModelCar *);
@property (nonatomic, strong) void (^blockDelete)(ModelCar *);
@property (nonatomic, strong) void (^blockEdit)(ModelCar *);
@property (nonatomic, strong) void (^blockSubmitAdmit)(ModelCar *);


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCar *)model;

@end
