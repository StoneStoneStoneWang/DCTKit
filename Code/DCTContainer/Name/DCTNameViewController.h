//
//  DCTNameViewController.h
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "DCTConfig.h"
@import DCTBridge;
@import DCTTransition;

NS_ASSUME_NONNULL_BEGIN

typedef void(^DCTNameBlock)(DCTNameActionType actionType ,DCTBaseViewController *from);

@interface DCTNameViewController : DCTTViewController

+ (instancetype)createNickNameWithBlock:(DCTNameBlock)block;

@end

NS_ASSUME_NONNULL_END
