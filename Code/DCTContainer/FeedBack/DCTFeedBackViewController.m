//
//  DCTFeedBackViewController.m
//  DCTContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "DCTFeedBackViewController.h"
@import Masonry;
@import SToolsKit;
@import DCTTextField;
@import JXTAlertManager;

@interface DCTFeedBackViewController ()

@property (nonatomic ,strong) UITextView *signaturetv;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) DCTFeedBackBridge *bridge;

@property (nonatomic ,strong) UIButton *backItem;

@property (nonatomic ,strong) UITextView *placeholder;

@property (nonatomic ,strong) UIView *whiteView;

@property (nonatomic ,strong) DCTNickNameTextField *textField;

@property (nonatomic ,copy) DCTFeedBackBlock block;
#if DCTNameOne


#elif DCTNameTwo

//    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];

#elif DCTNameThree
@property (nonatomic ,strong) UIView *topLine;
#endif

@end

@implementation DCTFeedBackViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if DCTPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}

+ (instancetype)createFeedBackWithBlock:(DCTFeedBackBlock)block {
    
    return [[self alloc] initWithFeedBackBlock:block];
}
- (instancetype)initWithFeedBackBlock:(DCTFeedBackBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (DCTNickNameTextField *)textField {
    
    if (!_textField) {
        
        _textField = [[DCTNickNameTextField alloc] initWithFrame:CGRectZero];
        
        [_textField DCT_clearButtonMode:UITextFieldViewModeWhileEditing];
        
        [_textField DCT_returnKeyType:UIReturnKeyDone];
        
        _textField.tag = 203;
        
        _textField.backgroundColor = [UIColor whiteColor];
        
        _textField.placeholder = @"请输入手机号";
        
        [_textField DCT_editType:DCTTextFiledEditTypePhone];
        
        [_textField DCT_maxLength:11];
#if DCTUPDATEVERSION
        _textField.tintColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
#endif
    }
    return _textField;
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
#if DCTUPDATEVERSION
        _signaturetv.tintColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
#endif
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
- (UIButton *)completeItem {
    
    if (!_completeItem) {
        
        _completeItem = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateNormal];
        
        [_completeItem setTitle:@"完成" forState:UIControlStateHighlighted];
        
        _completeItem.titleLabel.font = [UIFont systemFontOfSize:15];
        
        _completeItem.tag = 204;
    }
    return _completeItem;
}

#if DCTNameOne


#elif DCTNameTwo


#elif DCTNameThree

- (UIView *)topLine {
    
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}

#endif
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
    
    [self.view addSubview:self.textField];
#if DCTNameOne
    
    [self.view addSubview:self.completeItem];
    
#elif DCTNameTwo
    
    
#elif DCTNameThree
    
    [self.view addSubview:self.topLine];
#endif
}
- (void)configOwnSubViews {
#if DCTNameOne
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD + 1);
        
        make.height.mas_equalTo(120);
    }];
    
    [self.placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD + 1);
        
        make.height.mas_equalTo(120);
    }];
    
    [self.signaturetv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD + 1);
        
        make.height.mas_equalTo(120);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.equalTo(self.signaturetv.mas_bottom).offset(10);
        
        make.height.mas_equalTo(55);
    }];
    
    [self.completeItem mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(-15);
        
        make.height.mas_equalTo(48);
        
        make.top.equalTo(self.textField.mas_bottom).offset(10);
    }];
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@DCTColor] forState:UIControlStateNormal];
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    self.completeItem.layer.cornerRadius = 24;
    
    self.completeItem.layer.masksToBounds = true;
    
#elif DCTNameTwo
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD + 1);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD + 1);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.signaturetv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD + 1);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.equalTo(self.signaturetv.mas_bottom).offset(10);
        
        make.height.mas_equalTo(55);
    }];
#elif DCTNameThree
    
    self.topLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD);
        
        make.height.mas_equalTo(8);
    }];
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.placeholder mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.signaturetv mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(KTOPLAYOUTGUARD + 8);
        
        make.height.mas_equalTo(200);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.equalTo(self.signaturetv.mas_bottom).offset(8);
        
        make.height.mas_equalTo(55);
    }];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr: @DCTColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@DCTColor]] forState:UIControlStateDisabled];
    
#endif
    
}

- (void)configNaviItem {
    
    self.title = @"意见与建议";
    
}

- (void)configViewModel {
    
    self.bridge = [DCTFeedBackBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createFeedBack:self feedBackAction:^{
        
        [weakSelf jxt_showAlertWithTitle:@"您的反馈非常重要,我们会尽快处理您的反馈" message:@"点击确定退出当前界面,点击继续反馈重新编辑" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            
            alertMaker
            .addActionDefaultTitle(@"继续反馈")
            .addActionDefaultTitle(@"确定");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
            if ([action.title isEqualToString:@"确定"]) {
                
                weakSelf.block(weakSelf);
            } else if ([action.title isEqualToString:@"继续反馈"]) {
                
                weakSelf.textField.text = @"";
                
                weakSelf.signaturetv.text = @"";
            }
        }];
    }];
    
}
- (void)configOwnProperties {
    
#if DCTNameOne
    [super configOwnProperties];
    
#elif DCTNameTwo
    
#elif DCTNameThree
    
    [super configOwnProperties];
#endif
}

- (BOOL)canPanResponse { return true;}

@end
