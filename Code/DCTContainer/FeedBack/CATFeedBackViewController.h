//
//  CATFeedBackViewController.h
//  CATContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "CATConfig.h"
@import CATBridge;
@import CATTransition;

NS_ASSUME_NONNULL_BEGIN

typedef void(^CATFeedBackBlock)(CATBaseViewController *from);

@interface CATFeedBackViewController : CATTViewController

+ (instancetype)createFeedBackWithBlock:(CATFeedBackBlock)block;

@end

NS_ASSUME_NONNULL_END
