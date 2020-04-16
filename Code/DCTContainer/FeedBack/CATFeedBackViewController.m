//
//  CATFeedBackViewController.m
//  CATContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "CATFeedBackViewController.h"
@import Masonry;
@import SToolsKit;
@import CATTextField;
@import JXTAlertManager;

@interface CATFeedBackViewController ()

@property (nonatomic ,strong) UITextView *signaturetv;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) CATFeedBackBridge *bridge;

@property (nonatomic ,strong) UIButton *backItem;

@property (nonatomic ,strong) UITextView *placeholder;

@property (nonatomic ,strong) UIView *whiteView;

@property (nonatomic ,strong) CATNickNameTextField *textField;

@property (nonatomic ,copy) CATFeedBackBlock block;
#if CATNameOne


#elif CATNameTwo

//    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@CATColor];

#elif CATNameThree
@property (nonatomic ,strong) UIView *topLine;
#endif

@end

@implementation CATFeedBackViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if CATPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}

+ (instancetype)createFeedBackWithBlock:(CATFeedBackBlock)block {
    
    return [[self alloc] initWithFeedBackBlock:block];
}
- (instancetype)initWithFeedBackBlock:(CATFeedBackBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
}
- (CATNickNameTextField *)textField {
    
    if (!_textField) {
        
        _textField = [[CATNickNameTextField alloc] initWithFrame:CGRectZero];
        
        [_textField CAT_clearButtonMode:UITextFieldViewModeWhileEditing];
        
        [_textField CAT_returnKeyType:UIReturnKeyDone];
        
        _textField.tag = 203;
        
        _textField.backgroundColor = [UIColor whiteColor];
        
        _textField.placeholder = @"请输入手机号";
        
        [_textField CAT_editType:CATTextFiledEditTypePhone];
        
        [_textField CAT_maxLength:11];
#if CATUPDATEVERSION
        _textField.tintColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
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
#if CATUPDATEVERSION
        _signaturetv.tintColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
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

#if CATNameOne


#elif CATNameTwo


#elif CATNameThree

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
#if CATNameOne
    
    [self.view addSubview:self.completeItem];
    
#elif CATNameTwo
    
    
#elif CATNameThree
    
    [self.view addSubview:self.topLine];
#endif
}
- (void)configOwnSubViews {
#if CATNameOne
    
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
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromHexColor:@CATColor] forState:UIControlStateNormal];
    
    [self.completeItem setBackgroundImage:[UIImage s_transformFromAlphaHexColor:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:[NSString stringWithFormat:@"%@80",@"#ffffff"]] forState:UIControlStateHighlighted];
    
    self.completeItem.layer.cornerRadius = 24;
    
    self.completeItem.layer.masksToBounds = true;
    
#elif CATNameTwo
    
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
#elif CATNameThree
    
    self.topLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
    
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
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr: @CATColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@CATColor]] forState:UIControlStateDisabled];
    
#endif
    
}

- (void)configNaviItem {
    
    self.title = @"意见与建议";
    
}

- (void)configViewModel {
    
    self.bridge = [CATFeedBackBridge new];
    
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
    
#if CATNameOne
    [super configOwnProperties];
    
#elif CATNameTwo
    
#elif CATNameThree
    
    [super configOwnProperties];
#endif
}

- (BOOL)canPanResponse { return true;}

@end
