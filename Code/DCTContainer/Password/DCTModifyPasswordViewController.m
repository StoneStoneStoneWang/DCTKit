//
//  DCTModifyPasswordViewController.m
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "DCTModifyPasswordViewController.h"
@import DCTTextField;
@import SToolsKit;
@import Masonry;

#if DCTLoginTwo

@import DCTDraw;

#endif

@interface DCTModifyPasswordViewController ()
@property (nonatomic ,strong) DCTModifyPasswordBridge *bridge;

@property (nonatomic ,strong) DCTPasswordImageTextFiled *oldpassword;

@property (nonatomic ,strong) DCTPasswordImageTextFiled *password;

@property (nonatomic ,strong) DCTPasswordImageTextFiled *againpassword;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,copy) DCTModifyPasswordBlock block;

@property (nonatomic ,strong) UIButton *backItem;

#if DCTLoginOne

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#elif DCTLoginTwo

@property (nonatomic ,strong) UIImageView *logoImgView;

@property (nonatomic ,strong) DCTDrawView *drawView;


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

@implementation DCTModifyPasswordViewController

+ (instancetype)createPasswordWithBlock:(DCTModifyPasswordBlock)block {
    
    return [[self alloc] initWithBlock:block];
}
- (instancetype)initWithBlock:(DCTModifyPasswordBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (DCTPasswordImageTextFiled *)oldpassword {
    
    if (!_oldpassword) {
        
        _oldpassword = [[DCTPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _oldpassword.tag = 201;
        
        _oldpassword.leftImageName = @DCTPasswordIcon;
        
        _oldpassword.placeholder = @"请输入6-18位旧密码";
        
        _oldpassword.normalIcon = @DCTPasswordNormalIcon;
        
        _oldpassword.selectedIcon = @DCTPasswordSelectIcon;
        
        _oldpassword.leftImageName = @DCTPasswordIcon;
        
        [_oldpassword DCT_editType:DCTTextFiledEditTypeSecret];
        
        [_oldpassword DCT_maxLength:18];
        
#if DCTUPDATEVERSION
        _oldpassword.tintColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
#endif
    }
    return _oldpassword;
}
- (DCTPasswordImageTextFiled *)password {
    
    if (!_password) {
        
        _password = [[DCTPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _password.tag = 202;
        
        _password.leftImageName = @DCTPasswordIcon;
        
        _password.placeholder = @"请输入6-18位新密码";
        
        _password.normalIcon = @DCTPasswordNormalIcon;
        
        _password.selectedIcon = @DCTPasswordSelectIcon;
        
        _password.leftImageName = @DCTPasswordIcon;
        
        [_password DCT_editType:DCTTextFiledEditTypeSecret];
        
        [_password DCT_maxLength:18];
        
#if DCTUPDATEVERSION
        _password.tintColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
#endif
    }
    return _password;
}

- (DCTPasswordImageTextFiled *)againpassword {
    
    if (!_againpassword) {
        
        _againpassword = [[DCTPasswordImageTextFiled alloc] initWithFrame:CGRectZero];
        
        _againpassword.tag = 203;
        
        _againpassword.leftImageName = @DCTPasswordIcon;
        
        _againpassword.placeholder = @"请输入6-18位确认密码";
        
        _againpassword.normalIcon = @DCTPasswordNormalIcon;
        
        _againpassword.selectedIcon = @DCTPasswordSelectIcon;
        
        _againpassword.leftImageName = @DCTPasswordIcon;
        
        [_againpassword DCT_editType:DCTTextFiledEditTypeSecret];
        
        [_againpassword DCT_maxLength:18];
        
#if DCTUPDATEVERSION
        _againpassword.tintColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
#endif
    }
    return _againpassword;
}


- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _completeItem.tag = 204;
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@DCTColor] forState:UIControlStateNormal];
        
        [_completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"修改密码" forState: UIControlStateNormal];
        
        [_completeItem setTitle:@"修改密码" forState: UIControlStateHighlighted];
        
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
    
    [self.view addSubview:self.oldpassword];
    
    [self.view addSubview:self.password];
    
    [self.view addSubview:self.againpassword];
    
    [self.view addSubview:self.completeItem];
    
#if DCTLoginOne
    
    [self.view addSubview:self.logoImgView];
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
#elif DCTLoginTwo
    
    [self.view insertSubview:self.drawView atIndex:0];
    
    [self.view insertSubview:self.logoImgView atIndex:1];
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
    
    [self.oldpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.logoImgView.mas_bottom).offset(60);
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    self.oldpassword.backgroundColor = [UIColor whiteColor];
    
    self.oldpassword.layer.masksToBounds = true;
    
    [self.oldpassword DCT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.oldpassword.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.masksToBounds = true;
    
    [self.password DCT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.againpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.againpassword.backgroundColor = [UIColor whiteColor];
    
    self.againpassword.layer.masksToBounds = true;
    
    [self.againpassword DCT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.againpassword.mas_bottom).offset(30);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
        
    }];
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@DCTColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
    
    [self.oldpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.againpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
#elif DCTLoginTwo
    
    CGFloat w = CGRectGetWidth(self.view.bounds);
    
    CGFloat h = w - 60;
    
    [self.drawView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(30);
        
        make.right.mas_equalTo(-30);
        
        make.centerY.equalTo(self.view);
        
        make.height.mas_equalTo(h * 5 / 3);
    }];
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.height.mas_equalTo(80);
        
        make.centerX.equalTo(self.view.mas_centerX);
        
        make.centerY.equalTo(self.drawView.mas_top);
    }];
    
    [self.oldpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.drawView.mas_top).offset(60);
        
        make.left.equalTo(self.drawView.mas_left).offset(15);
        
        make.right.equalTo(self.drawView.mas_right).offset(-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    self.oldpassword.backgroundColor = [UIColor whiteColor];
    
    self.oldpassword.layer.masksToBounds = true;
    
    [self.oldpassword DCT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.oldpassword.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    [self.password DCT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.againpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.againpassword.backgroundColor = [UIColor whiteColor];
    
    self.againpassword.layer.cornerRadius = 24;
    
    self.againpassword.layer.masksToBounds = true;
    
    [self.againpassword DCT_bottomLineFrame:CGRectMake(0, 47, w - 30, 1)];
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.drawView.mas_bottom).offset(-15);
        
        make.right.equalTo(self.oldpassword.mas_right).offset(5);
        
        make.height.width.equalTo(self.oldpassword.mas_height);
    }];
    
    [self.completeItem setImage:[UIImage imageNamed:@DCTLoginIcon] forState:UIControlStateNormal];
    
    [self.completeItem setImage:[UIImage imageNamed:@DCTLoginIcon] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitle:@"" forState:UIControlStateNormal];

    [self.completeItem setTitle:@"" forState:UIControlStateHighlighted];
    
    self.completeItem.layer.cornerRadius = 24;
    
    self.completeItem.layer.masksToBounds = true;
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];

    [self.completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];;
    
    [self.oldpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.againpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
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
    
    [self.oldpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bottomLine.mas_bottom).offset(15);
        
        make.left.mas_equalTo(@15);
        
        make.right.mas_equalTo(@-15);
        
        make.height.mas_equalTo(@48);
    }];
    
    self.oldpassword.backgroundColor = [UIColor whiteColor];
    
    self.oldpassword.layer.cornerRadius = 24;
    
    self.oldpassword.layer.masksToBounds = true;
    
    self.oldpassword.layer.borderWidth = 1;
    
    self.oldpassword.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@DCTColor].CGColor;
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.oldpassword.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.password.backgroundColor = [UIColor whiteColor];
    
    self.password.layer.cornerRadius = 24;
    
    self.password.layer.masksToBounds = true;
    
    self.password.layer.borderWidth = 1;
    
    self.password.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@DCTColor].CGColor;
    
    [self.againpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.password.mas_bottom).offset(10);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
    }];
    
    self.againpassword.backgroundColor = [UIColor whiteColor];
    
    self.againpassword.layer.cornerRadius = 24;
    
    self.againpassword.layer.masksToBounds = true;
    
    self.againpassword.layer.borderWidth = 1;
    
    self.againpassword.layer.borderColor = [UIColor s_transformToColorByHexColorStr:@DCTColor].CGColor;
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.againpassword.mas_bottom).offset(30);
        
        make.left.mas_equalTo(self.oldpassword.mas_left);
        
        make.right.mas_equalTo(self.oldpassword.mas_right);
        
        make.height.mas_equalTo(self.oldpassword.mas_height);
        
    }];
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@"#ffffff"] forState:UIControlStateNormal];
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@DCTColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
    
    [self.oldpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.password setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
    
    [self.againpassword setLeftImageFrame:CGRectMake(0, 0, 80, 48)];
#elif DCTLoginFour
    
    
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
    
    self.bridge = [DCTModifyPasswordBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createPassword:self passwordAction:^{
        
        weakSelf.block(weakSelf ,DCTModifyPasswordActionTypeModify);
    }];
}
- (void)configNaviItem {
    
    if (self.navigationController.childViewControllers.count == 1) {
        
        [self.backItem setImage:[UIImage imageNamed:@DCTLoginBackIcon] forState:UIControlStateNormal];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
        
        [self.backItem addTarget:self action:@selector(DCTBackItemTap) forControlEvents:UIControlEventTouchUpInside];
    }
#if DCTLoginOne
    
    self.title = @"修改密码";
    
#elif DCTLoginTwo
    
    self.title = @"修改密码";
    
#elif DCTLoginThree
    
    self.title = @"修改密码";
    
#else
    
#endif
}

- (void)DCTBackItemTap {
    
    self.block(self, DCTModifyPasswordActionTypeBack);
}

- (BOOL)canPanResponse {
    
    return true ;
}

@end
