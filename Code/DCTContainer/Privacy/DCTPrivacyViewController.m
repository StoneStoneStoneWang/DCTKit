//
//  DCTPrivacyViewController.m
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "DCTPrivacyViewController.h"
@import SToolsKit;
@interface DCTPrivacyViewController ()

@property (nonatomic ,strong) DCTProtocolBridge *bridge;

#if DCTUserInfoOne

#elif DCTUserInfoTwo

#elif DCTUserInfoThree

@property (nonatomic ,strong) UIView *topLine;
#else


#endif
@end

@implementation DCTPrivacyViewController

#if DCTUserInfoOne

#elif DCTUserInfoTwo

#elif DCTUserInfoThree

- (UIView *)topLine {
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}
#else


#endif
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#if DCTPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}


+ (instancetype)createPrivacy {
    
    return [self new];
}

- (void)configViewModel {
    
    self.bridge = [DCTProtocolBridge new];
    
    [self.bridge createProtocol:self] ;
}
- (void)addOwnSubViews {
    [super addOwnSubViews];
#if DCTUserInfoOne
    
    
#elif DCTUserInfoTwo
    
#elif DCTUserInfoThree
    
    [self.view addSubview:self.topLine];
#else
    
    
#endif
    
    
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    
#if DCTUserInfoOne
    
#elif DCTUserInfoTwo
    
    
#elif DCTUserInfoThree
    
    self.topLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
    
    if ([self.navigationController.viewControllers.firstObject isKindOfClass:NSClassFromString(@"DCTLoginViewController")]) {
        
        CGFloat h = CGRectGetHeight(self.navigationController.navigationBar.bounds);
        
        self.topLine.frame = CGRectMake(15, h, CGRectGetWidth(self.view.bounds) - 30, 8);
        
    } else {
        
        CGFloat h = KTOPLAYOUTGUARD;
        
        self.topLine.frame = CGRectMake(15, h, CGRectGetWidth(self.view.bounds) - 30, 8);
    }
    
    CGRect initFrame = self.textView.frame;
    
    CGRect finalFrame = CGRectOffset(initFrame, 0, 8);
    
    self.textView.frame = finalFrame;
    
#else
    
    
#endif
}
- (void)configOwnProperties {
    [super configOwnProperties];
    
#if DCTUserInfoOne
    
#elif DCTUserInfoTwo
    
    self.textView.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
    
    self.textView.layer.masksToBounds = false;
    
#elif DCTUserInfoThree
    
    
#else
    
    
#endif
    
}

- (void)configNaviItem {
    
    self.title = @"隐私与协议";
}
- (BOOL)canPanResponse {
    return true;
}

@end
