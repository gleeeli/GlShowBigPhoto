//
//  GlShowBigCollectionViewCell.m
//  GlShowBigPhoto
//
//  Created by 小柠檬 on 2018/12/11.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

#import "GlShowBigCollectionViewCell.h"
#import "GlComHeader.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

#define GlPhotoEdgeInterval 15
#define GlDefaultImageName @"default"
@interface GlShowBigCollectionViewCell()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, assign) CGFloat imageWidth;
@end

@implementation GlShowBigCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createBaseView];
    }
    return self;
}

- (void)createBaseView {
    self.imageWidth = kScreenWidth - GlPhotoEdgeInterval * 2.0;
    self.scrollview = [[UIScrollView alloc] init];
    self.scrollview.showsVerticalScrollIndicator = NO;
    self.scrollview.showsHorizontalScrollIndicator = NO;
    self.scrollview.delegate = self;
    self.scrollview.minimumZoomScale = 1;
    self.scrollview.maximumZoomScale = 10;
    self.scrollview.contentInset = UIEdgeInsetsMake(GlPhotoEdgeInterval, GlPhotoEdgeInterval, GlPhotoEdgeInterval, GlPhotoEdgeInterval);
    [self.contentView addSubview:self.scrollview];
    [self.scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    UIImage *image = [UIImage imageNamed:GlDefaultImageName];
    UIImageView *topImageView = [[UIImageView alloc] initWithImage:image];
    self.topImageView = topImageView;
    topImageView.image = self.model.image;
    
    [self.scrollview addSubview:topImageView];
    
    CGFloat imgHeight = 0;
    if(image){
        imgHeight = self.imageWidth / image.size.width * image.size.height;
    }
    self.topImageView.frame = CGRectMake(0, 0, self.imageWidth, imgHeight);
    
    self.scrollview.contentSize = CGSizeMake(self.imageWidth, imgHeight + GlPhotoEdgeInterval);
}

- (void)setModel:(GlShowPictureModel *)model {
    _model = model;
    
    __weak typeof(self) weakself = self;
    
    if (model.image == nil) {
        [self.topImageView sd_setImageWithURL:model.url placeholderImage:[UIImage imageNamed:GlDefaultImageName] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.model.image = !error? image :[UIImage imageNamed:GlDefaultImageName];
                [weakself updateFrameWithImage:weakself.model.image];
            });
        }];
    }else {
        [self downCompleteUpdateLayout];
    }
}

- (void)downCompleteUpdateLayout {
    UIImage *image = self.model.image? self.model.image:[UIImage imageNamed:GlDefaultImageName];
    self.topImageView.image = image;
    
    [self updateFrameWithImage:image];
}

- (void)updateFrameWithImage:(UIImage *)image {
    if (image) {
        CGFloat imgHeight = self.imageWidth / image.size.width * image.size.height;
        
        self.topImageView.frame = CGRectMake(0, 0, self.imageWidth, imgHeight);
        self.scrollview.contentSize = CGSizeMake(self.imageWidth, imgHeight + GlPhotoEdgeInterval);
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.topImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGRect frame = self.topImageView.frame;
    frame.origin.x = (self.imageWidth - self.topImageView.frame.size.width) > 0 ? (self.imageWidth - self.topImageView.frame.size.width) * 0.5 : 0;
    self.topImageView.frame = frame;
    
    self.scrollview.contentSize = CGSizeMake(self.topImageView.frame.size.width, self.topImageView.frame.size.height);
}
@end
