//
//  DCTLoadingView.h
//  TSUIKit
//
//  Created by three stone 王 on 2018/7/10.
//  Copyright © 2018年 three stone 王. All rights reserved.
//
@import UIKit;
@import DCTTransition;

typedef NS_ENUM(NSInteger,DCTLoadingStatus) {
    
    DCTLoadingStatusBegin,
    
    DCTLoadingStatusLoading,
    
    DCTLoadingStatusSucc,
    
    DCTLoadingStatusFail,
    
    DCTLoadingStatusReload
};

@protocol DCTLoadingViewDelegate <NSObject>

- (void)onReloadItemClick;

@end

@interface DCTLoadingView : UIView

+ (instancetype)loadingWithContentViewController:(DCTTViewController *)contentViewController;

/*
 设置加载状态
 DCTLoadingStatusBegin 请在viewwillappear里
 DCTLoadingStatusLoading 请在设置begin之后 viewwillappear里
 DCTLoadingStatusSucc 加载成功
 DCTLoadingStatusFail 加载失败
 DCTLoadingStatusReload 重新加载 屏幕上有 点击屏幕重新加载按钮
 */
@property (nonatomic ,assign ,readonly) BOOL isLoading;

@property (nonatomic ,assign)DCTLoadingStatus status;

- (void)changeLoadingStatus:(DCTLoadingStatus )status;

@property (nonatomic ,weak) id<DCTLoadingViewDelegate> mDelegate;


@end
