//
//  DCTCarouselViewController.m
//  DCTContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "DCTCarouselViewController.h"

@import DCTBridge;
@import SToolsKit;
@import Masonry;

@interface DCTCarouselCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong )UIImageView *iconImageView;

@property (nonatomic ,strong) DCTCarouselBean *carouseBean;

#if DCTCarouselOne

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UIView *titleLabelBackground;
#elif DCTCarouselTwo


@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UIView *titleLabelBackground;
#elif DCTCarouselThree

#endif

- (void)commitInit;

@end

@implementation DCTCarouselCollectionViewCell

#if DCTCarouselOne

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

#elif DCTCarouselTwo

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
#elif DCTCarouselThree


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
- (void)setCarouseBean:(DCTCarouselBean *)carouseBean {
    
    self.iconImageView.image = [UIImage imageNamed:carouseBean.icon];
    
//    self.titleLabel.text = carouseBean.title;
}

#if DCTCarouselOne

#elif DCTCarouselTwo

#elif DCTCarouselThree

#endif

- (void)commitInit {
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.iconImageView];
#if DCTCarouselOne
    
    [self addSubview:self.titleLabelBackground];
    
    [self addSubview:self.titleLabel];
    
#elif DCTCarouselTwo
    
    [self addSubview:self.titleLabelBackground];
    
    [self addSubview:self.titleLabel];
#elif DCTCarouselThree
    
    
    
#endif
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.frame = self.bounds;
    
#if DCTCarouselTwo
    
    [self.titleLabelBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        
        make.height.mas_equalTo(30);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.bottom.equalTo(self);
        
        make.left.mas_equalTo(15);
        
        make.height.mas_equalTo(30);
    }];
#elif DCTCarouselOne
    
#elif DCTCarouselThree
    
    [self.titleLabelBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(self);
        
        make.height.mas_equalTo(30);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.bottom.equalTo(self);
        
        make.left.mas_equalTo(15);
        
        make.height.mas_equalTo(30);
    }];
#endif
}
@end



#if DCTCarouselOne || DCTCarouselThree

#define DCTCarouselHeight KSSCREEN_WIDTH / 2

@interface DCTCarouselFormOneLayout : UICollectionViewFlowLayout



@end

@implementation DCTCarouselFormOneLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGSize itemSize = CGSizeMake(KSSCREEN_WIDTH, KSSCREEN_WIDTH / 2);
    
    self.itemSize = itemSize;
    
    self.minimumLineSpacing = 0.1;
    
    self.minimumInteritemSpacing = 0.1;
    
    self.sectionInset = UIEdgeInsetsZero;
    
}

@end

#elif DCTCarouselTwo

#define DCTCarouselHeight KSSCREEN_WIDTH / 2

@interface DCTCarouselFormOneLayout : UICollectionViewFlowLayout



@end

@implementation DCTCarouselFormOneLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGSize itemSize = CGSizeMake(KSSCREEN_WIDTH, KSSCREEN_WIDTH / 2);
    
    self.itemSize = itemSize;
    
    self.minimumLineSpacing = 0.1;
    
    self.minimumInteritemSpacing = 0.1;
    
    self.sectionInset = UIEdgeInsetsZero;
    
}

@end
//#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//#define ITEM_ZOOM 0.05
//#define THE_ACTIVE_DISTANCE 230
//#define LEFT_OFFSET 60
//@interface DCTCarouselFormTwoLayout : UICollectionViewFlowLayout
//
//#define DCTCarouselHeight KSSCREEN_WIDTH / 2
//@end
//@implementation DCTCarouselFormTwoLayout
//
//- (void)prepareLayout {
//    [super prepareLayout];
//
//    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//
//    CGSize itemSize = CGSizeMake(KSSCREEN_WIDTH - 80, DCTCarouselHeight);
//
//    self.itemSize = itemSize;
//
//    self.minimumLineSpacing = 20.0f;
//
//    self.sectionInset = UIEdgeInsetsMake(60, 40, 0, 40);
//
//}
//
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
//{
//    return YES;
//}
//
//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    NSArray * array = [[NSArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
//    CGRect visiableRect;
//    visiableRect.origin = self.collectionView.contentOffset;
//    visiableRect.size = self.collectionView.bounds.size;
//
//    for (UICollectionViewLayoutAttributes * attributes in array)
//    {
//        if (CGRectIntersectsRect(attributes.frame, rect))
//        {
//            CGFloat distance = CGRectGetMidX(visiableRect) - attributes.center.x;
//            distance = ABS(distance);
//            if (distance < KSSCREEN_WIDTH/2 + self.itemSize.width)
//            {
//                CGFloat zoom = 1 + ITEM_ZOOM * (1 - distance/THE_ACTIVE_DISTANCE);
//                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0f);
//                attributes.transform3D = CATransform3DTranslate(attributes.transform3D, 0, -zoom * 25, 0);
//                attributes.alpha = zoom - ITEM_ZOOM;
//            }
//        }
//    }
//    return array;
//}
//
//- (CGPoint )targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//{
//    CGFloat offsetAdjustment = MAXFLOAT;
//
//    CGFloat horizontalCenter_X = proposedContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2.0;
//    CGRect targetRect = CGRectMake(proposedContentOffset.x, 20, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
//    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
//    for (UICollectionViewLayoutAttributes * attributes in array)
//    {
//        CGFloat itemHorizontalCenter_X = attributes.center.x;
//        if (ABS(itemHorizontalCenter_X - horizontalCenter_X) < ABS(offsetAdjustment))
//        {
//            offsetAdjustment = itemHorizontalCenter_X - horizontalCenter_X;
//        }
//    }
//
//    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
//}
//
//@end

