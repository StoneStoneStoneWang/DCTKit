//
//  CATPrivacyViewController.m
//  CATContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "CATPrivacyViewController.h"
@import SToolsKit;
@interface CATPrivacyViewController ()

@property (nonatomic ,strong) CATProtocolBridge *bridge;

#if CATUserInfoOne

#elif CATUserInfoTwo

#elif CATUserInfoThree

@property (nonatomic ,strong) UIView *topLine;
#else


#endif
@end

@implementation CATPrivacyViewController

#if CATUserInfoOne

#elif CATUserInfoTwo

#elif CATUserInfoThree

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
    
#if CATPROFILEALPHA
    
    [self.navigationController setNavigationBarHidden:false];
#endif
}


+ (instancetype)createPrivacy {
    
    return [self new];
}

- (void)configViewModel {
    
    self.bridge = [CATProtocolBridge new];
    
    [self.bridge createProtocol:self] ;
}
- (void)addOwnSubViews {
    [super addOwnSubViews];
#if CATUserInfoOne
    
    
#elif CATUserInfoTwo
    
#elif CATUserInfoThree
    
    [self.view addSubview:self.topLine];
#else
    
    
#endif
    
    
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    
#if CATUserInfoOne
    
#elif CATUserInfoTwo
    
    
#elif CATUserInfoThree
    
    self.topLine.backgroundColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
    
    if ([self.navigationController.viewControllers.firstObject isKindOfClass:NSClassFromString(@"CATLoginViewController")]) {
        
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
    
#if CATUserInfoOne
    
#elif CATUserInfoTwo
    
    self.textView.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
    
    self.textView.layer.masksToBounds = false;
    
#elif CATUserInfoThree
    
    
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
