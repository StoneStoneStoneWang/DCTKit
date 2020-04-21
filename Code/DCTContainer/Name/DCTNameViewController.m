//
//  DCTNameViewController.m
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "DCTNameViewController.h"
@import Masonry;
@import SToolsKit;
@import DCTTextField;

@interface DCTNameViewController ()

@property (nonatomic ,strong) DCTNickNameTextField *textField;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) DCTNameBridge *bridge;

@property (nonatomic ,strong) UIButton *backItem;

@property (nonatomic ,strong) DCTNameBlock block;

#if DCTNameOne


#elif DCTNameTwo

//    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];

#elif DCTNameThree
@property (nonatomic ,strong) UIView *topLine;
#endif

@end

@implementation DCTNameViewController

+ (instancetype)createNickNameWithBlock:(DCTNameBlock)block {
    
    return [[self alloc] initWithBlock:block];
    
}
- (instancetype)initWithBlock:(DCTNameBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
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

- (DCTNickNameTextField *)textField {
    
    if (!_textField) {
        
        _textField = [[DCTNickNameTextField alloc] initWithFrame:CGRectZero];
        
        [_textField DCT_clearButtonMode:UITextFieldViewModeWhileEditing];
        
        [_textField DCT_returnKeyType:UIReturnKeyDone];
        
        _textField.tag = 201;
        
        _textField.backgroundColor = [UIColor whiteColor];
        
        _textField.placeholder = @"请输入昵称";
    }
    return _textField;
}

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
    
    [self.view addSubview:self.textField];
    
#if DCTNameOne
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@DCTColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@DCTColor]] forState:UIControlStateDisabled];
    
#elif DCTNameTwo
    
    
#elif DCTNameThree
    
    [self.view addSubview:self.topLine];
#endif
}
- (void)configOwnSubViews {
    
    
#if DCTNameOne
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 1);
        
        make.height.mas_equalTo(48);
    }];
#elif DCTNameTwo
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h);
        
        make.height.mas_equalTo(48);
    }];
#elif DCTNameThree
    
    self.topLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h);
        
        make.height.mas_equalTo(8);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 8);
        
        make.height.mas_equalTo(48);
    }];
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr: @DCTColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@DCTColor]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@DCTColor]] forState:UIControlStateDisabled];
#endif
    
}

- (void)configNaviItem {
    
    self.title = @"修改昵称";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
    [self.backItem setImage:[UIImage imageNamed:@DCTBackIcon] forState:UIControlStateNormal];
    
    [self.backItem sizeToFit];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
    
}
- (void)configViewModel {
    
    self.bridge = [DCTNameBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createName:self nameAction:^(enum DCTNameActionType actionType) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf ;
        
        strongSelf.block(actionType, strongSelf);
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
