//
//  DCTFindPasswordViewController.h
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "DCTConfig.h"
@import DCTBridge;
@import DCTTransition;
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger , DCTFindPasswordActionType) {
    
     DCTFindPasswordActionTypeBack,
    
     DCTFindPasswordActionTypeFind
};

typedef void(^DCTFindPassworBlock)(DCTBaseViewController *from ,DCTFindPasswordActionType actionType);
@interface DCTFindPasswordViewController : DCTTViewController

+ (instancetype)createPasswordWithBlock:(DCTFindPassworBlock )block;

@end

NS_ASSUME_NONNULL_END
