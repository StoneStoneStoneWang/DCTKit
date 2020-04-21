//
//  DCTModifyPasswordViewController.h
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "DCTConfig.h"
@import DCTBridge;
@import DCTTransition;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , DCTModifyPasswordActionType) {
    
     DCTModifyPasswordActionTypeBack,
    
     DCTModifyPasswordActionTypeModify
};

typedef void(^DCTModifyPasswordBlock)(DCTBaseViewController *password ,DCTModifyPasswordActionType actionType);
@interface DCTModifyPasswordViewController : DCTTViewController

+ (instancetype)createPasswordWithBlock:(DCTModifyPasswordBlock )block;
@end

NS_ASSUME_NONNULL_END
