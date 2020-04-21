//
//  DCTRegViewController.m
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "DCTRegViewController.h"
@import DCTTextField;
@import SToolsKit;
@import Masonry;
#if DCTLoginTwo

@import DCTDraw;

#endif

@interface DCTRegViewController ()
@property (nonatomic ,strong) DCTRegBridge *bridge;

@property (nonatomic ,strong) DCTLeftImageTextField *phone;

@property (nonatomic ,strong) DCTVCodeImageTextField *vcode;

@property (nonatomic ,strong) UIButton *loginItem;

@property (nonatomic ,strong) UIButton *proItem;

@property (nonatomic ,strong) UIButton *backLoginItem;

@property (nonatomic ,copy) DCTRegBlock block;
#if DCTLoginOne

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#elif DCTLoginTwo

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) DCTDrawView *drawView;

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#elif DCTLoginThree

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) UIView *topLine;

@property (nonatomic ,strong) UIView *bottomLine;

#elif DCTLoginFour

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#else

#endif
@end

@implementation DCTRegViewController

+ (instancetype)createRegWithBlock:(DCTRegBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(DCTRegBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (DCTLeftImageTextField *)phone {
    
    if (!_phone) {
        
        _phone = [[DCTLeftImageTextField alloc] initWithFrame:CGRectZero];
        
        _phone.tag = 201;
        
        _phone.leftImageName = @DCTPhoneIcon;
        
        _phone.placeholder = @"请输入11位手机号";
        
        [_phone DCT_editType:DCTTextFiledEditTypePhone];
        
        [_phone DCT_maxLength:11];
#if DCTUPDATEVERSION
        _phone.tintColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
#endif
    }
    return _phone;
}

- (DCTVCodeImageTextField *)vcode {
    
    if (!_vcode) {
        
        _vcode = [[DCTVCodeImageTextField alloc] initWithFrame:CGRectZero];
        
        _vcode.tag = 202;
        
        _vcode.leftImageName = @DCTVCodeIcon;
        
        _vcode.placeholder = @"请输入6位验证码";
        
        [_vcode DCT_editType:DCTTextFiledEditTypeVcode_length6];
        
        [_vcode DCT_maxLength:6];
#if DCTUPDATEVERSION
        _vcode.tintColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
#endif
    }
    return _vcode;
}

- (UIButton *)loginItem {
    
    if (!_loginItem) {
        
        _loginItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _loginItem.tag = 203;
        
        [_loginItem setBackgroundImage:[UIImage s_transformFromHexColor:@DCTColor] forState:UIControlStateNormal];
        
        [_loginItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
        
        [_loginItem setTitle:@"注册/登陆" forState: UIControlStateNormal];
        
        [_loginItem setTitle:@"注册/登陆" forState: UIControlStateHighlighted];
        
        [_loginItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_loginItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _loginItem.layer.masksToBounds = true;
        
        _loginItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _loginItem;
}

- (UIButton *)backLoginItem {
    
    if (!_backLoginItem) {
        
        _backLoginItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _backLoginItem.tag = 204;
        
        [_backLoginItem setTitle:@"已有账号,返回登陆" forState: UIControlStateNormal];
        
        [_backLoginItem setTitle:@"已有账号,返回登陆" forState: UIControlStateHighlighted];
        
        [_backLoginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@DCTColor] forState:UIControlStateNormal];
        
        [_backLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
        
        _backLoginItem.layer.masksToBounds = true;
        
        _backLoginItem.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@DCTColor].CGColor;
        
        _backLoginItem.layer.borderWidth = 1;
        
        _backLoginItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _backLoginItem;
}
- (UIButton *)proItem {
    
    if (!_proItem) {
        
        _proItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _proItem.tag = 205;
        
        NSMutableAttributedString *mutable = [NSMutableAttributedString new];
        
        NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
        
        [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                      attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                                   NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@DCTColor]}]];
        [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                                                         NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@"#333333"]}] ];
        [_proItem setAttributedTitle:mutable forState:UIControlStateNormal];
        
        [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                      attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                                   NSForegroundColorAttributeName: [UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@DCTColor]] }]];
        [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                                                         NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@"#333333"]}] ];
        
        [_proItem setAttributedTitle:mutable forState:UIControlStateHighlighted];
        
        _proItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _proItem;
}

- (void)addOwnSubViews {
    
    [self.view addSubview:self.phone];
    
    [self.view addSubview:self.vcode];
    
    [self.view addSubview:self.loginItem];
    
    [self.view addSubview:self.backLoginItem];
    
    [self.view addSubview:self.proItem];
    
#if DCTLoginOne
    
    [self.view addSubview:self.logoImgView];
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
#elif DCTLoginTwo
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    
    [self.view insertSubview:self.drawView atIndex:1];
    
    [self.view insertSubview:self.logoImgView atIndex:2];
    
#elif DCTLoginThree
    [self.view addSubview:self.logoImgView];
    
    [self.view addSubview:self.topLine];
    
    [self.view addSubview:self.bottomLine];
#elif DCTLoginFour
    
    [self.view addSubview:self.logoImgView];
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    
#else
    
#endif
}

