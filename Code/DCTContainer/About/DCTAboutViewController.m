//
//  DCTAboutViewController.m
//  DCTContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "DCTAboutViewController.h"
@import SToolsKit;
@import Masonry;
@interface DCTAboutTableHeaderView()

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *titleLabel;
#if DCTUserInfoOne

#elif DCTUserInfoTwo

#elif DCTUserInfoThree

@property (nonatomic ,strong) UIView *topLine;

@property (nonatomic ,strong) UIView *bottomLine;
#endif


@end

@implementation DCTAboutTableHeaderView

#if DCTUserInfoOne

#elif DCTUserInfoTwo

#elif DCTUserInfoThree

- (UIView *)topLine {
    
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}
- (UIView *)bottomLine {
    
    if (!_bottomLine) {
        
        _bottomLine = [UIView new];
    }
    return _bottomLine;
}
#endif


- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @DCTLogoIcon]];
        
        _iconImageView.layer.cornerRadius = 30;
        
        _iconImageView.layer.masksToBounds = true;
    }
    return _iconImageView;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
        
        _titleLabel.text = [NSString stringWithFormat:@"%@: %@", [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"],[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]];
        
    }
    return _titleLabel;
}
- (void)commitInit {
    
    [self addSubview:self.iconImageView];
    
    [self addSubview:self.titleLabel];
    
    
#if DCTUserInfoOne
    self.backgroundColor = [UIColor whiteColor];
#elif DCTUserInfoTwo
    self.backgroundColor = [UIColor whiteColor];
#elif DCTUserInfoThree
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.topLine];
    
    [self addSubview:self.bottomLine];
    
    self.topLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
    
    self.bottomLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
#endif
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
#if DCTUserInfoOne
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        
        make.width.height.mas_equalTo(60);
        
        make.left.mas_equalTo(15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
    }];
#elif DCTUserInfoTwo
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.centerY.equalTo(self);
        
        make.width.height.mas_equalTo(60);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        
        make.top.equalTo(self.iconImageView.mas_bottom).offset(5);
    }];
#elif DCTUserInfoThree
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(@60);
        
        make.centerX.equalTo(self);
        
        make.top.mas_equalTo(15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        
        make.bottom.equalTo(self);
        
        make.top.equalTo(self.iconImageView.mas_bottom);
    }];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(8);
        
        make.top.equalTo(self);
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(8);
        
        make.bottom.equalTo(self);
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
    }];
#endif
}

@end
@interface DCTAboutTableViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@end


@implementation DCTAboutTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = [UILabel new];
        
        _subTitleLabel.font = [UIFont systemFontOfSize:15];
        
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        _subTitleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
    }
    return _subTitleLabel;
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.subTitleLabel];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
}
- (void)setAbout:(DCTAboutBean *)about {
    
    self.titleLabel.text = about.title;
    
    self.subTitleLabel.text = about.subTitle;
    
    self.bottomLineType = DCTBottomLineTypeNormal;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (about.type == DCTAboutTypeSpace) {
        
        self.bottomLineType = DCTBottomLineTypeNone;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    
#if DCTUserInfoOne
    
#elif DCTUserInfoTwo
    
#elif DCTUserInfoThree
    
    
#endif
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(15);
        
        make.centerY.equalTo(self);
    }];
}
@end

@interface DCTAboutViewController ()

@property (nonatomic ,strong) DCTAboutBridge *bridge;

@end

@implementation DCTAboutViewController

+ (instancetype)createAbout {
    
    return [self new];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if DCTPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[DCTAboutTableViewCell class] forCellReuseIdentifier:@"cell"];
    
#if DCTUserInfoOne
    self.headerView = [[DCTAboutTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
#elif DCTUserInfoTwo
    self.headerView = [[DCTAboutTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 120)];
#elif DCTUserInfoThree
    self.headerView = [[DCTAboutTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 120)];
#endif
    
    self.tableView.tableHeaderView = self.headerView;
    
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    DCTAboutTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.about = data;
    
    cell.bottomLineType = DCTBottomLineTypeNormal;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [DCTAboutBridge new];
#if DCTUserInfoOne
    [self.bridge createAbout:self hasSpace:true];
#elif DCTUserInfoTwo
    
    [self.bridge createAbout:self hasSpace:true];
#elif DCTUserInfoThree
    [self.bridge createAbout:self hasPlace:false];
#endif
    
}

- (void)configNaviItem {
    
    self.title = @"关于我们";
}

- (BOOL)canPanResponse {
    
    return true;
}
- (void)configOwnProperties {
    
#if DCTUserInfoOne
    [super configOwnProperties];
#elif DCTUserInfoTwo
    [super configOwnProperties];
#elif DCTUserInfoThree
    [super configOwnProperties];
#endif
    
}
@end
