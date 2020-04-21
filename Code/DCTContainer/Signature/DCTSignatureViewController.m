//
//  DCTSignatureViewController.m
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "DCTSignatureViewController.h"
@import Masonry;
@import SToolsKit;

@interface DCTSignatureViewController ()

@property (nonatomic ,strong) UITextView *signaturetv;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) DCTSignatureBridge *bridge;

@property (nonatomic ,strong) UIButton *backItem;

@property (nonatomic ,strong) DCTSignatureBlock block;

@property (nonatomic ,strong) UITextView *placeholder;

@property (nonatomic ,strong) UIView *whiteView;

#if DCTNameOne


#elif DCTNameTwo

@property (nonatomic ,strong) UIImageView *backgroundImageView;

//    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];

#elif DCTNameThree
@property (nonatomic ,strong) UIView *topLine;
#endif
@end

@implementation DCTSignatureViewController

+ (instancetype)createSignatureWithBlock:(DCTSignatureBlock)block {
    
    return [[self alloc] initWithBlock:block];
    
}
- (instancetype)initWithBlock:(DCTSignatureBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (UIView *)whiteView {
    
    if (!_whiteView) {
        
        _whiteView = [UIView new];
        
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}
- (UITextView *)signaturetv {
    
    if (!_signaturetv) {
        
        _signaturetv = [[UITextView alloc] initWithFrame:CGRectZero];
        
        _signaturetv.font = [UIFont systemFontOfSize:15];
        
        _signaturetv.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
        
        _signaturetv.tag = 201;
        
        _signaturetv.backgroundColor = [UIColor clearColor];
    }
    return _signaturetv;
}
- (UITextView *)placeholder {
    
    if (!_placeholder) {
        
        _placeholder = [[UITextView alloc] initWithFrame:CGRectZero];
        
        _placeholder.font = [UIFont systemFontOfSize:15];
        
        _placeholder.textContainerInset = UIEdgeInsetsMake(15, 15, 15, 15);
        
        _placeholder.tag = 202;
        
        _placeholder.backgroundColor = [UIColor whiteColor];
        
        _placeholder.userInteractionEnabled = false;
        
        _placeholder.text = @"请输入个性昵称";
        
        _placeholder.textColor = [UIColor s_transformToColorByHexColorStr:@"#999999"];
    }
    return _placeholder;
}
#if DCTNameOne


#elif DCTNameTwo

- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@DCTBackground]];
    }
    return _backgroundImageView;
}

#elif DCTNameThree

- (UIView *)topLine {
    
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}

#endif
- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateNormal];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateHighlighted];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateSelected];
        
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
    
    [self.view addSubview:self.whiteView];
    
    [self.view addSubview:self.placeholder];
    
    [self.view addSubview:self.signaturetv];
    
#if DCTNameOne
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@DCTColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@DCTColor]] forState:UIControlStateDisabled];
    
#elif DCTNameTwo
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
    
#elif DCTNameThree
    
    [self.view addSubview:self.topLine];
#endif
}
- (void)configOwnSubViews {
    
    
#if DCTNameOne
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 1);
        
        make.height.mas_equalTo(120);
    }];
    
    [self.placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h);
        
        make.height.mas_equalTo(120);
    }];
    
    [self.signaturetv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h);
        
        make.height.mas_equalTo(120);
    }];
#elif DCTNameTwo
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.signaturetv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    self.backgroundImageView.frame = self.view.bounds;
    
    self.whiteView.backgroundColor = [UIColor s_transformTo_AlphaColorByHexColorStr:@"#ffffff80"];
    
#elif DCTNameThree
    
    self.topLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h);
        
        make.height.mas_equalTo(8);
    }];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.signaturetv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr: @DCTColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@DCTColor]] forState:UIControlStateDisabled];
#endif
}

- (void)configNaviItem {
    
    self.title = @"修改个性签名";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
#if DCTNameTwo
    [self.backItem setImage:[UIImage imageNamed:@DCTLoginBackIcon] forState:UIControlStateNormal];
#endif
    
    [self.backItem sizeToFit];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
}

- (void)configViewModel {
    
    self.bridge = [DCTSignatureBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createSignature:self signatureAction:^(enum DCTSignatureActionType actionType) {
        
        weakSelf.block(actionType, weakSelf);
    }];
}
- (void)configOwnProperties {
    
    
#if DCTNameOne
    [super configOwnProperties];
    
#elif DCTNameTwo
    [super configOwnProperties];
#elif DCTNameThree
    [super configOwnProperties];
#endif
}
@end
