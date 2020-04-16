//
//  DCTLoadingViewController.h
//  TSUIKit
//
//  Created by three stone 王 on 2018/7/10.
//  Copyright © 2018年 three stone 王. All rights reserved.
//

@import DCTTransition;
#import "DCTLoadingView.h"
@interface DCTLoadingViewController : DCTTViewController

@property (nonatomic ,strong ,readonly) DCTLoadingView *loadingView;

@property (nonatomic ,assign) DCTLoadingStatus loadingStatus;

// 重新加载
- (void)onReloadItemClick;

@end
