//
//  CATFocusViewController.h
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

@interface CATFocusTableViewCell : CATBaseTableViewCell

@property (nonatomic ,strong) CATFocusBean *focus;

@end
typedef void(^CATFocusBlock)(void);

@interface CATFocusViewController : CATTableLoadingViewController

+ (instancetype)createBlackWithBlock:(CATFocusBlock) block;

@end

NS_ASSUME_NONNULL_END
