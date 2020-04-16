//
//  CATAreaHeaderViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//


#import "CATConfig.h"
@import CATCollection;
@import CATBean;
NS_ASSUME_NONNULL_BEGIN

typedef void(^CATAreaHeaderBlock)(CATBaseViewController *from ,CATAreaBean *pArea ,CATAreaBean *cArea ,CATAreaBean *_Nullable rArea);

@interface CATAreaHeaderViewController : CATCollectionNoLoadingViewController

+ (instancetype)createAreaHeaderWithPid:(NSInteger)pid andCid:(NSInteger)cid andRid:(NSInteger )rid andAreaHeaderBlock:(CATAreaHeaderBlock) block;

@end

@interface CATAreaPresentAnimation : NSObject <UIViewControllerAnimatedTransitioning>


@end

@interface CATAreaDismissAnimation : NSObject <UIViewControllerAnimatedTransitioning>


@end

NS_ASSUME_NONNULL_END
