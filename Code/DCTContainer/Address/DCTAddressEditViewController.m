//
//  DCTAddressEditViewController.m
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

#import "DCTAddressEditViewController.h"
@import SToolsKit;
@import DCTBridge;
@import Masonry;
@import JXTAlertManager;
@import DCTTextField;

@protocol DCTAddressEditTableViewCellDelegate <NSObject>

- (void)onSwitchTap:(BOOL)value;

- (void)onTextChanged:(NSString *)changed andType:(DCTAddressEditType )type;

@end

@interface DCTAddressEditTableViewCell ()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) DCTBaseTextField *subTitleLabel;

@property (nonatomic ,strong) DCTAddressEditBean *addressEdit;

@property (nonatomic ,strong) UISwitch *swi;

@property (nonatomic ,weak) id<DCTAddressEditTableViewCellDelegate> mDelegate;

@end

@implementation DCTAddressEditTableViewCell

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [UILabel new];
        
        _titleLabel.font = [UIFont systemFontOfSize:15];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
    }
    return _titleLabel;
}

- (DCTBaseTextField *)subTitleLabel {
    
    if (!_subTitleLabel) {
        
        _subTitleLabel = [[DCTBaseTextField alloc] initWithFrame:CGRectZero];
        
        _subTitleLabel.font = [UIFont systemFontOfSize:15];
        
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        _subTitleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
    }
    return _subTitleLabel;
}
- (UISwitch *)swi {
    
    if (!_swi) {
        
        _swi = [UISwitch new];
        
        _swi.on = true;
    }
    return _swi;
}
- (void)setAddressEdit:(DCTAddressEditBean *)addressEdit {
    _addressEdit = addressEdit;
    self.titleLabel.text = addressEdit.title;
    
    self.bottomLineType = DCTBottomLineTypeNormal;
    
    self.subTitleLabel.placeholder = addressEdit.placeholder;
    
    self.accessoryType = UITableViewCellAccessoryNone;
    
    self.subTitleLabel.userInteractionEnabled = true;
    
    self.subTitleLabel.text = addressEdit.value;
    
    self.swi.hidden = true;
    
    [self.subTitleLabel DCT_editType:DCTTextFiledEditTypeDefault];
    
    [self.subTitleLabel DCT_maxLength:999];
    
    switch (addressEdit.type) {
        case DCTAddressEditTypeName:
            
            
            break;
        case DCTAddressEditTypeDef:
            
            self.subTitleLabel.userInteractionEnabled = false;
            
            self.swi.hidden = false;
            
            break;
        case DCTAddressEditTypeArea:
            
            self.accessoryType = UITableViewCellAccessoryDisclosureIndiDCTor;
            
            self.subTitleLabel.userInteractionEnabled = false;
            
            NSLog(@"name =%@======" ,addressEdit.rArea.name);
            
            if (addressEdit.rArea.name && ![addressEdit.rArea.name isEqualToString:@""]) {
                
                self.subTitleLabel.text = [NSString stringWithFormat:@"%@%@%@",addressEdit.pArea.name,addressEdit.cArea.name,addressEdit.rArea.name];
                
            } else {
                
                self.subTitleLabel.text = [NSString stringWithFormat:@"%@%@",addressEdit.pArea.name,addressEdit.cArea.name];
                
            }
            break;
        case DCTAddressEditTypePhone:
            
            [self.subTitleLabel DCT_editType:DCTTextFiledEditTypePhone];
            
            [self.subTitleLabel DCT_maxLength:11];
            break;
        default:
            break;
    }
    
}


- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.subTitleLabel];
    
    [self.contentView addSubview:self.swi];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.swi addTarget:self action:@selector(onSwitchValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    
    __weak typeof(self) weakSelf = self;
    
    [self.subTitleLabel DCT_textChanged:^(DCTBaseTextField * _Nonnull tf) {
        
        [weakSelf.mDelegate onTextChanged:tf.text andType:weakSelf.addressEdit.type];
    }];
    
}

- (void)onSwitchValueChanged:(UISwitch *)swi {
    
    [self.mDelegate onSwitchTap:swi.isOn];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.width.mas_equalTo(CGRectGetWidth(self.bounds) / 2);
        
        make.centerY.equalTo(self);
    }];
    
    [self.swi mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self);
        
        make.width.mas_equalTo(50);
        
        make.height.mas_equalTo(25);
    }];
}

