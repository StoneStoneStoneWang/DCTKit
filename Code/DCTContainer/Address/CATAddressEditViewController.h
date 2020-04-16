//
//  CATAddressEditViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

@import CATTable;
#import "CATConfig.h"
@import CATBean;
@import CATBridge;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,CATAddressEditActionType) {
    
    CATAddressEditActionTypeArea,
    
    CATAddressEditActionTypeCompleted
};

typedef void(^CATAddressEditBlock)(CATBaseViewController *from,CATAddressEditActionType actionType, CATAddressBean *_Nullable addressBean ,CATAddressEditBean *_Nullable addressEditBean);

@interface CATAddressEditTableViewCell : CATBaseTableViewCell


@end

@interface CATAddressEditViewController : CATTableNoLoadingViewController

+ (instancetype)creatAddressEditWithAddressBean:(CATAddressBean *_Nullable)addressBean andAddressEditBlock:(CATAddressEditBlock) block ;

- (void)updateAddressEditArea:(CATAddressEditBean *) addressEditBean;

@end

NS_ASSUME_NONNULL_END
