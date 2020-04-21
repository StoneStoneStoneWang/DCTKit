//
//  DCTAddressEditViewController.h
//  ZFragment
//
//  Created by three stone 王 on 2020/3/21.
//  Copyright © 2020 three stone 王. All rights reserved.
//

@import DCTTable;
#import "DCTConfig.h"
@import DCTBean;
@import DCTBridge;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger ,DCTAddressEditActionType) {
    
    DCTAddressEditActionTypeArea,
    
    DCTAddressEditActionTypeCompleted
};

typedef void(^DCTAddressEditBlock)(DCTBaseViewController *from,DCTAddressEditActionType actionType, DCTAddressBean *_Nullable addressBean ,DCTAddressEditBean *_Nullable addressEditBean);

@interface DCTAddressEditTableViewCell : DCTBaseTableViewCell


@end

@interface DCTAddressEditViewController : DCTTableNoLoadingViewController

+ (instancetype)creatAddressEditWithAddressBean:(DCTAddressBean *_Nullable)addressBean andAddressEditBlock:(DCTAddressEditBlock) block ;

- (void)updateAddressEditArea:(DCTAddressEditBean *) addressEditBean;

@end

NS_ASSUME_NONNULL_END
