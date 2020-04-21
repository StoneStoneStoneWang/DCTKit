//
//  DCTFeedBackViewController.h
//  DCTContainer
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "DCTConfig.h"
@import DCTBridge;
@import DCTTransition;

NS_ASSUME_NONNULL_BEGIN

typedef void(^DCTFeedBackBlock)(DCTBaseViewController *from);

@interface DCTFeedBackViewController : DCTTViewController

+ (instancetype)createFeedBackWithBlock:(DCTFeedBackBlock)block;

@end

NS_ASSUME_NONNULL_END
