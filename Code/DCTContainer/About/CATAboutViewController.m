//
//  CATAboutViewController.m
//  CATContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "CATAboutViewController.h"
@import SToolsKit;
@import Masonry;
@interface CATAboutTableHeaderView()

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *titleLabel;
#if CATUserInfoOne

#elif CATUserInfoTwo

#elif CATUserInfoThree

@property (nonatomic ,strong) UIView *topLine;

@property (nonatomic ,strong) UIView *bottomLine;
#endif


@end

@implementation CATAboutTableHeaderView

#if CATUserInfoOne

#elif CATUserInfoTwo

#elif CATUserInfoThree

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
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @CATLogoIcon]];
        
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
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
        
        _titleLabel.text = [NSString stringWithFormat:@"%@: %@", [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"],[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]];
        
    }
    return _titleLabel;
}
- (void)commitInit {
    
    [self addSubview:self.iconImageView];
    
    [self addSubview:self.titleLabel];
    
    
#if CATUserInfoOne
    self.backgroundColor = [UIColor whiteColor];
#elif CATUserInfoTwo
    self.backgroundColor = [UIColor whiteColor];
#elif CATUserInfoThree
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.topLine];
    
    [self addSubview:self.bottomLine];
    
    self.topLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
    
    self.bottomLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
#endif
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
#if CATUserInfoOne
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        
        make.width.height.mas_equalTo(60);
        
        make.left.mas_equalTo(15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
    }];
#elif CATUserInfoTwo
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.centerY.equalTo(self);
        
        make.width.height.mas_equalTo(60);
        
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        
        make.top.equalTo(self.iconImageView.mas_bottom).offset(5);
    }];
#elif CATUserInfoThree
    
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
@interface CATAboutTableViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@end


@implementation CATAboutTableViewCell

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
- (void)setAbout:(CATAboutBean *)about {
    
    self.titleLabel.text = about.title;
    
    self.subTitleLabel.text = about.subTitle;
    
    self.bottomLineType = CATBottomLineTypeNormal;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (about.type == CATAboutTypeSpace) {
        
        self.bottomLineType = CATBottomLineTypeNone;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    
#if CATUserInfoOne
    
#elif CATUserInfoTwo
    
#elif CATUserInfoThree
    
    
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

@interface CATAboutViewController ()

@property (nonatomic ,strong) CATAboutBridge *bridge;

@end

@implementation CATAboutViewController

+ (instancetype)createAbout {
    
    return [self new];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if CATPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[CATAboutTableViewCell class] forCellReuseIdentifier:@"cell"];
    
#if CATUserInfoOne
    self.headerView = [[CATAboutTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
#elif CATUserInfoTwo
    self.headerView = [[CATAboutTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 120)];
#elif CATUserInfoThree
    self.headerView = [[CATAboutTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 120)];
#endif
    
    self.tableView.tableHeaderView = self.headerView;
    
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    CATAboutTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.about = data;
    
    cell.bottomLineType = CATBottomLineTypeNormal;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [CATAboutBridge new];
#if CATUserInfoOne
    [self.bridge createAbout:self hasSpace:true];
#elif CATUserInfoTwo
    [self.bridge createAbout:self hasPlace:true];
#elif CATUserInfoThree
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
    
#if CATUserInfoOne
    [super configOwnProperties];
#elif CATUserInfoTwo
    [super configOwnProperties];
#elif CATUserInfoThree
    [super configOwnProperties];
#endif
    
}
@end
