//
//  DCTAddressSelectedViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//
#import "DCTConfig.h"
@import DCTTable;
@import DCTBean;
@import DCTBridge;
NS_ASSUME_NONNULL_BEGIN

typedef void(^DCTAddressSelectedBlock)(DCTAddressActionType actionType,DCTAddressBean *_Nullable address ,NSIndexPath *_Nullable ip ,DCTBaseViewController *from);

@interface DCTAddressSelectedViewController : DCTTableLoadingViewController

+ (instancetype)createAddressSelectedWithBlock:(DCTAddressSelectedBlock) addressBlock;

- (void)updateAddress:(DCTAddressBean *)addressBean andIp:(NSIndexPath *)ip;

- (void)insertAddress:(DCTAddressBean *)addressBean;

@end

NS_ASSUME_NONNULL_END
