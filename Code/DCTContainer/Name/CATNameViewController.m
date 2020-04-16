//
//  CATNameViewController.m
//  CATContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "CATNameViewController.h"
@import Masonry;
@import SToolsKit;
@import CATTextField;

@interface CATNameViewController ()

@property (nonatomic ,strong) CATNickNameTextField *textField;

@property (nonatomic ,strong) UIButton *completeItem;

@property (nonatomic ,strong) CATNameBridge *bridge;

@property (nonatomic ,strong) UIButton *backItem;

@property (nonatomic ,strong) CATNameBlock block;

#if CATNameOne


#elif CATNameTwo

//    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@CATColor];

#elif CATNameThree
@property (nonatomic ,strong) UIView *topLine;
#endif

@end

@implementation CATNameViewController

+ (instancetype)createNickNameWithBlock:(CATNameBlock)block {
    
    return [[self alloc] initWithBlock:block];
    
}
- (instancetype)initWithBlock:(CATNameBlock)block {
    
    if (self = [super init]) {
        
        self.block = block;
    }
    return self;
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

- (CATNickNameTextField *)textField {
    
    if (!_textField) {
        
        _textField = [[CATNickNameTextField alloc] initWithFrame:CGRectZero];
        
        [_textField CAT_clearButtonMode:UITextFieldViewModeWhileEditing];
        
        [_textField CAT_returnKeyType:UIReturnKeyDone];
        
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
    
#if CATNameOne
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr:@CATColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@CATColor]] forState:UIControlStateDisabled];
    
#elif CATNameTwo
    
    
#elif CATNameThree
    
    [self.view addSubview:self.topLine];
#endif
}
- (void)configOwnSubViews {
    
    
#if CATNameOne
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h + 1);
        
        make.height.mas_equalTo(48);
    }];
#elif CATNameTwo
    
    CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        
        make.top.mas_equalTo(h);
        
        make.height.mas_equalTo(48);
    }];
#elif CATNameThree
    
    self.topLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
    
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
    
    [self.completeItem setTitleColor:[UIColor s_transformToColorByHexColorStr: @CATColor] forState:UIControlStateNormal];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@80",@CATColor]] forState:UIControlStateHighlighted];
    
    [self.completeItem setTitleColor:[UIColor s_transformTo_AlphaColorByHexColorStr:[NSString stringWithFormat:@"%@50",@CATColor]] forState:UIControlStateDisabled];
#endif
    
}

- (void)configNaviItem {
    
    self.title = @"修改昵称";
    
    [self.completeItem sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.completeItem];
    
    [self.backItem setImage:[UIImage imageNamed:@CATBackIcon] forState:UIControlStateNormal];
    
    [self.backItem sizeToFit];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backItem];
    
}
- (void)configViewModel {
    
    self.bridge = [CATNameBridge new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.bridge createName:self nameAction:^(enum CATNameActionType actionType) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf ;
        
        strongSelf.block(actionType, strongSelf);
    }];
}
- (void)configOwnProperties {
    
#if CATNameOne
    [super configOwnProperties];
    
#elif CATNameTwo
    [super configOwnProperties];
#elif CATNameThree
    [super configOwnProperties];
#endif
    
    
}
@end
