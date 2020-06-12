//
//  BaseTableVC+Authority.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/6.
//  Copyright © 2019 ping. All rights reserved.
//

#import "BaseTableVC+Authority.h"
static const char subTitleIntervalKey = '\0';

@implementation BaseTableVC (Authority)


#pragma mark 运行时
-(void)setSubTitleInterval:(CGFloat)subTitleInterval
{
    objc_setAssociatedObject(self, &subTitleIntervalKey, [NSNumber numberWithFloat:subTitleInterval], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(CGFloat)subTitleInterval
{
    NSNumber * num = objc_getAssociatedObject(self, &subTitleIntervalKey);
    if (num == nil || ![num isKindOfClass:[NSNumber class]]) {
        return 0;
    }
    return [num floatValue];
}

- (void)registAuthorityCell{
    [self.tableView registerClass:[PerfectSelectCell class] forCellReuseIdentifier:@"PerfectSelectCell"];
    [self.tableView registerClass:[PerfectTextCell class] forCellReuseIdentifier:@"PerfectTextCell"];
    [self.tableView registerClass:[PerfectAddressDetailCell class] forCellReuseIdentifier:@"PerfectAddressDetailCell"];
    [self.tableView registerClass:[PerfectEmptyCell class] forCellReuseIdentifier:@"PerfectEmptyCell"];

}
- (UITableViewCell *)dequeueAuthorityCell:(NSIndexPath *)indexPath{
    ModelBaseData * model = self.aryDatas[indexPath.row];
    switch (model.enumType) {
        case ENUM_PERFECT_CELL_TEXT:
        {
            PerfectTextCell * textCell = [self.tableView dequeueReusableCellWithIdentifier:@"PerfectTextCell"];
            textCell.subTitleInterval = self.subTitleInterval;
            [textCell resetCellWithModel:model];
            return textCell;
        }
            break;
        case ENUM_PERFECT_CELL_SELECT:
        {
            PerfectSelectCell * selectCell = [self.tableView dequeueReusableCellWithIdentifier:@"PerfectSelectCell"];
            selectCell.subTitleInterval = self.subTitleInterval;
            [selectCell resetCellWithModel:model];
            return selectCell;
        }
            break;
        case ENUM_PERFECT_CELL_ADDRESS:
        {
            PerfectAddressDetailCell * addressCell = [self.tableView dequeueReusableCellWithIdentifier:@"PerfectAddressDetailCell"];
            addressCell.subTitleInterval = self.subTitleInterval;
            [addressCell resetCellWithModel:model];
            return addressCell;
        }
            break;
        case ENUM_PERFECT_CELL_EMPTY:
        {
            PerfectEmptyCell * addressCell = [self.tableView dequeueReusableCellWithIdentifier:@"PerfectEmptyCell"];
            [addressCell resetCellWithModel:model];
            return addressCell;
        }
            break;
        default:
            break;
    }
    return nil;
}
- (CGFloat)fetchAuthorityCellHeight:(NSIndexPath *)indexPath{
    ModelBaseData * model = self.aryDatas[indexPath.row];
    switch (model.enumType) {
        case ENUM_PERFECT_CELL_TEXT:
        {
            return [PerfectTextCell fetchHeight:model];
        }
            break;
        case ENUM_PERFECT_CELL_SELECT:
        {
            return [PerfectSelectCell fetchHeight:model];
        }
            break;
        case ENUM_PERFECT_CELL_ADDRESS:
        {
            CGFloat height = [PerfectAddressDetailCell fetchHeight:model];
            return height;
        }
            break;
        case ENUM_PERFECT_CELL_EMPTY:
        {
            return [PerfectEmptyCell fetchHeight:model];
        }
            break;
        default:
            break;
    }
    return 0.00;
}

@end
