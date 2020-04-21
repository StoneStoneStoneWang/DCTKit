//
//  DCTAreaViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "DCTAreaViewController.h"
@import Masonry;
@import SToolsKit;
@import DCTBean;

@interface DCTAreaTableViewCell : DCTBaseTableViewCell

@property (nonatomic ,strong) DCTAreaBean *areaBean;

@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation DCTAreaTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
        
        _titleLabel.lineBreakMode = NSLineBreakByTrunDCTingMiddle;
    }
    return _titleLabel;
    
}
- (void)setAreaBean:(DCTAreaBean *)areaBean {
    _areaBean = areaBean;
    
    self.titleLabel.text = areaBean.name;
    
    self.accessoryType = UITableViewCellAccessoryNone;
    
    if (areaBean.isSelected) {
        
        self.titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndiDCTor;
    } else {
        
        self.titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
    }
    
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    self.backgroundColor = [UIColor whiteColor];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(15);
        
        make.centerY.equalTo(self);
    }];
}
@end

@interface DCTAreaViewController()

@property (nonatomic ,assign) DCTAreaType type;

@property (nonatomic ,copy) DCTAreaBlock block;

@property (nonatomic ,strong) DCTAreaBridge *bridge;
@end

@implementation DCTAreaViewController

+ (instancetype)createAreaWithType:(DCTAreaType)type andAreaBlock:(DCTAreaBlock)block {
    
    return [[self alloc] initWithType:type andAreaBlock:block];
}
- (instancetype)initWithType:(DCTAreaType)type andAreaBlock:(DCTAreaBlock)block {
    
    if (self = [super init]) {
        
        self.type = type;
        
        self.block = block;
    }
    return self;
}

- (void)configOwnSubViews {
    
    [self.tableView registerClass:[DCTAreaTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
}
- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    DCTAreaTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[DCTAreaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.areaBean = data;
    
    return cell;
}

- (void)selectedArea:(NSInteger )sid andBlock:(DCTAreaBlock)block {
    
    switch (self.type) {
        case DCTAreaTypeProvince:
            
            block(self, [self.bridge fetchAreaWithId:sid], self.type, [self.bridge fetchCitys:sid].count);
            break;
        case DCTAreaTypeCity:
            block(self, [self.bridge fetchAreaWithId:sid], self.type, [self.bridge fetchRegions:sid].count);
            break;
        default:
            break;
    }
}
- (void)updateAreas:(NSInteger )sid {
    
    [self.bridge updateDatas:sid areas:@[]];
}
- (void)configViewModel {
    
    self.bridge = [DCTAreaBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createArea:self type:self.type areaAction:^(DCTAreaBean * _Nonnull areaBean, enum DCTAreaType areaType, BOOL hasNext) {
       
        weakSelf.block(weakSelf, areaBean, areaType, hasNext);
    }];

}

- (DCTAreaBean *)fetchAreaWithId:(NSInteger)sid {
    
    return [self.bridge fetchAreaWithId:sid];
}

@end
