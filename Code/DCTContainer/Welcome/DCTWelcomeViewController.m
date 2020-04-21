//
//  DCTWelcomeViewController.m
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "DCTWelcomeViewController.h"
@import Masonry;
@import SToolsKit;
@import DCTBridge;

@interface DCTWelcomeCollectionViewCell ()

@property (nonatomic ,strong) UIImageView *iconImageView;

@end

@implementation DCTWelcomeCollectionViewCell

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

@interface DCTWelcomeViewController ()

@property (nonatomic ,strong) UIButton *skipItem;

@property (nonatomic ,strong) UIPageControl *pageControl;

@property (nonatomic ,strong) DCTWelcomeBridge *bridge;

@property (nonatomic ,copy) DCTWelcomeBlock block;
@end

@implementation DCTWelcomeViewController

+ (instancetype)createWelcomeWithSkipBlock:(DCTWelcomeBlock)block {
    
    return [[self alloc] initWithSkipBlock:block];
}

- (instancetype)initWithSkipBlock:(DCTWelcomeBlock)block {
    
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
    
    [self.collectionView registerClass:[DCTWelcomeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
#if DCTWelcomeOne
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.centerX.mas_equalTo(@0);
        
        make.centerY.mas_equalTo(self.pageControl.mas_centerY);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@DCTColor].CGColor;
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateHighlighted];
    
    [self.skipItem setTitleColor: [UIColor s_transformToColorByHexColorStr:@DCTColor] forState:UIControlStateNormal];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@DCTColor]] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndiDCTorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@DCTColor]];
    
    self.pageControl.numberOfPages = DCTWelcomeImgs.count;
    
    self.pageControl.currentPageIndiDCTorTintColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
    
#elif DCTWelcomeTwo
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.right.mas_equalTo(@-15);
        
        make.top.mas_equalTo(@60);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@DCTColor].CGColor;
    
    [self.skipItem setTitleColor: [UIColor s_transformToColorByHexColorStr:@DCTColor] forState:UIControlStateNormal];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@DCTColor]] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndicatorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@DCTColor]];
    
    self.pageControl.numberOfPages = DCTWelcomeImgs.count;
    
    self.pageControl.currentPageIndicatorTintColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
    
#elif DCTWelcomeThree
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.centerX.mas_equalTo(@0);
        
        make.centerY.mas_equalTo(self.pageControl.mas_centerY);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@DCTColor].CGColor;
    
    [self.skipItem setTitleColor: [UIColor s_transformToColorByHexColorStr:@DCTColor] forState:UIControlStateNormal];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@DCTColor]] forState:UIControlStateHighlighted];
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndiDCTorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@DCTColor]];
    
    self.pageControl.numberOfPages = DCTWelcomeImgs.count;
    
    self.pageControl.currentPageIndiDCTorTintColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
#elif DCTWelcomeFour
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.right.mas_equalTo(@-15);
        
        make.top.mas_equalTo(@60);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@DCTColor].CGColor;
    
    [self.skipItem setTitleColor: [UIColor s_transformToColorByHexColorStr:@DCTColor] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateHighlighted];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@DCTColor]] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndiDCTorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@DCTColor]];
    
    self.pageControl.numberOfPages = DCTWelcomeImgs.count;
    
    self.pageControl.currentPageIndiDCTorTintColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
#elif DCTWelcomeFive
    
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
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@DCTColor] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@DCTColor] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndiDCTorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@DCTColor]];
    
    self.pageControl.numberOfPages = DCTWelcomeImgs.count;
    
    self.pageControl.currentPageIndiDCTorTintColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
#elif DCTWelcomeSix
    
    [self.skipItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(@80);
        
        make.height.mas_equalTo(@30);
        
        make.right.mas_equalTo(@-15);
        
        make.top.mas_equalTo(@60);
    }];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.skipItem setTitle:@"立即体验" forState:UIControlStateHighlighted];
    
    self.skipItem.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@DCTColor].CGColor;
    
    [self.skipItem setTitleColor: [UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@DCTColor] forState:UIControlStateNormal];
    
    [self.skipItem setBackgroundImage:[UIImage s_transformFromHexColor:@DCTColor] forState:UIControlStateHighlighted];
    
    [self.skipItem setTitleColor: [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    self.pageControl.pageIndiDCTorTintColor = [UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@DCTColor]];
    
    self.pageControl.numberOfPages = DCTWelcomeImgs.count;
    
    self.pageControl.currentPageIndiDCTorTintColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
#endif //
    
}

- (void)configOwnProperties {
    [super configOwnProperties];
    
}
- (void)configViewModel {
    
    DCTWelcomeBridge *bridge = [DCTWelcomeBridge new];
    
    self.bridge = bridge;
    
#if DCTWelcomeOne || DCTWelcomeThree || DCTWelcomeFive
    __weak typeof(self) weakSelf = self;
    
    [bridge createWelcome:self welcomeImgs:DCTWelcomeImgs canPageHidden:true welcomeAction:^{
        
        weakSelf.block(weakSelf);
    }];
    
#elif DCTWelcomeTwo || DCTWelcomeFour || DCTWelcomeSix
    __weak typeof(self) weakSelf = self;
    
    [bridge createWelcome:self welcomeImgs:DCTWelcomeImgs canPageHidden:false welcomeAction:^{
        
        weakSelf.block(weakSelf);
    }];
    
#endif
    
}
- (UICollectionViewCell *)configCollectionViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    DCTWelcomeCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:ip];
    
    cell.icon = data;
    
    return cell;
}
- (void)collectionViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    
}

@end
