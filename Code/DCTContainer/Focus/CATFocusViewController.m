//
//  CATFocusViewController.m
//  CATContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "CATFocusViewController.h"
@import SToolsKit;
@import Masonry;
@import SDWebImage;
@import JXTAlertManager;

@interface CATFocusTableViewCell()

@property (nonatomic ,strong) UIImageView *iconImageView;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UILabel *timeLabel;

@end

@implementation CATFocusTableViewCell

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
- (void)setFocus:(CATFocusBean *)focus {
    
    self.timeLabel.text = [[NSString stringWithFormat:@"%ld",focus.intime / 1000] s_convertToDate:SDateTypeDateStyle];
    
    self.nameLabel.text = focus.users.nickname;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?x-oss-process=image/resize,w_200,h_200",focus.users.headImg]] placeholderImage:[UIImage imageNamed:@CATLogoIcon] options:SDWebImageRefreshCached];
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

@interface CATFocusViewController ()

@property (nonatomic ,strong) CATFocusBridge *bridge;

@property (nonatomic ,copy) CATFocusBlock block;
@end

@implementation CATFocusViewController

+ (instancetype)createBlackWithBlock:(CATFocusBlock)block {
    
    return [[self alloc] initWithBlackBlock:block];
}
- (instancetype)initWithBlackBlock:(CATFocusBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    [self.tableView registerClass:[CATFocusTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView.mj_header beginRefreshing];
}

- (UITableViewCell *)configTableViewCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    CATFocusTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.focus = data;
    
    return cell;
}

- (CGFloat)caculateForCell:(id)data forIndexPath:(NSIndexPath *)ip {
    
    return 80;
}
- (void)configViewModel {
    
    self.bridge = [CATFocusBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createFocus:self :^(CATFocusBean * _Nonnull focus, NSIndexPath * _Nonnull ip) {
        
        [weakSelf alertShow:focus andIp:ip];
    }] ;
    
}
- (void)alertShow:(CATFocusBean *)focus andIp:(NSIndexPath *)ip {
    
    __weak typeof(self) weakSelf = self;
    
    [self jxt_showAlertWithTitle:[NSString stringWithFormat:@"点击确定取消对%@的关注",focus.users.nickname] message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        
        alertMaker
        .addActionCancelTitle(@"取消")
        .addActionDefaultTitle(@"确定");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        
        if ([action.title isEqualToString:@"确定"]) {
            
            [weakSelf.bridge removeFocus:focus :ip :weakSelf.block ];
            
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
