//
//  DCTAreaHeaderViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//


#import "DCTConfig.h"
@import DCTCollection;
@import DCTBean;
NS_ASSUME_NONNULL_BEGIN

typedef void(^DCTAreaHeaderBlock)(DCTBaseViewController *from ,DCTAreaBean *pArea ,DCTAreaBean *cArea ,DCTAreaBean *_Nullable rArea);

@interface DCTAreaHeaderViewController : DCTCollectionNoLoadingViewController

+ (instancetype)createAreaHeaderWithPid:(NSInteger)pid andCid:(NSInteger)cid andRid:(NSInteger )rid andAreaHeaderBlock:(DCTAreaHeaderBlock) block;

@end

@interface DCTAreaPresentAnimation : NSObject <UIViewControllerAnimatedTransitioning>


@end

@interface DCTAreaDismissAnimation : NSObject <UIViewControllerAnimatedTransitioning>


@end

NS_ASSUME_NONNULL_END
