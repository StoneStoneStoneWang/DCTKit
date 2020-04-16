//
//  CATBlackViewController.h
//  CATContainer
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "CATConfig.h"
@import CATBridge;
@import CATTable;
@import CATBean;

NS_ASSUME_NONNULL_BEGIN

@interface CATBlackTableViewCell : CATBaseTableViewCell

@property (nonatomic ,strong) CATBlackBean *black;

@end
typedef void(^CATBlackBlock)(void);
@interface CATBlackViewController : CATTableLoadingViewController

+ (instancetype)createBlackWithBlock:(CATBlackBlock) block;

@end

NS_ASSUME_NONNULL_END
