//
//  CATBlackViewController.m
//  CATContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "CATBlackViewController.h"
@import SToolsKit;
@import Masonry;
@import SDWebImage;
@import JXTAlertManager;

@interface CATBlackTableViewCell()

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@end

@implementation CATBlackTableViewCell

- (UIImageView *)iconImageView {
    
    if (!_iconImageView) {
        
        _iconImageView = [UIImageView new];
        
        _iconImageView.contentMode = UIViewContentModeCenter;
        
        _iconImageView.layer.cornerRadius = 5;
        
        _iconImageView.layer.masksToBounds = true;
    }
    return _iconImageView;
}
- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        
        _nameLabel = [UILabel new];
        
        _nameLabel.font = [UIFont systemFontOfSize:15];
        
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        
        _nameLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#333333"];
        
    }
    return _nameLabel;
}
- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        
        _timeLabel = [UILabel new];
        
        _timeLabel.font = [UIFont systemFontOfSize:13];
        
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        
        _timeLabel.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
    }
    return _timeLabel;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self commitInit];
    }
    return self;
}

- (void)commitInit {
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.iconImageView];
    
    [self.contentView addSubview:self.nameLabel];
    
    [self.contentView addSubview:self.timeLabel];
}

- (void)setBlack:(CATBlackBean *)black {
//    _black = black;
    
    self.timeLabel.text = [[NSString stringWithFormat:@"%ld",black.intime / 1000] s_convertToDate:SDateTypeDateStyle];
    
    self.nameLabel.text = black.users.nickname;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200,h_200",black.users.headImg]] placeholderImage:[UIImage imageNamed:@CATLogoIcon] options:SDWebImageRefreshCached];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat w = CGRectGetHeight(self.bounds) - 30;
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.mas_equalTo(15);
        
        make.bottom.mas_equalTo(-15);
        
        make.width.mas_equalTo(w);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.bottom.equalTo(self.iconImageView.mas_centerY).offset(-3);
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        
        make.top.equalTo(self.iconImageView.mas_centerY).offset(3);
    }];
}
@end

@interface CATBlackViewController ()

@property (nonatomic ,strong) CATBlackBridge *bridge;

@property (nonatomic ,copy) CATBlackBlock block;
@end

@implementation CATBlackViewController

+ (instancetype)createBlackWithBlock:(CATBlackBlock)block {
    
    return [[self alloc] initWithBlackBlock:block];
}
- (instancetype)initWithBlackBlock:(CATBlackBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[CATBlackTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView.mj_header beginRefreshing];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    CATBlackTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.black = data;
    
    return cell;
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    return 80;
}
- (void)configViewModel {
    
    self.bridge = [CATBlackBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createBlack:self :^(CATBlackBean * _Nonnull black, NSIndexPath * _Nonnull ip) {
        
        [weakSelf alertShow:black andIp:ip];
    }];
}
- (void)alertShow:(CATBlackBean *)black andIp:(NSIndexPath *)ip {
    
    __weak typeof(self) weakSelf = self;
    
    [self jxt_showAlertWithTitle:[NSString stringWithFormat:@"点击确定移除%@",black.users.nickname] message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        
        alertMaker
        .addActionCancelTitle(@"取消")
        .addActionDefaultTitle(@"确定");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
       
        if ([action.title isEqualToString:@"确定"]) {
            
            [weakSelf.bridge removeBlack:black :ip :weakSelf.block];
        }
    }];
}
- (void)configNaviItem {
    
    self.title = @"黑名单";
}

- (BOOL)canPanResponse {
    
    return true;
}

@end
