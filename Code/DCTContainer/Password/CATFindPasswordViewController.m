//
//  CATFindPasswordViewController.m
//  CATContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "CATFindPasswordViewController.h"
@import CATTextField;
@import SToolsKit;
@import Masonry;

@interface CATFindPasswordViewController ()

@property (nonatomic ,strong) CATFindPasswordBridge *bridge;

@property (nonatomic ,strong) CATLeftImageTextField *phone;

@property (nonatomic ,strong) CATVCodeImageTextField *vcode;

@property (nonatomic ,strong) CATPasswordImageTextFiled *password;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,copy) CATFindPassworBlock block;

@property (nonatomic ,strong) UIButton *backItem;

#if CATLoginOne

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#elif CATLoginTwo

@property (nonatomic ,strong) UIImageView *logoImgView;

#elif CATLoginThree

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) UIView *topLine;

@property (nonatomic ,strong) UIView *bottomLine;

#elif CATLoginFour

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#else

#endif
@end

@implementation CATFindPasswordViewController

+ (instancetype)createPasswordWithBlock:(CATFindPassworBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(CATFindPassworBlock)block {
    
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

- (CATVCodeImageTextField *)vcode {
    
    if (!_vcode) {
        
        _vcode = [[CATVCodeImageTextField alloc] initWithFrame:CGRectZero];
        
        _vcode.tag = 202;
        
        _vcode.leftImageName = @CATVCodeIcon;
        
        _vcode.placeholder = @"请输入6位验证码";
        
        [_vcode CAT_editType:CATTextFiledEditTypeVcode_length6];
        
        [_vcode CAT_maxLength:6];
#if CATUPDATEVERSION
        _vcode.tintColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
#endif
    }
    return _vcode;
}

- (CATPasswordImageTextFiled *)password {
    
    if (!_password) {
        
        _password = [[CATPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _password.tag = 203;
        
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

- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _completeItem.tag = 204;
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@CATColor] forState:UIControlStateNormal];
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"忘记密码？" forState: UIControlStateNormal];
        
        [_completeItem setTitle:@"忘记密码？" forState: UIControlStateHighlighted];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        _completeItem.layer.masksToBounds = true;
        
        _completeItem.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _completeItem;
}
- (UIButton *)backItem {
    
    if (!_backItem) {
        
        _backItem = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _backItem;
}

- (void)addOwnSubViews {
    
    [self.view addSubview:self.phone];
    
    [self.view addSubview:self.vcode];
    
    [self.view addSubview:self.password];
    
    [self.view addSubview:self.completeItem];
    
#if CATLoginOne
    
    [self.view addSubview:self.logoImgView];
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
#elif CATLoginTwo
    [self.view addSubview:self.logoImgView];
#elif CATLoginThree
    [self.view addSubview:self.logoImgView];
    
    [self.view addSubview:self.topLine];
    
    [self.view addSubview:self.bottomLine];
#elif CATLoginFour
    
    [self.view addSubview:self.logoImgView];
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    
#else
    
#endif
}

#if CATLoginOne

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
    }
    return _logoImgView;
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

- (void)configOwnSubViews {
    
#if CATLoginOne
    
    self.backgroundImageView.frame = self.view.bounds;
    
    CGFloat w = CGRectGetWidth(self.view.bounds);
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view);
        
        make.top.mas_equalTo(60);
        
        make.width.height.mas_equalTo(@80);
    }];
    
    self.logoImgView.layer.cornerRadius = 40;
    
    self.logoImgView.layer.masksToBounds = true;
    
    self.logoImgView.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@CATColor].CGColor;
    
    self.logoImgView.layer.borderWidth = 1;
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.logoImgView.mas_bottom).offset(60);
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    self.phone.backgroundColor = [UIColor whiteColor];

    self.phone.layer.masksToBounds = true;
    
    [self.phone CAT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.vcode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#999999"] forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    self.vcode.backgroundColor = [UIColor whiteColor];
    
    self.vcode.layer.masksToBounds = true;
    
    [self.vcode CAT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];

    self.password.layer.masksToBounds = true;
    
    [self.password CAT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(30);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    [_vcode setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
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
    
    [self.vcode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#999999"] forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    self.vcode.backgroundColor = [UIColor whiteColor];
    
    self.vcode.layer.cornerRadius = 24;
    
    self.vcode.layer.masksToBounds = true;
    
    [self.vcode CAT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    [self.password CAT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(30);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    [_vcode setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
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
    
    [self.vcode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#999999"] forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    self.vcode.backgroundColor = [UIColor whiteColor];
    
    self.vcode.layer.cornerRadius = 24;
    
    self.vcode.layer.masksToBounds = true;
    
    self.vcode.layer.borderWidth = 1;
    
    self.vcode.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@CATColor].CGColor;
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    self.password.layer.borderWidth = 1;
    
    self.password.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@CATColor].CGColor;
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(30);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@CATColor] forState:UIControlStateNormal];
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [_vcode setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
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
    
    [self.vcode mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.phone.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    UIButton *vcodeItem = (UIButton *)self.vcode.rightView;
    
    [vcodeItem setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [vcodeItem sizeToFit];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
    
    [vcodeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    [vcodeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@"#999999"] forState:UIControlStateSelected];
    
    [self.vcode setRightView:vcodeItem];
    
    self.vcode.backgroundColor = [UIColor whiteColor];
    
    self.vcode.layer.cornerRadius = 24;
    
    self.vcode.layer.masksToBounds = true;
    
    [self.vcode CAT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.vcode.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    [self.password CAT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(30);
        
        make.left.mas_equalTo(self.phone.mas_left);
        
        make.right.mas_equalTo(self.phone.mas_right);
        
        make.height.mas_equalTo(self.phone.mas_height);
        
    }];
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    [_vcode setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_phone setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [_password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
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
    
    self.bridge = [CATFindPasswordBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createPassword:self passwordAction:^{
        
        weakSelf.block(weakSelf,CATFindPasswordActionTypeFind);
    }];
}

- (void)configNaviItem {
    
    if (self.navigationController.childViewControllers.count == 1) {
        
        [self.backItem setImage:[UIImage imageNamed:@CATLoginBackIcon] forState:UIControlStateNormal];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
        
        [self.backItem addTarget:self action:@selector(CATBackItemTap) forControlEvents:UIControlEventTouchUpInside];
    }
    
#if CATLoginOne
    
    self.title = @"忘记密码?";
    
#elif CATLoginTwo
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    self.title = @"忘记密码?";
#elif CATLoginThree
    
    self.title = @"忘记密码?";
#elif CATLoginFour
    
    UILabel *titleLabel = [UILabel new];
    
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.text = @"忘记密码?";
    
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = titleLabel;
#else
    
#endif
}
- (void)CATBackItemTap {
    
    self.block(self, CATFindPasswordActionTypeBack);
}

- (BOOL)canPanResponse {
    
    return true ;
}


@end
