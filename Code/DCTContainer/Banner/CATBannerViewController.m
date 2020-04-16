//
//  CATCarouselViewController.m
//  CATContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "CATBannerViewController.h"

@import CATBridge;
@import SToolsKit;
@import Masonry;
@import SDWebImage;

@interface CATBannerCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong )UIImageView *iconImageView;

@property (nonatomic ,strong) CATCarouselBean *carouseBean;

#if CATCarouselOne

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UIView *titleLabelBackground;
#elif CATCarouselTwo

#elif CATCarouselThree

#endif

- (void)commitInit;

@end

@implementation CATBannerCollectionViewCell

#if CATCarouselOne

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _titleLabel;
}
- (UIView *)titleLabelBackground {
    
    if (!_titleLabelBackground) {
        
        _titleLabelBackground = [UIView new];
        
        _titleLabelBackground.backgroundColor = [UIColor blackColor];
        
        _titleLabelBackground.alpha = 0.5;
    }
    return _titleLabelBackground;
}

#elif CATCarouselTwo

#elif CATCarouselThree


#endif
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self commitInit];
        
    }
    return self;
}
- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] init];
        
        _iconImageView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"].CGColor;
        
        _iconImageView.layer.borderWidth = 0.5;
        
        _iconImageView.layer.masksToBounds = true;
        
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}
- (void)setCarouseBean:(CATCarouselBean *)carouseBean {
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_600,h_200",carouseBean.icon]] placeholderImage:[UIImage imageNamed:@CATLogoIcon] options:SDWebImageRefreshCached];
    
    self.titleLabel.text = carouseBean.title;

}

#if CATCarouselOne

#elif CATCarouselTwo

#elif CATCarouselThree

#endif

- (void)commitInit {
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.iconImageView];
#if CATCarouselOne
    
    [self addSubview:self.titleLabelBackground];
    
    [self addSubview:self.titleLabel];
    
#elif CATCarouselTwo
    
#elif CATCarouselThree
    
#endif
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.frame = self.bounds;
    
#if CATCarouselOne
    
    [self.titleLabelBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        
        make.height.mas_equalTo(30);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.bottom.equalTo(self);
        
        make.left.mas_equalTo(15);
        
        make.height.mas_equalTo(30);
    }];
#elif CATCarouselTwo
    
#elif CATCarouselThree
    
    
#endif
}
@end



#if CATCarouselOne || CATCarouselThree

#define CATCarouselHeight KSSCREEN_WIDTH / 3

@interface CATBannerFormOneLayout : UICollectionViewFlowLayout


@end

@implementation CATBannerFormOneLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGSize itemSize = CGSizeMake(KSSCREEN_WIDTH, KSSCREEN_WIDTH / 3);
    
    self.itemSize = itemSize;
    
    self.minimumLineSpacing = 0.1;
    
    self.minimumInteritemSpacing = 0.1;
    
    self.sectionInset = UIEdgeInsetsZero;
    
}

@end

#elif CATCarouselTwo

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define ITEM_ZOOM 0.05
#define THE_ACTIVE_DISTANCE 230
#define LEFT_OFFSET 60
@interface CATBannerFormTwoLayout : UICollectionViewFlowLayout

#define CATCarouselHeight KSSCREEN_WIDTH / 3
@end
@implementation CATBannerFormTwoLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGSize itemSize = CGSizeMake(KSSCREEN_WIDTH - 80, CATCarouselHeight);
    
    self.itemSize = itemSize;
    
    self.minimumLineSpacing = 20.0f;
    
    self.sectionInset = UIEdgeInsetsMake(60, 40, 0, 40);
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray * array = [[NSArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    CGRect visiableRect;
    visiableRect.origin = self.collectionView.contentOffset;
    visiableRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes * attributes in array)
    {
        if (CGRectIntersectsRect(attributes.frame, rect))
        {
            CGFloat distance = CGRectGetMidX(visiableRect) - attributes.center.x;
            distance = ABS(distance);
            if (distance < KSSCREEN_WIDTH/2 + self.itemSize.width)
            {
                CGFloat zoom = 1 + ITEM_ZOOM * (1 - distance/THE_ACTIVE_DISTANCE);
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0f);
                attributes.transform3D = CATransform3DTranslate(attributes.transform3D, 0, -zoom * 25, 0);
                attributes.alpha = zoom - ITEM_ZOOM;
            }
        }
    }
    return array;
}

