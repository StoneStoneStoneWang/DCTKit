//
//  CATModifyPasswordViewController.h
//  CATContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "CATConfig.h"
@import CATBridge;
@import CATTransition;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , CATModifyPasswordActionType) {
    
     CATModifyPasswordActionTypeBack,
    
     CATModifyPasswordActionTypeModify
};

typedef void(^CATModifyPasswordBlock)(CATBaseViewController *password ,CATModifyPasswordActionType actionType);
@interface CATModifyPasswordViewController : CATTViewController

+ (instancetype)createPasswordWithBlock:(CATModifyPasswordBlock )block;
@end

NS_ASSUME_NONNULL_END
