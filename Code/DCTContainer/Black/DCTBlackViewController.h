//
//  DCTBlackViewController.h
//  DCTContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "DCTConfig.h"
@import DCTBridge;
@import DCTTable;
@import DCTBean;

NS_ASSUME_NONNULL_BEGIN

@interface DCTBlackTableViewCell : DCTBaseTableViewCell

@property (nonatomic ,strong) DCTBlackBean *black;

@end
typedef void(^DCTBlackBlock)(void);
@interface DCTBlackViewController : DCTTableLoadingViewController

+ (instancetype)createBlackWithBlock:(DCTBlackBlock) block;

@end

NS_ASSUME_NONNULL_END
