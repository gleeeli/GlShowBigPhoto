//
//  GlShowBigCollectionViewCell.h
//  GlShowBigPhoto
//
//  Created by 小柠檬 on 2018/12/11.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlShowPictureModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GlShowBigCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) GlShowPictureModel *model;
@end

NS_ASSUME_NONNULL_END
