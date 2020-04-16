//
//  CATSettingViewController.m
//  CATContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "CATSettingViewController.h"
@import SToolsKit;
@import Masonry;
@import SDWebImage;

@interface CATSettingTableViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UISwitch *swiItem;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@end

@implementation CATSettingTableViewCell

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
        
        _swiItem.onTintColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
        
    }
    return _swiItem;
}
- (void)setSetting:(CATSettingBean *)setting {
    //    _setting = setting;
    
    self.swiItem.hidden = true;
    
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.titleLabel.textColor =  [UIColor s_transformToColorByHexColorStr:@"#333333"];
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.bottomLineType = CATBottomLineTypeNormal;
    
    self.subTitleLabel.hidden = true;
    
    self.subTitleLabel.text = setting.subTitle;
    
    self.backgroundColor = [UIColor whiteColor];
    
    switch (setting.type) {
        case CATSettingTypeLogout:
            
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            self.titleLabel.textColor =  [UIColor s_transformToColorByHexColorStr:@CATColor];
            break;
        case CATSettingTypeSpace:
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.bottomLineType = CATBottomLineTypeNone;
            
            self.backgroundColor = [UIColor clearColor];
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
            break;
        case CATSettingTypePush:
            
            self.swiItem.hidden = false;
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
        case CATSettingTypeClear:
            
            self.subTitleLabel.hidden = false;
            
        default:
            break;
    }
    
    self.titleLabel.text = setting.title;
    
#if CATUserInfoOne
    
#elif CATUserInfoTwo
    
#elif CATUserInfoThree
    
    if (setting.type == CATSettingTypeSpace) {
        
        self.backgroundColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
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
@interface CATSettingViewController ()

@property (nonatomic ,strong) CATSettingBridge *bridge;

@property (nonatomic ,copy) CATSettingBlock block;

@end

@implementation CATSettingViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if CATPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}

+ (instancetype)createSettingWithBlock:(CATSettingBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(CATSettingBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}

- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[CATSettingTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    CATSettingTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.setting = data;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [CATSettingBridge new];
    
    __weak typeof(self) weakSelf = self;
    
#if CATUserInfoOne
    
    [self.bridge createSetting:self hasSpace:true settingAction:^(enum CATSettingActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
    
#elif CATUserInfoTwo
    [self.bridge createSetting:self hasPlace:false settingAction:^(enum CATSettingActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
#elif CATUserInfoThree
    
    [self.bridge createSetting:self hasPlace:true settingAction:^(enum CATSettingActionType actionType) {
        
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
    
#if CATUserInfoOne
    [super configOwnProperties];
#elif CATUserInfoTwo
    [super configOwnProperties];
#elif CATUserInfoThree
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