@end

@interface DCTAddressEditViewController() <DCTAddressEditTableViewCellDelegate>

@property (nonatomic ,strong) DCTAddressEditBridge *bridge;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) DCTAddressBean *addressBean;

@property (nonatomic ,copy) DCTAddressEditBlock block;

@end

@implementation DCTAddressEditViewController

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateNormal];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateSelected];
        
        _completeItem.titleLabel.font = [UIFont systemFontOfSize:15];
        
        if ([@DCTColor isEqualToString:@"#ffffff"]) {
            
            [_completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#666666"] forState:UIControlStateNormal];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#66666680"] forState:UIControlStateHighlighted];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#66666650"] forState:UIControlStateDisabled];
            
        } else {
            
            [_completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff80"] forState:UIControlStateHighlighted];
            
            [_completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff50"] forState:UIControlStateDisabled];
        }
    }
    return _completeItem;
}
+ (instancetype)creatAddressEditWithAddressBean:(DCTAddressBean *)addressBean andAddressEditBlock:(DCTAddressEditBlock)block {
    
    return [[self alloc] initWithAddressBean:addressBean andAddressEditBlock:block];
}
- (instancetype)initWithAddressBean:(DCTAddressBean *)addressBean andAddressEditBlock:(DCTAddressEditBlock)block {
    
    if (self = [super init]) {
        
        self.addressBean = addressBean;
        
        self.block = block;
    }
    return self;
}

- (void)configOwnSubViews {
    
    [self.tableView registerClass:[DCTAddressEditTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    DCTAddressEditTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[DCTAddressEditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.addressEdit = data;
    
    cell.mDelegate = self;
    
    return cell;
    
}
- (void)onSwitchTap:(BOOL)value {
    
    [self.bridge updateAddressEditDefWithIsDef:value];
}
- (void)onTextChanged:(NSString *)changed andType:(DCTAddressEditType)type {
    
    [self.bridge updateAddressEditWithType:type value:changed];
}

- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    DCTAddressEditBean *edit = (DCTAddressEditBean *)data;
    
    switch (edit.type) {
        case DCTAddressEditTypeArea:
        {
            self.block(self, DCTAddressEditActionTypeArea,self.addressBean, edit);
        }
            break;
            
        default:
            break;
    }
}
- (void)updateAddressEditArea:(DCTAddressEditBean *)addressEditBean {
    
    [self updatePArea:addressEditBean.pArea andCArea:addressEditBean.cArea andRArea:addressEditBean.rArea];
}
- (void)updatePArea:(DCTAreaBean *)pArea andCArea:(DCTAreaBean *)cArea andRArea:(DCTAreaBean *)rArea {
    
    [self.bridge updateAddressEditAreaWithPid:pArea.areaId pName:pArea.name cid:cArea.areaId cName:cArea.name rid:rArea.areaId rName:rArea.name];
}
- (void)configNaviItem {
    
    self.title = self.addressBean ? @"编辑地址" : @"新增地址";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
}
- (void)configViewModel {
    
    self.bridge = [DCTAddressEditBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createAddressEdit:self temp:self.addressBean editAction:^(DCTAddressBean * _Nullable addressBean) {
        
        weakSelf.block(weakSelf,DCTAddressEditActionTypeCompleted, addressBean, nil);
    }];
    
    if (self.addressBean) {
        
        [self.bridge updateAddressEditDefWithIsDef:self.addressBean.isdel];
        
        [self.bridge updateAddressEditWithType:DCTAddressEditTypeName value:self.addressBean.name];
        
        [self.bridge updateAddressEditWithType:DCTAddressEditTypePhone value:self.addressBean.phone];
        
        [self.bridge updateAddressEditWithType:DCTAddressEditTypeDetail value:self.addressBean.addr];
        
        [self.bridge updateAddressEditAreaWithPid:self.addressBean.plcl pName:self.addressBean.plclne cid:self.addressBean.city cName:self.addressBean.cityne rid:self.addressBean.region rName:self.addressBean.regionne];
        
        [self.tableView reloadData];
    }
    
}
@end
