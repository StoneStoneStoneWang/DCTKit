//
//  CATUserInfoViewController.m
//  CATContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "CATUserInfoViewController.h"
@import SToolsKit;
@import Masonry;
@import CoreServices;
@import JXTAlertManager;
@import WLToolsKit;
@import SDWebImage;
@import ZDatePicker;

@interface CATUserInfoTableViewCell()

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *subTitleLabel;

@end
@implementation CATUserInfoTableViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @CATLogoIcon]];
        
        _iconImageView.layer.cornerRadius = 5;
        
        _iconImageView.layer.masksToBounds = true;
        
        _iconImageView.layer.borderWidth = 1;
        
        _iconImageView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@CATColor].CGColor;
    }
    return _iconImageView;
}

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
        
        _subTitleLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#666666"];
    }
    return _subTitleLabel;
}
- (void)commitInit {
    [super commitInit];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.subTitleLabel];
    
    [self.contentView addSubview:self.iconImageView];
}

- (void)setUserInfo:(CATUserInfoBean *)userInfo {
    
    self.titleLabel.text = userInfo.title;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.bottomLineType = CATBottomLineTypeNormal;
    
    self.iconImageView.hidden = true;
    
    self.subTitleLabel.text = userInfo.subtitle;
    
    self.subTitleLabel.hidden = false;
    
    switch (userInfo.type) {
        case CATUserInfoTypeSex:
            
            
            break;
        case CATUserInfoTypeSpace:
            
            self.backgroundColor = [UIColor clearColor];
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.subTitleLabel.hidden = true;
            
            break;
        case CATUserInfoTypeHeader:
            
            self.accessoryType = UITableViewCellAccessoryNone;
            
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            
            self.iconImageView.hidden = false;
            
            [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200,h_200",userInfo.subtitle]] placeholderImage:[UIImage imageNamed:@CATLogoIcon] options:SDWebImageRefreshCached];
            
            self.subTitleLabel.hidden = true;
            
            break;
        case CATUserInfoTypePhone:
        case CATUserInfoTypeName:
            
            if ([NSString s_validPhone:userInfo.subtitle]) {
                
                NSString * result = [userInfo.subtitle stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
                
                self.subTitleLabel.text = result;
            }
            break;
        case CATUserInfoTypeBirth:
            
            self.subTitleLabel.text = [userInfo.subtitle componentsSeparatedByString:@" "].firstObject;
            
            break;
        default:
            break;
    }
    
#if CATUserInfoOne
    
#elif CATUserInfoTwo
    
#elif CATUserInfoThree
    
    if (userInfo.type == CATUserInfoTypeSpace) {
        
        self.backgroundColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
    } else {
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
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
        
        make.left.equalTo(self.mas_centerX);
        
        make.right.mas_equalTo(-15);
        
        make.centerY.equalTo(self);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(-15);
        
        make.width.height.mas_equalTo(60);
        
        make.centerY.equalTo(self);
    }];
}
@end

@interface CATUserInfoViewController ()<UIImagePickerControllerDelegate ,UINavigationControllerDelegate>

@property (nonatomic ,strong) CATUserInfoBridge *bridge;

@property (nonatomic ,strong) ZDatePicker *picker;

@property (nonatomic ,strong) UIImagePickerController *imagePicker;

@property (nonatomic ,copy) CATUserInfoBlock block;
@end

@implementation CATUserInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if CATPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}

