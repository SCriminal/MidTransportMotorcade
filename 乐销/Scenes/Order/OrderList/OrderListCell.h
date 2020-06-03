//
//  OrderListCell.h
//中车运
//
//  Created by 隋林栋 on 2018/10/28.
//Copyright © 2018年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListCell : UITableViewCell

@property (strong, nonatomic) UILabel *labelBillNo;
@property (strong, nonatomic) UILabel *labelCompanyName;
@property (strong, nonatomic) UILabel *labelOrderNo;
@property (strong, nonatomic) UILabel *labelStatus;
@property (strong, nonatomic) UILabel *labelAddressFrom;
@property (strong, nonatomic) UILabel *labelAddressTo;
@property (strong, nonatomic) UILabel *labelPriceAll;
@property (strong, nonatomic) UIImageView *ivCompanyLogo;
@property (strong, nonatomic) UIImageView *ivOrder;
@property (strong, nonatomic) UIImageView *ivBg;
@property (strong, nonatomic) UIView *viewBG;
@property (strong, nonatomic) UIView *dotBlue;
@property (strong, nonatomic) UIView *lineVertical;
@property (strong, nonatomic) UIView *dotRed;
@property (strong, nonatomic) UIView *viewGray;

@property (nonatomic, strong) ModelOrderList *model;
@property (nonatomic, strong) void (^blockAcceptClick)(ModelOrderList *);
@property (nonatomic, strong) void (^blockRejectClick)(ModelOrderList *);
@property (nonatomic, strong) void (^blockReturnClick)(ModelOrderList *);
@property (nonatomic, strong) void (^blockDispatchClick)(ModelOrderList *);

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelOrderList *)model;

@end



@interface OrderListDateCell : UITableViewCell

@property (strong, nonatomic) UILabel *labelDay;
@property (strong, nonatomic) UILabel *labelYear;
@property (strong, nonatomic) UIView *grayBg;
@property (nonatomic, strong) UIView *blueBG;
@property (nonatomic, strong) UIView *lineTop;
@property (nonatomic, strong) ModelBaseData *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBaseData *)model;

@end
