//
//  CATLoginViewController.m
//  CATContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "CATLoginViewController.h"
@import CATTextField;
@import SToolsKit;
@import Masonry;

@interface CATLoginViewController ()

@property (nonatomic ,strong) CATLoginBridge *bridge;

@property (nonatomic ,strong) CATLeftImageTextField *phone;

@property (nonatomic ,strong) CATPasswordImageTextFiled *password;

@property (nonatomic ,strong) UIButton *loginItem;

@property (nonatomic ,strong) UIButton *backItem;

@property (nonatomic ,strong) UIButton *forgetItem;

@property (nonatomic ,strong) UIButton *swiftLoginItem;

#if CATLoginOne
@property (nonatomic ,strong) UIImageView *backgroundImageView;

@property (nonatomic ,strong) UIImageView *logoImgView;

#elif CATLoginTwo

@property (nonatomic ,strong) UIImageView *logoImgView;

#elif CATLoginThree

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) UIView *topLine;

@property (nonatomic ,strong) UIView *bottomLine;
#elif CATLoginFour

@property (nonatomic ,strong) UIImageView *logoImgView;

#else

#endif

@property (nonatomic ,copy) CATLoginBlock block;
@end

@implementation CATLoginViewController

+ (instancetype)createLoginWithBlock:(CATLoginBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(CATLoginBlock)block  {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (CATLeftImageTextField *)phone {
    
    if (!_phone) {
        
        _phone = [[CATLeftImageTextField alloc] initWithFrame:CGRectZero];
        
        _phone.tag = 201;
        
        _phone.leftImageName = @CATPhoneIcon;
        
        _phone.placeholder = @"请输入11位手机号";
        
        [_phone CAT_editType:CATTextFiledEditTypePhone];
        
        [_phone CAT_maxLength:11];
        
#if CATUPDATEVERSION
        _phone.tintColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
#endif
    }
    return _phone;
}

- (CATPasswordImageTextFiled *)password {
    
    if (!_password) {
        
        _password = [[CATPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _password.tag = 202;
        
        _password.normalIcon = @CATPasswordNormalIcon;
        
        _password.selectedIcon = @CATPasswordSelectIcon;
        
        _password.leftImageName = @CATPasswordIcon;
        
        _password.placeholder = @"请输入6-18位密码";
        
        [_password CAT_editType:CATTextFiledEditTypeSecret];
        
        [_password CAT_maxLength:18];
#if CATUPDATEVERSION
        _password.tintColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
#endif
    }
    return _password;
}

- (UIButton *)loginItem {
    
    if (!_loginItem) {
        
        _loginItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _loginItem.tag = 203;
        
        [_loginItem setBackgroundImage:[UIImage s_transformFromHexColor:@CATColor] forState:UIControlStateNormal];
        
        [_loginItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
        
        [_loginItem setTitle:@"登陆" forState: UIControlStateNormal];
        
        [_loginItem setTitle:@"登陆" forState: UIControlStateHighlighted];
        
        [_loginItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_loginItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _loginItem.layer.masksToBounds = true;
        
        _loginItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _loginItem;
}

- (UIButton *)swiftLoginItem {
    
    if (!_swiftLoginItem) {
        
        _swiftLoginItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _swiftLoginItem.tag = 204;
        
        [_swiftLoginItem setTitle:@"没有账号?前往注册" forState: UIControlStateNormal];
        
        [_swiftLoginItem setTitle:@"没有账号?前往注册" forState: UIControlStateHighlighted];
        
        [_swiftLoginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
        
        [_swiftLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
        
        _swiftLoginItem.layer.masksToBounds = true;
        
        _swiftLoginItem.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@CATColor].CGColor;
        
        _swiftLoginItem.layer.borderWidth = 1;
        
        _swiftLoginItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _swiftLoginItem;
}
- (UIButton *)forgetItem {
    
    if (!_forgetItem) {
        
        _forgetItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _forgetItem.tag = 205;
        
        [_forgetItem setTitle:@"忘记密码?" forState: UIControlStateNormal];
        
        [_forgetItem setTitle:@"忘记密码?" forState: UIControlStateHighlighted];
        
        [_forgetItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
        
        [_forgetItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
        
        _forgetItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _forgetItem;
}
- (UIButton *)backItem {
    
    if (!_backItem) {
        
        _backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _backItem;
}
- (void)addOwnSubViews {
    
    [self.view addSubview:self.phone];
    
    [self.view addSubview:self.password];
    
    [self.view addSubview:self.loginItem];
    
    [self.view addSubview:self.swiftLoginItem];
    
    [self.view addSubview:self.forgetItem];
    
#if CATLoginOne
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    
    [self.view addSubview:self.logoImgView];
#elif CATLoginTwo
    
    [self.view addSubview:self.logoImgView];
#elif CATLoginThree
    [self.view addSubview:self.logoImgView];
    
    [self.view addSubview:self.topLine];
    
    [self.view addSubview:self.bottomLine];
#elif CATLoginFour
    
    [self.view addSubview:self.logoImgView];
    
#else
    
#endif
}

#if CATLoginOne

- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@CATLogoIcon]];
    }
    return _logoImgView;
}
- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@CATBackground]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}
#elif CATLoginTwo
- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@CATLogoIcon]];
        
        _logoImgView.layer.cornerRadius = 40;
        
        _logoImgView.layer.masksToBounds = true;
        
        _logoImgView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@CATColor].CGColor;
        
        _logoImgView.layer.borderWidth = 1;
    }
    return _logoImgView;
}
#elif CATLoginThree

- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@CATLogoIcon]];
        
        _logoImgView.layer.cornerRadius = 5;
        
        _logoImgView.layer.masksToBounds = true;
        
        _logoImgView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@CATColor].CGColor;
        
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
#elif CATLoginFour
- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@CATBackground]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}
- (UIImageView *)logoImgView {
    
    if (!_logoImgView) {
        
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@CATLogoIcon]];
        
        _logoImgView.layer.cornerRadius = 40;
        
        _logoImgView.layer.masksToBounds = true;
        
        _logoImgView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@CATColor].CGColor;
        
        _logoImgView.layer.borderWidth = 1;
    }
    return _logoImgView;
}
#else

