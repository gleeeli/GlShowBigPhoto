//
//  GlShowPictureModel.h
//  GlShowBigPhoto
//
//  Created by 小柠檬 on 2018/12/11.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface GlShowPictureModel : NSObject
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSURL *url;
@end

NS_ASSUME_NONNULL_END
