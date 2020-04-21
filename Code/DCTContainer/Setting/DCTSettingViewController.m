//
//  DCTSettingViewController.m
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "DCTSettingViewController.h"
@import SToolsKit;
@import Masonry;
@import SDWebImage;

@interface DCTSettingTableViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UISwitch *swiItem;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@end

@implementation DCTSettingTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
    }
    return _titleLabel;
}
- (UILabel *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = [UILabel new];
        
        _subTitleLabel.font = [UIFont systemFontOfSize:15];
        
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        _subTitleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
    }
    return _subTitleLabel;
}
- (UISwitch *)swiItem {
    if (!_swiItem) {
        
        _swiItem = [[UISwitch alloc] initWithFrame:CGRectZero];
        
        _swiItem.onTintColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
        
        _swiItem.thumbTintColor = [UIColor whiteColor];
    }
    return _swiItem;
}
- (void)setSetting:(DCTSettingBean *)setting {
    //    _setting = setting;
    
    self.swiItem.hidden = true;
    
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.titleLabel.textColor =  [UIColor s_transformToColorByHexColorStr:@"#ffffff"];
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.bottomLineType = DCTBottomLineTypeNormal;
    
    self.subTitleLabel.hidden = true;
    
    self.subTitleLabel.text = setting.subTitle;
    
    self.backgroundColor = [UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff30"];
    
    switch (setting.type) {
        case DCTSettingTypeLogout:
            
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            self.titleLabel.textColor =  [UIColor s_transformToColorByHexColorStr:@DCTColor];
            break;
        case DCTSettingTypeSpace:
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.bottomLineType = DCTBottomLineTypeNone;
            
            self.backgroundColor = [UIColor clearColor];
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
            break;
        case DCTSettingTypePush:
            
            self.swiItem.hidden = false;
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
        case DCTSettingTypeClear:
            
            self.subTitleLabel.hidden = false;
            
        default:
            break;
    }
    
    self.titleLabel.text = setting.title;
    
#if DCTUserInfoOne
    
#elif DCTUserInfoTwo
    
#elif DCTUserInfoThree
    
    if (setting.type == DCTSettingTypeSpace) {
        
        self.backgroundColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
    } else {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
#endif
    
}


- (void)commitInit {
    [super commitInit];
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.swiItem];
    
    [self.contentView addSubview:self.subTitleLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    [self.swiItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(@-15);
        
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}
@end
@interface DCTSettingViewController ()

@property (nonatomic ,strong) DCTSettingBridge *bridge;

@property (nonatomic ,copy) DCTSettingBlock block;

@end

@implementation DCTSettingViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if DCTPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}

+ (instancetype)createSettingWithBlock:(DCTSettingBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(DCTSettingBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[DCTSettingTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@DCTBackground]];
    
    background.frame = self.view.bounds;
    
    self.tableView.backgroundView = background;
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    DCTSettingTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.setting = data;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [DCTSettingBridge new];
    
    __weak typeof(self) weakSelf = self;
    
#if DCTUserInfoOne
    
    [self.bridge createSetting:self hasSpace:true settingAction:^(enum DCTSettingActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
    
#elif DCTUserInfoTwo
    
    [self.bridge createSetting:self hasSpace:true settingAction:^(enum DCTSettingActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
#elif DCTUserInfoThree
    
    [self.bridge createSetting:self hasPlace:true settingAction:^(enum DCTSettingActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
#endif
    
    [self updateCache];
}

- (void)updateTableData {
    
    [self.bridge updateTableData:true];
    
    [self updateCache];
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
- (void)updateCache {
    
    NSString *cache = [NSString stringWithFormat:@"%.2fM",[[SDImageCache sharedImageCache] totalDiskSize]/1024.0/1024.0];
    
    [self.bridge updateCache:cache];
}
- (void)configNaviItem {
    
    self.title = @"设置";
}
- (BOOL)canPanResponse {
    
    return true;
}

@end