#endif
- (void)configNaviItem {
    
    [self.backItem setImage:[UIImage imageNamed:@CATLoginBackIcon] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
    
#if CATLoginOne
    
    self.title = @"登陆";
    
#elif CATLoginTwo
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    self.title = @"登陆";
    
#elif CATLoginThree
    
    self.title = @"登陆";
    
#elif CATLoginFour
    
    UILabel *titleLabel = [UILabel new];
    
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.text = @"登陆";
    
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
    
#else
    
#endif
    
#if ZForceLogin
    
    self.backItem.hidden = true;
#else
    
#endif
}

- (void)configOwnSubViews {
    
#if CATLoginOne
    
    self.backgroundImageView.frame = self.view.bounds;
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view);
        
        make.top.mas_equalTo(60);
        
        make.width.height.mas_equalTo(@80);
    }];
    
    self.logoImgView.backgroundColor = [UIColor whiteColor];
    
    self.logoImgView.layer.cornerRadius = 5;
    
    self.logoImgView.layer.masksToBounds = true;
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.logoImgView.mas_bottom).offset(60);
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    self.phone.backgroundColor = [UIColor whiteColor];
    
    self.phone.layer.masksToBounds = true;
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.masksToBounds = true;
    
    [self.forgetItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.forgetItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.forgetItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.forgetItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.loginItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.loginItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    [self.swiftLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    self.swiftLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self.swiftLoginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.swiftLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [_password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
#elif CATLoginTwo
    
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
    
    self.phone.backgroundColor = [UIColor whiteColor];
    
    self.phone.layer.cornerRadius = 24;
    
    self.phone.layer.masksToBounds = true;
    
    [self.phone CAT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    [self.password CAT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.forgetItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.forgetItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.forgetItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.forgetItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.loginItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.loginItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    [self.swiftLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.swiftLoginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.swiftLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [_password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
#elif CATLoginThree
    
    self.topLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
    
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
    
    self.bottomLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
    
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
    
    self.phone.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@CATColor].CGColor;
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    self.password.layer.borderWidth = 1;
    
    self.password.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@CATColor].CGColor;
    
    [self.forgetItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.forgetItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
    
    [self.forgetItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.forgetItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.loginItem setBackgroundImage:[UIImage s_transformFromHexColor:@CATColor] forState:UIControlStateNormal];
    
    [self.loginItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.swiftLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.swiftLoginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
    
    [self.swiftLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    self.swiftLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
    [_password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
#elif CATLoginFour
    
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
    
    self.phone.backgroundColor = [UIColor whiteColor];
    
    self.phone.layer.cornerRadius = 24;
    
    self.phone.layer.masksToBounds = true;
    
    [self.phone CAT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    [self.password CAT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.forgetItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.forgetItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.forgetItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.loginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.forgetItem.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.loginItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.loginItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
    
    [self.loginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    [self.swiftLoginItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    self.swiftLoginItem.layer.borderColor = [UIColor clearColor].CGColor;
    
    [self.swiftLoginItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.swiftLoginItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr: [NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [_password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
#else
    
    
#endif
    
    
}
- (void)configOwnProperties {
    [super configOwnProperties];
    
#if CATLoginOne
    
    self.view.backgroundColor = [UIColor whiteColor];
    
#elif CATLoginTwo
    
    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
#elif CATLoginThree
    
    self.view.backgroundColor = [UIColor whiteColor];
#elif CATLoginFour
    
    
#else
    
    
#endif
    
    
}
- (void)configViewModel {
    
    self.bridge = [CATLoginBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createLogin:self loginAction:^(enum CATLoginActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
    
}

@end