#endif

@interface DCTCarouselViewController ()

@property (nonatomic ,strong) UIPageControl *pageControl;

@property (nonatomic ,strong) DCTCarouselBridge *bridge;

#if DCTCarouselTwo

#elif DCTCarouselOne

#elif DCTCarouselThree

@property (nonatomic ,copy) NSString *carouselTitle;

#endif
@end

@implementation DCTCarouselViewController

+ (instancetype)createCarousel {
    
    return [self new];
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        
        _pageControl.tag = 102;
        
        _pageControl.pageIndicatorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@DCTColor]];
        
        _pageControl.numberOfPages = DCTCarouselImgs.count;
        
        _pageControl.currentPage = 0;
        
        _pageControl.currentPageIndicatorTintColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
    }
    return _pageControl;
}

- (void)addOwnSubViews {
    [super addOwnSubViews];
    
#if DCTCarouselOne
    
    DCTCarouselFormOneLayout *layout = [DCTCarouselFormOneLayout new];
    
#elif DCTCarouselTwo
    
    DCTCarouselFormOneLayout *layout = [DCTCarouselFormOneLayout new];
#elif DCTCarouselThree
    DCTCarouselFormOneLayout *layout = [DCTCarouselFormOneLayout new];
#endif
    
    UICollectionView *collectionView = [self createCollectionWithLayout:layout];
    
    collectionView.pagingEnabled = true;
    
    [self.view addSubview:collectionView];
    
    [self.view addSubview:self.pageControl];
}
- (void)configOwnSubViews {
    
    [self.collectionView registerClass:[DCTCarouselCollectionViewCell class] forCellWithReuseIdentifier:@"image"];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(0);
        
        make.height.mas_equalTo( DCTCarouselHeight);
    }];
    
#if DCTCarouselOne
    
    self.pageControl.pageIndiDCTorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff30"];
    
    self.pageControl.pageIndiDCTorTintColor = [UIColor s_transformToColorByHexColorStr:@"#ffffff"];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(80);
        
        make.right.mas_equalTo(-15);
        
        make.height.mas_equalTo(30);
        
        make.top.mas_equalTo(DCTCarouselHeight - 30);
    }];
#elif DCTCarouselTwo
    
    self.pageControl.pageIndicatorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff30"];
    
    self.pageControl.currentPageIndicatorTintColor = [UIColor s_transformToColorByHexColorStr:@"#ffffff"];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(80);
        
        make.right.mas_equalTo(-15);
        
        make.height.mas_equalTo(30);
        
        make.top.mas_equalTo(DCTCarouselHeight - 30);
    }];
    
#elif DCTCarouselThree
    
    self.pageControl.pageIndiDCTorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff30"];
    
    self.pageControl.pageIndiDCTorTintColor = [UIColor s_transformToColorByHexColorStr:@"#ffffff"];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(80);
        
        make.right.mas_equalTo(-15);
        
        make.height.mas_equalTo(30);
        
        make.top.mas_equalTo(DCTCarouselHeight - 30);
    }];
#endif
}
- (void)configViewModel {
    
    DCTCarouselBridge *bridge = [DCTCarouselBridge new];
    
    self.bridge = bridge;
#if DCTCarouselTwo
    
    [bridge createCarousel:self canPageHidden:false canTimerResp:true carousels:DCTCarouselImgs style:DCTCarouselStyleCard carouseAction:^(DCTCarouselBean * _Nonnull banner) {
       
        
    }];

#elif DCTCarouselOne || DCTCarouselThree
    
    [bridge createCarousel:self canPageHidden:false canTimerResp:false carousels:DCTCarouselImgs style:DCTCarouselStyleNormal carouseAction:^(DCTCarouselBean * _Nonnull carouse) {
        
    }];
    
#endif
}

- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    DCTCarouselCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:ip ];
    
    cell.carouseBean = data;
    
    return cell;
}

- (void)collectionViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    
}
@end
