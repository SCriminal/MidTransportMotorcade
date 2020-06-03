//
//  Collection_ProductImage.m
//中车运
//
//  Created by 隋林栋 on 2017/3/30.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "Collection_ProductImage.h"
//up image
#import "UIView+SelectImageView.h"
//base image
#import "BaseImage.h"
//cell
#import "CollectionImageCell.h"
//上传图片
#import "AliClient.h"

@implementation Collection_ProductImage

- (void)showSelectImage{
    [self showImageVC:NUM_IMAGE];
}

- (void)imagesSelect:(NSArray *)aryImages{
    [[AliClient sharedInstance]updateImageAry:aryImages
 storageSuccess:nil upSuccess:nil fail:nil];
    for (BaseImage * image in aryImages) {
        ModelImage *model = [ModelImage new];
        model.image = image;
        [self.aryDatas insertObject:model atIndex:0];
    }
    [self.collectionView reloadData];
   
}

@end
