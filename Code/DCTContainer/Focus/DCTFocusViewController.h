//
//  DCTFocusViewController.h
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

@interface DCTFocusTableViewCell : DCTBaseTableViewCell

@property (nonatomic ,strong) DCTFocusBean *focus;

@end
typedef void(^DCTFocusBlock)(void);

@interface DCTFocusViewController : DCTTableLoadingViewController

+ (instancetype)createBlackWithBlock:(DCTFocusBlock) block;

@end

NS_ASSUME_NONNULL_END