- (CGPoint )targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
    
    CGFloat horizontalCenter_X = proposedContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2.0;
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 20, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    for (UICollectionViewLayoutAttributes * attributes in array)
    {
        CGFloat itemHorizontalCenter_X = attributes.center.x;
        if (ABS(itemHorizontalCenter_X - horizontalCenter_X) < ABS(offsetAdjustment))
        {
            offsetAdjustment = itemHorizontalCenter_X - horizontalCenter_X;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

@end

#endif

@interface CATBannerViewController ()

@property (nonatomic ,strong) UIPageControl *pageControl;

@property (nonatomic ,strong) CATCarouselBridge *bridge;

@property (nonatomic ,strong) NSMutableArray *banners;

#if CATCarouselOne

#elif CATCarouselTwo

#elif CATCarouselThree

#endif
@end

@implementation CATBannerViewController

+ (instancetype)createBannerWithBanners:(NSArray<NSDictionary *> *)banners {
    
    return [[self alloc] initWithBanners:banners];
}
- (instancetype)initWithBanners:(NSArray<NSDictionary *> *)banners {
    
    if (self = [super init]) {
        
        [self.banners addObjectsFromArray:banners];
    }
    return self;
}
- (NSMutableArray *)banners {
    
    if (!_banners) {
        
        _banners = [NSMutableArray array];
    }
    return _banners;
}
- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        
        _pageControl.tag = 102;
        
        _pageControl.pageIndicatorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@CATColor]];
        
        _pageControl.numberOfPages = CATCarouselImgs.count;
        
        _pageControl.currentPage = 0;
        
        _pageControl.currentPageIndicatorTintColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
    }
    return _pageControl;
}

- (void)addOwnSubViews {
    [super addOwnSubViews];
    
#if CATCarouselOne
    
    CATBannerFormOneLayout *layout = [CATBannerFormOneLayout new];
    
#elif CATCarouselTwo
    
    CATCBannerFormTwoLayout *layout = [CATCBannerFormTwoLayout new];
#elif CATCarouselThree
    CATBannerFormOneLayout *layout = [CATBannerFormOneLayout new];
#endif
    
    UICollectionView *collectionView = [self createCollectionWithLayout:layout];
    
    collectionView.pagingEnabled = true;
    
    [self.view addSubview:collectionView];
    
    [self.view addSubview:self.pageControl];
}
- (void)configOwnSubViews {
    
    [self.collectionView registerClass:[CATBannerCollectionViewCell class] forCellWithReuseIdentifier:@"image"];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(0);
        
        make.height.mas_equalTo( CATCarouselHeight);
    }];
    
#if CATCarouselOne
    
    self.pageControl.pageIndicatorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff30"];
    
    self.pageControl.pageIndicatorTintColor = [UIColor s_transformToColorByHexColorStr:@"#ffffff"];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(80);
        
        make.right.mas_equalTo(-15);
        
        make.height.mas_equalTo(30);
        
        make.top.mas_equalTo(CATCarouselHeight - 30);
    }];
#elif CATCarouselTwo
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(80);
        
        make.centerX.mas_equalTo(0);
        
        make.height.mas_equalTo(20);
        
        make.top.mas_equalTo(CATCarouselHeight - 40 );
    }];
    
#elif CATCarouselThree
    
    self.pageControl.pageIndicatorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff30"];
    
    self.pageControl.pageIndicatorTintColor = [UIColor s_transformToColorByHexColorStr:@"#ffffff"];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(80);
        
        make.right.mas_equalTo(-15);
        
        make.height.mas_equalTo(30);
        
        make.top.mas_equalTo(CATCarouselHeight - 30);
    }];
#endif
}
- (void)configViewModel {
    
    CATCarouselBridge *bridge = [CATCarouselBridge new];
    
    self.bridge = bridge;
#if CATCarouselTwo
    [bridge createCarousel:self canPageHidden:false images:CATCarouselImgs style:CATCarouselStyleTwo carouseAction:^(NSString * _Nonnull banner) {
        
        
    }];
#elif CATCarouselOne || CATCarouselThree
    
    [bridge createCarousel:self canPageHidden:false canTimerResp:false carousels:self.banners style:CATCarouselStyleNormal carouseAction:^(CATCarouselBean * _Nonnull carouse) {
        
        
    }];
    
#endif
}

- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    CATBannerCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:ip ];
    
    cell.carouseBean = data;
    
    return cell;
}

- (void)collectionViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    
}
@end