#if DCTLoginOne
- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@DCTBackground]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}
- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@DCTLogoIcon]];
    }
    return _logoImgView;
}

#elif DCTLoginTwo
- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@DCTLogoIcon]];
        
        _logoImgView.layer.cornerRadius = 40;
        
        _logoImgView.layer.masksToBounds = true;
        
        _logoImgView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@DCTColor].CGColor;
        
        _logoImgView.layer.borderWidth = 1;
    }
    return _logoImgView;
}
- (DCTDrawView *)drawView {
    
    if (!_drawView) {
        
        _drawView = [DCTDrawView createDraw:DCTDrawTypeShape];
        
        _drawView.backgroundColor = [UIColor clearColor];
        
        _drawView.fillColor = [UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff50"];
    }
    return _drawView;
}
- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@DCTBackground]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}
#elif DCTLoginThree

- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@DCTLogoIcon]];
        
        _logoImgView.layer.cornerRadius = 5;
        
        _logoImgView.layer.masksToBounds = true;
        
        _logoImgView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@DCTColor].CGColor;
        
        _logoImgView.layer.borderWidth = 1;
    }
    return _logoImgView;
}
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
#elif DCTLoginFour
- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@DCTBackground]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}
- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@DCTLogoIcon]];
        
        _logoImgView.layer.cornerRadius = 40;
        
        _logoImgView.layer.masksToBounds = true;
        
        _logoImgView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@DCTColor].CGColor;
        
        _logoImgView.layer.borderWidth = 1;
    }
    return _logoImgView;
}
#else

