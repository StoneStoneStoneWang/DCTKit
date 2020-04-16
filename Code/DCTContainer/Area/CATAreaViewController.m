//
//  CATAreaViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "CATAreaViewController.h"
@import Masonry;
@import SToolsKit;
@import CATBean;

@interface CATAreaTableViewCell : CATBaseTableViewCell

@property (nonatomic ,strong) CATAreaBean *areaBean;

@property (nonatomic ,strong) UILabel *titleLabel;

@end

@implementation CATAreaTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
        
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _titleLabel;
    
}
- (void)setAreaBean:(CATAreaBean *)areaBean {
    _areaBean = areaBean;
    
    self.titleLabel.text = areaBean.name;
    
    self.accessoryType = UITableViewCellAccessoryNone;
    
    if (areaBean.isSelected) {
        
        self.titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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

@interface CATAreaViewController()

@property (nonatomic ,assign) CATAreaType type;

@property (nonatomic ,copy) CATAreaBlock block;

@property (nonatomic ,strong) CATAreaBridge *bridge;
@end

@implementation CATAreaViewController

+ (instancetype)createAreaWithType:(CATAreaType)type andAreaBlock:(CATAreaBlock)block {
    
    return [[self alloc] initWithType:type andAreaBlock:block];
}
- (instancetype)initWithType:(CATAreaType)type andAreaBlock:(CATAreaBlock)block {
    
    if (self = [super init]) {
        
        self.type = type;
        
        self.block = block;
    }
    return self;
}

- (void)configOwnSubViews {
    
    [self.tableView registerClass:[CATAreaTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
}
- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    CATAreaTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[CATAreaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.areaBean = data;
    
    return cell;
}

- (void)selectedArea:(NSInteger )sid andBlock:(CATAreaBlock)block {
    
    switch (self.type) {
        case CATAreaTypeProvince:
            
            block(self, [self.bridge fetchAreaWithId:sid], self.type, [self.bridge fetchCitys:sid].count);
            break;
        case CATAreaTypeCity:
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
    
    self.bridge = [CATAreaBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createArea:self type:self.type areaAction:^(CATAreaBean * _Nonnull areaBean, enum CATAreaType areaType, BOOL hasNext) {
       
        weakSelf.block(weakSelf, areaBean, areaType, hasNext);
    }];

}

- (CATAreaBean *)fetchAreaWithId:(NSInteger)sid {
    
    return [self.bridge fetchAreaWithId:sid];
}

@end
