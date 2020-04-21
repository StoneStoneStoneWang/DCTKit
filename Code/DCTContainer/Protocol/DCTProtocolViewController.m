//
//  DCTProtocolViewController.m
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "DCTProtocolViewController.h"
@import SToolsKit;
@interface DCTProtocolViewController ()

@property (nonatomic ,strong) DCTProtocolBridge *bridge;


#if DCTLoginOne

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#elif DCTLoginTwo

#elif DCTLoginThree

@property (nonatomic ,strong) UIView *topLine;

#elif DCTLoginFour

@property (nonatomic ,strong) UIImageView *backgroundImageView;

#else


#endif
@end

@implementation DCTProtocolViewController

#if DCTLoginOne

- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@DCTBackground]];
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backgroundImageView;
}

#elif DCTLoginTwo

#elif DCTLoginThree

- (UIView *)topLine {
    if (!_topLine) {
        
        _topLine = [UIView new];
    }
    return _topLine;
}

#elif DCTLoginFour
- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@DCTBackground]];
        
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
    
    self.bridge = [DCTProtocolBridge new];
    
    [self.bridge createProtocol:self] ;
}
- (void)addOwnSubViews {
    [super addOwnSubViews];
    
#if DCTLoginOne
    
    [self.view insertSubview:self.backgroundImageView atIndex:0];
#elif DCTLoginTwo
    
#elif DCTLoginThree
    
    [self.view addSubview:self.topLine];
#elif DCTLoginFour
    
    
    
#else
    
    
#endif
}
- (void)configOwnSubViews {
    [super configOwnSubViews];
    
    
#if DCTLoginOne
    
    self.backgroundImageView.frame = self.view.bounds;
    
    self.textView.backgroundColor = [UIColor clearColor];
    
#elif DCTLoginTwo
    
    self.textView.textColor = [UIColor whiteColor];
    
    self.textView.editable = false;
    
#elif DCTLoginThree
    
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
#elif DCTLoginFour
    
    self.backgroundImageView.frame = self.view.bounds;
    
#else
    
    
#endif
}
- (void)configOwnProperties {
    [super configOwnProperties];
    
#if DCTLoginOne
    
#elif DCTLoginTwo
    
    self.textView.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor s_transformToColorByHexColorStr:@DCTColor];
    
    self.textView.layer.masksToBounds = false;
    
#elif DCTLoginThree
    
    
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
