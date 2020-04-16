//
//  CATAddressSelectedViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//
#import "CATConfig.h"
@import CATTable;
@import CATBean;
@import CATBridge;
NS_ASSUME_NONNULL_BEGIN

typedef void(^CATAddressSelectedBlock)(CATAddressActionType actionType,CATAddressBean *_Nullable address ,NSIndexPath *_Nullable ip ,CATBaseViewController *from);

@interface CATAddressSelectedViewController : CATTableLoadingViewController

+ (instancetype)createAddressSelectedWithBlock:(CATAddressSelectedBlock) addressBlock;

- (void)updateAddress:(CATAddressBean *)addressBean andIp:(NSIndexPath *)ip;

- (void)insertAddress:(CATAddressBean *)addressBean;

@end

NS_ASSUME_NONNULL_END
