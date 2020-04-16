//
//  CATSettingViewController.h
//  CATContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "CATConfig.h"
@import CATBridge;
@import CATTable;

NS_ASSUME_NONNULL_BEGIN

@interface CATSettingTableViewCell : CATBaseTableViewCell

@property (nonatomic ,strong) CATSettingBean *setting;

@end

typedef void(^CATSettingBlock)(CATSettingActionType actionType ,CATBaseViewController *from);

@interface CATSettingViewController : CATTableNoLoadingViewController

+ (instancetype)createSettingWithBlock:(CATSettingBlock) block;

- (void)updateTableData;
@end

NS_ASSUME_NONNULL_END
