//
//  CATProtocolViewController.m
//  CATContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "CATProtocolViewController.h"
@import SToolsKit;
@interface CATProtocolViewController ()

@property (nonatomic ,strong) CATProtocolBridge *bridge;


#if CATLoginOne

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#elif CATLoginTwo

#elif CATLoginThree

@property (nonatomic ,strong) UIView *topLine;

#elif CATLoginFour

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#else


#endif
@end

@implementation CATProtocolViewController

#if CATLoginOne

- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@CATBackground]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}

#elif CATLoginTwo

#elif CATLoginThree

- (UIView *)topLine {
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}

#elif CATLoginFour
- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@CATBackground]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}
#else


#endif
+ (instancetype)createProtocol {
    
    return [self new];
}

- (void)configViewModel {
    
    self.bridge = [CATProtocolBridge new];
    
    [self.bridge createProtocol:self] ;
}
- (void)addOwnSubViews {
    [super addOwnSubViews];
    
#if CATLoginOne
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
#elif CATLoginTwo
    
#elif CATLoginThree
    
    [self.view addSubview:self.topLine];
#elif CATLoginFour
    
    
    
#else
    
    
#endif
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    
#if CATLoginOne
    
    self.backgroundImageView.frame = self.view.bounds;
    
    self.textView.backgroundColor = [UIColor clearColor];
    
#elif CATLoginTwo
    
    self.textView.textColor = [UIColor whiteColor];
    
    self.textView.editable = false;
    
#elif CATLoginThree
    
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
#elif CATLoginFour
    
    self.backgroundImageView.frame = self.view.bounds;
    
#else
    
    
#endif
}
- (void)configOwnProperties {
    [super configOwnProperties];
    
#if CATLoginOne
    
#elif CATLoginTwo
    
    self.textView.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@CATColor];
    
    self.textView.layer.masksToBounds = false;
    
#elif CATLoginThree
    
    
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
