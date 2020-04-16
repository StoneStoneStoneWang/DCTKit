//
//  CATWelcomeViewController.m
//  CATContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "CATWelcomeViewController.h"
@import Masonry;
@import SToolsKit;
@import CATBridge;

@interface CATWelcomeCollectionViewCell ()

@property (nonatomic ,strong) UIImageView *iconImageView;

@end

@implementation CATWelcomeCollectionViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [UIImageView new];
        
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _iconImageView.backgroundColor = [UIColor clearColor];
        
        _iconImageView.layer.masksToBounds = true;
    }
    return _iconImageView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.iconImageView];
    }
    return self;
}

- (void)setIcon:(NSString *)icon {
    
    self.iconImageView.image = [UIImage imageNamed:icon];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconImageView.frame = self.bounds;
}

@end

@interface CATWelcomeViewController ()

@property (nonatomic ,strong) UIButton *skipItem;

@property (nonatomic ,strong) UIPageControl *pageControl;

@property (nonatomic ,strong) CATWelcomeBridge *bridge;

@property (nonatomic ,copy) CATWelcomeBlock block;
@end

@implementation CATWelcomeViewController

+ (instancetype)createWelcomeWithSkipBlock:(CATWelcomeBlock)block {
    
    return [[self alloc] initWithSkipBlock:block];
}

- (instancetype)initWithSkipBlock:(CATWelcomeBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (UIButton *)skipItem {
    
    if (!_skipItem) {
        
        _skipItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _skipItem.tag = 101;
        
        _skipItem.layer.borderWidth = 1;
        
        _skipItem.layer.masksToBounds = true;
        
        _skipItem.layer.cornerRadius = 5;
        
        _skipItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _skipItem;
}
- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        
        _pageControl.tag = 102;
        
        _pageControl.currentPage = 0;
        
    }
    return _pageControl;
}

- (void)addOwnSubViews {
    [super addOwnSubViews];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGSize itemSize = self.view.bounds.size;
    
    layout.itemSize = itemSize;
    
    layout.minimumLineSpacing = 0.1;
    
    layout.minimumInteritemSpacing = 0.1;
    
    layout.sectionInset = UIEdgeInsetsZero;
    
    UICollectionView *collectionView = [self createCollectionWithLayout:layout];
    
    collectionView.pagingEnabled = true;
    
    [self.view addSubview:collectionView];
    
    [self.view addSubview:self.skipItem];
    
    [self.view addSubview:self.pageControl];
}
- (void)configOwnSubViews {
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.centerX.mas_equalTo(@0);
        
        make.height.mas_equalTo(@20);
        
        make.bottom.mas_equalTo(@-60);
    }];
    
    [self.collectionView registerClass:[CATWelcomeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
#if CATWelcomeOne
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.centerX.mas_equalTo(@0);
        
        make.centerY.mas_equalTo(self.pageControl.mas_centerY);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@CATColor].CGColor;
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateHighlighted];
    
    [self.skipItem setTitleColor: [UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@CATColor]] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndicatorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@CATColor]];
    
    self.pageControl.numberOfPages = CATWelcomeImgs.count;
    
    self.pageControl.currentPageIndicatorTintColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
    
#elif CATWelcomeTwo
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.right.mas_equalTo(@-15);
        
        make.top.mas_equalTo(@60);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@CATColor].CGColor;
    
    [self.skipItem setTitleColor: [UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@CATColor]] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndicatorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@CATColor]];
    
    self.pageControl.numberOfPages = CATWelcomeImgs.count;
    
    self.pageControl.currentPageIndicatorTintColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
    
#elif CATWelcomeThree
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.centerX.mas_equalTo(@0);
        
        make.centerY.mas_equalTo(self.pageControl.mas_centerY);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@CATColor].CGColor;
    
    [self.skipItem setTitleColor: [UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@CATColor]] forState:UIControlStateHighlighted];
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndicatorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@CATColor]];
    
    self.pageControl.numberOfPages = CATWelcomeImgs.count;
    
    self.pageControl.currentPageIndicatorTintColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
#elif CATWelcomeFour
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.right.mas_equalTo(@-15);
        
        make.top.mas_equalTo(@60);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@CATColor].CGColor;
    
    [self.skipItem setTitleColor: [UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateHighlighted];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@CATColor]] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndicatorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@CATColor]];
    
    self.pageControl.numberOfPages = CATWelcomeImgs.count;
    
    self.pageControl.currentPageIndicatorTintColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
#elif CATWelcomeFive
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.centerX.mas_equalTo(@0);
        
        make.centerY.mas_equalTo(self.pageControl.mas_centerY);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@"#ffffff"].CGColor;
    
    [self.skipItem setTitleColor: [UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@CATColor] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@CATColor] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndicatorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@CATColor]];
    
    self.pageControl.numberOfPages = CATWelcomeImgs.count;
    
    self.pageControl.currentPageIndicatorTintColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
#elif CATWelcomeSix
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.right.mas_equalTo(@-15);
        
        make.top.mas_equalTo(@60);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@CATColor].CGColor;
    
    [self.skipItem setTitleColor: [UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@CATColor] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@CATColor] forState:UIControlStateHighlighted];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndicatorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@CATColor]];
    
    self.pageControl.numberOfPages = CATWelcomeImgs.count;
    
    self.pageControl.currentPageIndicatorTintColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
#endif //
    
}

- (void)configOwnProperties {
    [super configOwnProperties];
    
}
- (void)configViewModel {
    
    CATWelcomeBridge *bridge = [CATWelcomeBridge new];
    
    self.bridge = bridge;
    
#if CATWelcomeOne || CATWelcomeThree || CATWelcomeFive
    __weak typeof(self) weakSelf = self;
    
    [bridge createWelcome:self welcomeImgs:CATWelcomeImgs canPageHidden:true welcomeAction:^{
        
        weakSelf.block(weakSelf);
    }];
    
#elif CATWelcomeTwo || CATWelcomeFour || CATWelcomeSix
    __weak typeof(self) weakSelf = self;
    
    [bridge createWelcome:self welcomeImgs:CATWelcomeImgs canPageHidden:false welcomeAction:^{
        
        weakSelf.block(weakSelf);
    }];
    
#endif
    
}
- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    CATWelcomeCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:ip];
    
    cell.icon = data;
    
    return cell;
}
- (void)collectionViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    
}

@end
