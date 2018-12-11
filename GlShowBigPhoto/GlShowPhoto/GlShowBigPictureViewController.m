//
//  GlShowBigPictureViewController.m
//  GlShowBigPhoto
//
//  Created by 小柠檬 on 2018/12/11.
//  Copyright © 2018年 gleeeli. All rights reserved.
//

#import "GlShowBigPictureViewController.h"
#import "GlComHeader.h"
#import <Masonry.h>
#import "GlShowBigCollectionViewCell.h"

@interface GlShowBigPictureViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *pcollectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, assign) CGSize itemSize;
@end

@implementation GlShowBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat imgHeight = kScreenHeight - kTopHeight;
    self.itemSize = CGSizeMake(kScreenWidth, imgHeight);
    
    [self initDefualtCollectionView];
    [self updateCurShow];
    [self.pcollectionView reloadData];
    
    //防止出现白条
    if (@available(iOS 11.0, *))
    {
        self.pcollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    //页面加载完成 滚动，不然无效
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.curIndex inSection:0];
    [self.pcollectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

- (void)initDefualtCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout = flowLayout;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 两个单元格之间的最小间距
    self.flowLayout.minimumInteritemSpacing = 0.0;
    self.flowLayout.minimumLineSpacing = 0.0;
    self.pcollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight - kTopHeight) collectionViewLayout:flowLayout];
    self.pcollectionView.delegate = self;
    self.pcollectionView.dataSource = self;
    
    self.pcollectionView.backgroundColor = [UIColor clearColor];
    self.pcollectionView.pagingEnabled = YES;
    self.pcollectionView.contentInset = UIEdgeInsetsZero;
    self.pcollectionView.showsVerticalScrollIndicator = NO;
    self.pcollectionView.showsHorizontalScrollIndicator = NO;
    
    
    [self.view addSubview:self.pcollectionView];
    
    [self.pcollectionView registerClass:[GlShowBigCollectionViewCell class] forCellWithReuseIdentifier:@"GlShowBigCollectionViewCell"];
}

- (void)updateCurShow {
    self.title = [NSString stringWithFormat:@"图%zd/%zd",(self.curIndex + 1),self.photoModelsArray.count];
}

#pragma  mark CollectionView
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = [self.photoModelsArray count];
    return count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GlShowBigCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GlShowBigCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.photoModelsArray[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.itemSize;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x /CGRectGetWidth(scrollView.frame);
    self.curIndex = index;
    [self updateCurShow];
    
}

@end
