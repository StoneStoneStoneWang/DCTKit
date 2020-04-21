//
//  DCTSettingViewController.h
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#import "DCTConfig.h"
@import DCTBridge;
@import DCTTable;

NS_ASSUME_NONNULL_BEGIN

@interface DCTSettingTableViewCell : DCTBaseTableViewCell

@property (nonatomic ,strong) DCTSettingBean *setting;

@end

typedef void(^DCTSettingBlock)(DCTSettingActionType actionType ,DCTBaseViewController *from);

@interface DCTSettingViewController : DCTTableNoLoadingViewController

+ (instancetype)createSettingWithBlock:(DCTSettingBlock) block;

- (void)updateTableData;
@end

NS_ASSUME_NONNULL_END
