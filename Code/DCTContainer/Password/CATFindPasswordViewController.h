//
//  CATFindPasswordViewController.h
//  CATContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "CATConfig.h"
@import CATBridge;
@import CATTransition;
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger , CATFindPasswordActionType) {
    
     CATFindPasswordActionTypeBack,
    
     CATFindPasswordActionTypeFind
};

typedef void(^CATFindPassworBlock)(CATBaseViewController *from ,CATFindPasswordActionType actionType);
@interface CATFindPasswordViewController : CATTViewController

+ (instancetype)createPasswordWithBlock:(CATFindPassworBlock )block;

@end

NS_ASSUME_NONNULL_END
