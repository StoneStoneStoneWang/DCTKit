//
//  DCTRegViewController.h
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "DCTConfig.h"
@import DCTBridge;
@import DCTTransition;

NS_ASSUME_NONNULL_BEGIN
typedef void(^DCTRegBlock)(DCTRegActionType actionType ,DCTBaseViewController *from);
@interface DCTRegViewController : DCTTViewController

+ (instancetype)createRegWithBlock:(DCTRegBlock) block;
@end

NS_ASSUME_NONNULL_END