+ (instancetype)createUserInfoWithBlock:(CATUserInfoBlock )block {
    
    return [[self alloc] initWithUserInfoBlock:block];
}
- (instancetype)initWithUserInfoBlock:(CATUserInfoBlock )block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (UIImagePickerController *)imagePicker {
    
    if (!_imagePicker) {
        
        _imagePicker = [UIImagePickerController new];
        
        _imagePicker.allowsEditing = false;
        
        _imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        
        _imagePicker.delegate = self;
    }
    return _imagePicker;
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
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[CATUserInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    CATUserInfoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.userInfo = data;
    
    return cell;
}

- (void)configViewModel {
    
    self.bridge = [CATUserInfoBridge new];
    
#if CATUserInfoOne
    
    [self.bridge createUserInfo:self hasSpace:true];
#elif CATUserInfoTwo
    [self.bridge createUserInfo:self hasPlace:false];
#elif CATUserInfoThree
    [self.bridge createUserInfo:self hasPlace:true];
#endif
    
}

- (void)configNaviItem {
    
    self.title = @"用户资料";
}
- (void)tableViewSelectData:(id)data forIndexPath:(NSIndexPath *)ip {
    
    CATUserInfoBean *userInfo = (CATUserInfoBean *)data;
    
    switch (userInfo.type) {
        case CATUserInfoTypeName:
        {
            self.block(CATUserInfoActionTypeName, self);
            
        }
            break;
        case CATUserInfoTypeSignature:
        {
            
            self.block(CATUserInfoActionTypeSignature, self);
        }
            break;
        case CATUserInfoTypeSex:
        {
            __weak typeof(self) weakSelf = self;
            
            [self jxt_showActionSheetWithTitle:@"选择性别" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                
                alertMaker.
                addActionCancelTitle(@"取消").
                addActionDefaultTitle(@"男").
                addActionDefaultTitle(@"女");
            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                
                if ([action.title isEqualToString:@"取消"]) {
                    
                }
                else if ([action.title isEqualToString:@"男"]) {
                    
                    [weakSelf.bridge updateUserInfoWithType:CATUserInfoTypeSex value:@"1" action:^{
                        
                        [weakSelf.bridge updateUserInfo:CATUserInfoTypeSex value:@"1"];
                    }];
                    
                } else if ([action.title isEqualToString:@"女"]) {
                    
                    [weakSelf.bridge updateUserInfoWithType:CATUserInfoTypeSex value:@"2" action:^{
                        
                        [weakSelf.bridge updateUserInfo:CATUserInfoTypeSex value:@"2"];
                        
                    }];
                }
            }];
        }
            break;
        case CATUserInfoTypeBirth:
        {
            if (!self.picker) {
                
                self.picker = [[ZDatePicker alloc] initWithTextColor:[UIColor s_transformToColorByHexColorStr:@"#666666"] buttonColor:[UIColor s_transformToColorByHexColorStr:@CATColor] font:[UIFont systemFontOfSize:15] locale:[NSLocale localeWithLocaleIdentifier:@"zh-Hans"] showCancelButton:true];
            }
            
            __weak typeof(self) weakSelf = self;
            
            [self.picker show:@"" doneButtonTitle:@"完成" cancelButtonTitle:@"取消" defaultDate:[NSDate date] minimumDate:nil maximumDate:[NSDate date] datePickerMode:UIDatePickerModeDate callback:^(NSDate * _Nullable date) {
                
                if (date) {
                    
                    [weakSelf.bridge updateUserInfoWithType:CATUserInfoTypeBirth value:[NSString stringWithFormat:@"%ld",(NSInteger)date.timeIntervalSince1970] action:^{
                        
                        [weakSelf.bridge updateUserInfo:CATUserInfoTypeBirth value:[NSString stringWithFormat:@"%ld",(NSInteger)date.timeIntervalSince1970]];
                    }];
                }
            }];
        }
            break;
        case CATUserInfoTypeHeader:
        {
            
            __weak typeof(self) weakSelf = self;
            
            [self jxt_showActionSheetWithTitle:@"选择头像图片" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                
                alertMaker.
                addActionCancelTitle(@"取消").
                addActionDefaultTitle(@"相册").
                addActionDefaultTitle(@"相机");
            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                
                if ([action.title isEqualToString:@"取消"]) {
                    
                }
                else if ([action.title isEqualToString:@"相册"]) {
                    
                    weakSelf.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    
                    [weakSelf presentViewController:weakSelf.imagePicker animated:true completion:nil];
                    
                } else if ([action.title isEqualToString:@"相机"]) {
                    
                    weakSelf.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    
                    [weakSelf presentViewController:weakSelf.imagePicker animated:true completion:nil];
                }
            }];
        }
            break;
        default:
            break;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    __weak typeof(self) weakSelf = self;
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    if (picker.allowsEditing) {
        
        originalImage = info[UIImagePickerControllerEditedImage];
    }
    
    [self.bridge updateHeader:[UIImage compressImageWithImage:originalImage andMaxLength:500 * 1024] action:^{
        
        [weakSelf.tableView reloadData];
    }];
    
    [picker dismissViewControllerAnimated:true completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:true completion:nil];
}

- (BOOL)canPanResponse {
    
    return true ;
}

- (void)updateName:(NSString *)name {
    
    [self.bridge updateUserInfo:CATUserInfoTypeName value:name ];
}
- (void)updateSignature:(NSString *)signature {
    
    [self.bridge updateUserInfo:CATUserInfoTypeSignature value:signature];
}

@end