#endif
- (void)configNaviItem {
    
#if DCTLoginOne
    
    self.title = @"注册/登陆";
    
#elif DCTLoginTwo
    self.title = @"注册/登陆";
#elif DCTLoginThree
    
    self.title = @"注册/登陆";
    
#elif DCTLoginFour
    
    UILabel *titleLabel = [UILabel new];
    
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.text = @"注册/登陆";
    
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
#else
    
#endif
}
- (void)configOwnSubViews {
    
#if DCTLoginOne
    
    self.backgroundImageView.frame = self.view.bounds;
    
    CGFloat w = CGRectGetWidth(self.view.bounds);
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view);
        
        make.top.mas_equalTo(60);
        
        make.width.height.mas_equalTo(@80);
    }];
    
    self.logoImgView.layer.cornerRadius = 40;
    
    self.logoImgView.layer.masksToBounds = true;
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.logoImgView.mas_bottom).offset(60);
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    [self.phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    self.phone.backgroundColor = [UIColor whiteColor];
    
    self.phone.layer.masksToBounds = true;
    //
    [self.phone DCT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    //
    [self.vcode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    [self.vcode setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    self.vcode.backgroundColor = [UIColor whiteColor];
    
    self.vcode.layer.masksToBounds = true;
    
    [self.vcode DCT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@DCTColor] forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#999999"] forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    [self.proItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    NSMutableAttributedString *mutable = [NSMutableAttributedString new];
    
    NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                               NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@"#ffffff"]}]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                                                     NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"]}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateNormal];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                               NSForegroundColorAttributeName: [UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] }]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                                                     NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"]}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateHighlighted];
    
    [self.proItem setNeedsDisplay];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.proItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.loginItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.loginItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@DCTColor] forState:UIControlStateNormal];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
    
    [self.backLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.backLoginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.backLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    self.backLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
#elif DCTLoginTwo
    
    CGFloat w = CGRectGetWidth(self.view.bounds);
    
    CGFloat h = w - 60;
    
    self.backgroundImageView.frame = self.view.bounds;
    
    [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(30);
        
        make.right.mas_equalTo(-30);
        
        make.centerY.equalTo(self.view).offset(-30);
        
        make.height.mas_equalTo(h * 5 / 4);
    }];
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.height.mas_equalTo(80);
        
        make.centerX.equalTo(self.view.mas_centerX);
        
        make.centerY.equalTo(self.drawView.mas_top);
    }];
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.drawView.mas_top).offset(60);
        
        make.left.equalTo(self.drawView.mas_left).offset(15);
        
        make.right.equalTo(self.drawView.mas_right).offset(-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    [self.phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    self.phone.backgroundColor = [UIColor whiteColor];
    
    self.phone.layer.cornerRadius = 24;
    
    self.phone.layer.masksToBounds = true;
    //
    [self.phone DCT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    //
    [self.vcode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    [self.vcode setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    self.vcode.backgroundColor = [UIColor whiteColor];
    
    self.vcode.layer.cornerRadius = 24;
    
    self.vcode.layer.masksToBounds = true;
    
    [self.vcode DCT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@DCTColor] forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#999999"] forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    [self.proItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    NSMutableAttributedString *mutable = [NSMutableAttributedString new];
    
    NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                               NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@"#ffffff"]}]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                                                     NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"]}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateNormal];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                               NSForegroundColorAttributeName: [UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] }]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                                                     NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"]}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateHighlighted];
    
    [self.proItem setNeedsDisplay];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.drawView.mas_bottom).offset(-30);
        
        make.right.equalTo(self.phone.mas_right);
        
        make.height.width.mas_equalTo(80);
    }];
    
    [self.loginItem setImage:[UIImage imageNamed:@DCTLoginIcon] forState:UIControlStateNormal];
    
    [self.loginItem setImage:[UIImage imageNamed:@DCTLoginIcon] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitle:@"" forState:UIControlStateNormal];

    [self.loginItem setTitle:@"" forState:UIControlStateHighlighted];
    
    self.loginItem.layer.cornerRadius = 40;
    
    self.loginItem.layer.masksToBounds = true;
    
    [self.loginItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];

    [self.loginItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.backLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_equalTo(-60);
        
        make.centerX.equalTo(self.view);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.backLoginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.backLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    self.backLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
#elif DCTLoginThree
    
    self.topLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    CGFloat w = CGRectGetWidth(self.view.bounds);
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.height.mas_equalTo(8);
        
        make.top.mas_equalTo(h);
    }];
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view);
        
        make.top.mas_equalTo(self.topLine.mas_bottom).offset(25);
        
        make.width.height.mas_equalTo(@60);
    }];
    
    self.bottomLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.height.mas_equalTo(8);
        
        make.top.equalTo(self.logoImgView.mas_bottom).offset(25);
    }];
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bottomLine.mas_bottom).offset(15);
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    self.phone.backgroundColor = [UIColor whiteColor];
    
    self.phone.layer.cornerRadius = 24;
    
    self.phone.layer.masksToBounds = true;
    
    self.phone.layer.borderWidth = 1;
    
    self.phone.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@DCTColor].CGColor;
    
    //
    [self.vcode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.vcode.backgroundColor = [UIColor whiteColor];
    
    self.vcode.layer.cornerRadius = 24;
    
    self.vcode.layer.masksToBounds = true;
    
    self.vcode.layer.borderWidth = 1;
    
    self.vcode.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@DCTColor].CGColor;
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@DCTColor] forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#999999"] forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    [self.proItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    NSMutableAttributedString *mutable = [NSMutableAttributedString new];
    
    NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                               NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@DCTColor]}]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                                                     NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@"#999999"]}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateNormal];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                               NSForegroundColorAttributeName: [UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@DCTColor]] }]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                                                     NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@"#999999"]}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateHighlighted];
    
    [self.proItem setNeedsDisplay];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.proItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.loginItem setBackgroundImage:[UIImage s_transformFromHexColor:@DCTColor] forState:UIControlStateNormal];
    
    [self.loginItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.backLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.backLoginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@DCTColor] forState:UIControlStateNormal];
    
    [self.backLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
    
    self.backLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
    [_vcode setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
#elif DCTLoginFour
    
    self.backgroundImageView.frame = self.view.bounds;
    
    CGFloat w = CGRectGetWidth(self.view.bounds);
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view);
        
        make.top.mas_equalTo(60);
        
        make.width.height.mas_equalTo(@80);
    }];
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.logoImgView.mas_bottom).offset(60);
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    [self.phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    self.phone.backgroundColor = [UIColor whiteColor];
    
    self.phone.layer.cornerRadius = 24;
    
    self.phone.layer.masksToBounds = true;
    //
    [self.phone DCT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    //
    [self.vcode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    [self.vcode setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    self.vcode.backgroundColor = [UIColor whiteColor];
    
    self.vcode.layer.cornerRadius = 24;
    
    self.vcode.layer.masksToBounds = true;
    
    [self.vcode DCT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@DCTColor] forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#999999"] forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    [self.proItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    NSMutableAttributedString *mutable = [NSMutableAttributedString new];
    
    NSString *displayname = [NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                               NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@"#ffffff"]}]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                                                     NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"]}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateNormal];
    
    [mutable setAttributedString: [[NSAttributedString alloc] initWithString:displayname ? displayname : @""
                                                                  attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                               NSForegroundColorAttributeName: [UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] }]];
    [mutable appendAttributedString:[[NSAttributedString alloc] initWithString:@" 注册协议" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12] ,
                                                                                                     NSForegroundColorAttributeName: [UIColor s_transformToColorByHexColorStr:@"#e1e1e1"]}] ];
    [self.proItem setAttributedTitle:mutable forState:UIControlStateHighlighted];
    
    [self.proItem setNeedsDisplay];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.proItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.loginItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.loginItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@DCTColor] forState:UIControlStateNormal];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
    
    [self.backLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.backLoginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.backLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    self.backLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
#else
    
#endif
    
}
- (void)configOwnProperties {
    [super configOwnProperties];
    
#if DCTLoginOne
    
    self.view.backgroundColor = [UIColor whiteColor];
    
#elif DCTLoginTwo
    
    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
#elif DCTLoginThree
    
    self.view.backgroundColor = [UIColor whiteColor];
#elif DCTLoginFour
    
#else
    
#endif
}

- (void)configViewModel {
    
    self.bridge = [DCTRegBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createReg:self regAction:^(enum DCTRegActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
}

- (BOOL)canPanResponse {
    
    return true ;
}

@end
